import 'package:flutter/material.dart';
import 'package:shoping_cart/Routes/routes.dart';
import 'package:shoping_cart/views/cart_view.dart';
import 'package:shoping_cart/views/home_view.dart';

class CustomRouter {
  static generateRoutes(route) {
    switch (route.name) {
      case CustomRoutes.initRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => HomeView(),
          settings:route,
        );
      case CustomRoutes.cartRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => CartView(),
          settings:route,
        );
      default:
        break;
    }
  }
}
