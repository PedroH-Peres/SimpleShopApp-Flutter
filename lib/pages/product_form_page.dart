import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop/models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

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

  void _submitForm(){
    final isValid = _formKey.currentState?.validate() ?? false;

    if(!isValid){
      return;
    }

    _formKey.currentState?.save();
    final newProduct = Product(
      id: Random().nextDouble() as String,
      name: _formData['name'].toString() as String,
      description: _formData['description'].toString() as String, 
      imageUrl: _formData['url'].toString() as String, 
      price: double.parse(_formData['price'].toString()) as double
      );
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
              focusNode: _priceFocus, 
              textInputAction: TextInputAction.next,  
              onFieldSubmitted: (_) {FocusScope.of(context).requestFocus(_descriptionFocus);},
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSaved: (price) => _formData['price'] = double.parse(price ?? '0'),
            ),
            TextFormField(decoration: InputDecoration(labelText: 'Descrição'),
              focusNode: _descriptionFocus, 
              keyboardType: TextInputType.multiline, 
              maxLines: 3,
              onSaved: (desc) => _formData['description'] = desc ?? '',
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
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
                  child: _imageUrlController.text.isEmpty ? Text('Informe a Url') : FittedBox(child: Image.network(_imageUrlController.text), fit: BoxFit.fill,),
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