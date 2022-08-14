import 'package:flutter/cupertino.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';



class ProductList with ChangeNotifier{
  List<Product> _items = DUMMY_PRODUCTS;
  bool _showFavoriteOnly = false;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems => [..._items.where((element) => element.isFavorite).toList()];
  
   

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