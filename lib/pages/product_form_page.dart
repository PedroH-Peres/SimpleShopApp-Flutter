import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulário')),
      body: Padding( padding: EdgeInsets.all(20),
        child: Form(
          child: ListView(children: [
            TextFormField(decoration: InputDecoration(labelText: 'Nome'), textInputAction: TextInputAction.next,)
          ],),
        ),
      ),
    );
  }
}