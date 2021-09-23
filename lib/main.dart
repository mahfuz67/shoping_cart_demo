import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Routes/router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[800],
      ),
      navigatorKey: navigatorKey,
      title: 'Shopping Cart',
      initialRoute: '/',
      onGenerateRoute: (route) => CustomRouter.generateRoutes(route),
      debugShowCheckedModeBanner: false,
    );
  }
}
