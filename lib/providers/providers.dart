import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoping_cart/view_models/cart_view_vm.dart';
import 'package:shoping_cart/view_models/home_view_vm.dart';

class Providers {
  static final homeProvider = ChangeNotifierProvider((ref) => HomeViewModel());
  static final cartProvider = ChangeNotifierProvider((ref) => CartViewModel());
}
