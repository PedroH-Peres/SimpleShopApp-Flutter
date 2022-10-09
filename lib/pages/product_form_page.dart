import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';


class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();  

    if(_formData.isEmpty){
      final arg = ModalRoute.of(context)?.settings.arguments;
      if(arg!=null){
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;
        _formData['description'] = product.description;
        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void initState(){
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }
  
  @override
  void dispose(){
    super.dispose();
    _priceFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
  }

  void updateImage(){
    setState(() {});
  }

  bool isValidUrl(String url){
    bool isValidImageUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
    url.toLowerCase().endsWith('.jpg') ||
    url.toLowerCase().endsWith('.jpeg');

    return isValidImageUrl && endsWithFile;
  }

  void _submitForm(){
    final isValid = _formKey.currentState?.validate() ?? false;

    if(!isValid){
      return;
    }

    _formKey.currentState?.save();
    
      Provider.of<ProductList>(context, listen: false).saveProduct(_formData);
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulário'),
       actions: [
        IconButton(onPressed: _submitForm, icon: Icon(Icons.save))
       ],
      ),
      body: Padding( padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(decoration: InputDecoration(labelText: 'Nome'), 
              initialValue: _formData['name']?.toString(),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_){FocusScope.of(context).requestFocus(_priceFocus);},
              onSaved: (name) => _formData['name'] = name ?? '',
              validator: (_name) {
                final nome = _name ?? '';
                if(nome.trim().isEmpty){
                  return 'Campo Obrigatório';
                }
                if(nome.trim().length < 3){
                  return 'O nome deve conter ao menos 3 letras';
                }

                return null;
              },
            ),
            TextFormField(decoration: InputDecoration(labelText: 'Preço'), 
              initialValue: _formData['price']?.toString(),
              focusNode: _priceFocus, 
              textInputAction: TextInputAction.next,  
              onFieldSubmitted: (_) {FocusScope.of(context).requestFocus(_descriptionFocus);},
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSaved: (price) => _formData['price'] = double.parse(price ?? '0'),
              validator: (_price){
                final priceStr = _price ??'';
                final price = double.tryParse(priceStr) ?? -1;
                if(price <= 0){
                  return "Digite um valor válido!";
                }
                return null;
              },
            ),
            TextFormField(decoration: InputDecoration(labelText: 'Descrição'),
              initialValue: _formData['description']?.toString(),
              focusNode: _descriptionFocus, 
              keyboardType: TextInputType.multiline, 
              maxLines: 3,
              onSaved: (desc) => _formData['description'] = desc ?? '',
              validator: (_desc) {
                final desc = _desc ?? '';
                if(desc.trim().isEmpty){
                  return 'Campo obrigatório';
                }
                if(desc.trim().length < 10){
                  return 'A descrição deve conter ao menos 10 caracteres';
                }

                return null;
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(decoration: InputDecoration(labelText: 'Url da imagem'),
                  focusNode: _imageUrlFocus, 
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  controller: _imageUrlController,
                  onFieldSubmitted: (_) => _submitForm(),
                  onSaved: (url) => _formData['url'] = url ?? '',
                  validator: (_imageUrl) {
                    final imageUrl = _imageUrl ?? '';
                    if(!isValidUrl(imageUrl)){
                      return "Informe uma url válida! (.png, .jpg, .jpeg)";
                    }
                    return null;
                  },
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 10, left: 10, ),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
                  child: _imageUrlController.text.isEmpty ? Text('Informe a Url') 
                  : Container(width: 100, height: 100,child: FittedBox(child: Image.network(_imageUrlController.text), fit: BoxFit.cover,)),
                  alignment: Alignment.center,
                )
              ]
            ),
          ],),
        ),
      ),
    );
  }
}