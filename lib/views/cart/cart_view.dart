import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoping_cart/providers/providers.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'),
        centerTitle: true,
      ),
      body: Container(
        child: Consumer(
          builder: (context, watch, child) {
            final cartProvider = watch(Providers.cartProvider);
            final productsInCart = cartProvider.allProductsInCart;
            return productsInCart?.length == 0
                ? Center(child: Text("no item in cart"))
                : ListView.builder(
                    itemCount: productsInCart?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        key: Key(productsInCart![index].prodId),
                        title: Text(productsInCart[index].title),
                        subtitle: Text(productsInCart[index].description),
                      );
                    });
          },
        ),
      ),
    );
  }
}
