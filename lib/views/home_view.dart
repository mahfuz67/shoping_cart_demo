import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shoping_cart/database/database_helper.dart';
import 'package:shoping_cart/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:shoping_cart/providers/providers.dart';
import 'package:shoping_cart/utils/products_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: products(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Cart demo"),
                  centerTitle: true,
                ),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: const <Widget>[
                      DrawerHeader(
                        child: Text(
                          'Drawer Header',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.message),
                        title: Text('Messages'),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('Profile'),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                      ),
                    ],
                  ),
                ),
                body: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.5,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 300.0,
                        child: Card(
                            key: Key(index.toString() + Random().nextInt(200).toString()),
                            elevation: 5.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: 150.0,
                                    width: 175.0,
                                    child: Image.asset(
                                      "assets/shoe.jpg",
                                      fit: BoxFit.fill,
                                    )),
                                Text(snapshot.data![index].description),
                                Text(snapshot.data![index].price),
                                TextButton(onPressed: () {}, child: Text('Add To Cart'))
                              ],
                            )),
                      );
                    }));
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Text(
                  'loading...',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            );
          }
        });
  }

  Future<List<Product>> products() async {
    List<Product> products = [];
    List<Product>? productFromDb = await DatabaseHelper.instance.getProducts();
    if (productFromDb != null) {
      products = productFromDb;
      navigatorKey.currentContext!.read(Providers.homeProvider).listOfAllProducts(productFromDb);
    } else {
      products = await ProductsHelperUtility.addProducts();
      navigatorKey.currentContext!.read(Providers.homeProvider).listOfAllProducts(products);
    }
    return products;
  }
}
