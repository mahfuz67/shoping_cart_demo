import 'package:flutter/cupertino.dart';
import 'package:shoping_cart/model/product_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<Product>? allProducts;

  Future<void> listOfAllProducts(products) async{
     allProducts = await products;
     notifyListeners();
  }
}