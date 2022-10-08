import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';



class ProductList with ChangeNotifier{
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