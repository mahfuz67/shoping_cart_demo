

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Product {

  Product({
    required this.prodId,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  String prodId;
  String title;
  String description;
  String price;
  dynamic imageUrl;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    prodId: json["prodId"],
      title: json["title"],
      price: json["price"],
      description: json["description"],
      imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "prodId": prodId,
    "title": title,
    "price": price,
    "description": description,
    "imageUrl": imageUrl,
  };


}
