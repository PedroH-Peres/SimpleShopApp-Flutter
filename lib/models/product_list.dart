import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';



class ProductList with ChangeNotifier{
  final _baseUrl = 'https://shop-playyy-default-rtdb.firebaseio.com/produtos.json';

  List<Product> _items = DUMMY_PRODUCTS;
  bool _showFavoriteOnly = false;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems => [..._items.where((element) => element.isFavorite).toList()];
  
  int get itemsCount {
    return _items.length;
  }

  void removeProduct(Product product){
    int index = _items.indexWhere((p) => p.id == product.id);
    if(index >= 0){
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  Future<void> loadProducts() async{
    final response = await http.get(Uri.parse(_baseUrl));
    print(jsonDecode(response.body));
  }
  
  Future<void> saveProduct(Map<String, Object> data){
    bool hasId = data['id'] != null;

    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String, 
      imageUrl: data['url'] as String, 
      price: data['price'] as double
      );

      if(hasId){
        return updateProduct(newProduct);
      }else{
        return addProduct(newProduct);
      }
  }

  Future<void> updateProduct(Product product){
    int index = _items.indexWhere((p) => p.id == product.id);

    if(index >= 0){
      _items[index] = product;
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> addProduct(Product product) async{
    final response = await http.post(
      Uri.parse(_baseUrl),
      body: jsonEncode({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite
      })
    );

    final id = jsonDecode(response.body)['name'];
      _items.add(Product(id: id, name: product.name, description: product.description, imageUrl: product.imageUrl,
       price: product.price, isFavorite: product.isFavorite));
      notifyListeners();
    
  }
}

/*
List<Product> _items = DUMMY_PRODUCTS;
  bool _showFavoriteOnly = false;

  List<Product> get items {
    if(_showFavoriteOnly){
      return [..._items.where((element) => element.isFavorite).toList()];
    }else{
      return [..._items];
    }
    
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }
  void showAll(){
    _showFavoriteOnly = false;
    notifyListeners();
  }
  */