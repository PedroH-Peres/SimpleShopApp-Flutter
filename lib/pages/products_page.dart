import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key,});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("Gerenciar produtos"), actions: [IconButton(icon: Icon(Icons.edit),onPressed: (){Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);},)],),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (context, p) => Column(children: [
            ProductItem(product: products.items[p]),
            Divider()
          ],),

          ),
      ),
    );
  }
}