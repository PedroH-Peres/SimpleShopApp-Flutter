import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';



class ProductList with ChangeNotifier{
  final _baseUrl = 'https://shop-playyy-default-rtdb.firebaseio.com/';

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
  
  void saveProduct(Map<String, Object> data){
    bool hasId = data['id'] != null;

    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String, 
      imageUrl: data['url'] as String, 
      price: data['price'] as double
      );

      if(hasId){
        updateProduct(newProduct);
      }else{
        addProduct(newProduct);
      }
  }

  void updateProduct(Product product){
    int index = _items.indexWhere((p) => p.id == product.id);

    if(index >= 0){
      _items[index] = product;
      notifyListeners();
    }

  }

  void addProduct(Product product){
    http.post(
      Uri.parse('$_baseUrl/produtos.json'),
      body: jsonEncode({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite
      })
    );
    _items.add(product);
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