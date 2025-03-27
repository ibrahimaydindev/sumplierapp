import 'package:flutter/material.dart';
import 'package:sumplier/screen/cart_screen/view/cart_page.dart';

import 'database/PrefHelper.dart';


Future<void> main() async {
  await PrefHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: CartPage(),
    );
  }
}