import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shoping_cart/Data/products.dart';
import 'package:shoping_cart/database/database_helper.dart';
import 'package:shoping_cart/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsHelperUtility {
  static Future<List<Product>> addProducts() async {
    List<Product> theProducts = await fetchData();
    theProducts.forEach((product) async {
      await DatabaseHelper.instance.insertProduct(product);
    });
    return theProducts;
  }

  static Future<List<Product>> fetchData() async {
    String url = 'http://192.168.43.63:8050/product.json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return parseResponse(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  static List<Product> parseResponse(String responseBody) {
    return productFromJson(responseBody);
  }
}
