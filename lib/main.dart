import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleshopflutter/models/auth.dart';
import 'package:simpleshopflutter/pages/auth_or_home_page.dart';
import 'package:simpleshopflutter/pages/auth_page.dart';
import 'package:simpleshopflutter/pages/cart_page.dart';
import 'package:simpleshopflutter/pages/orders_page.dart';
import 'package:simpleshopflutter/pages/product_detail_page.dart';
import 'package:simpleshopflutter/pages/product_form_page.dart';
import 'package:simpleshopflutter/pages/products_overview_page.dart';
import 'package:simpleshopflutter/pages/products_page.dart';
import 'package:simpleshopflutter/utils/app_routes.dart';

import 'models/cart.dart';
import 'models/order_list.dart';
import 'models/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList('', []),
          update: (ctx, auth, previous) {
            return ProductList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato',
        ),
        //home: const ProductsOverviewPage(),
        routes: { 
          AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
          AppRoutes.cart: (ctx) => const CartPage(),
          AppRoutes.orders: (ctx) =>  OrdersPage(),
          AppRoutes.products: (ctx) => const ProductsPage(),
          AppRoutes.productForm: (ctx) => const ProductFormPage(),
          AppRoutes.authOrHome: (ctx) => const AuthOrHomePage()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
