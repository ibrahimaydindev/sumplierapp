import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumplier/Config/config.dart';
import 'package:sumplier/model/customer.dart';
import 'package:sumplier/screen/cart_screen/view/cart_page.dart';
import 'package:sumplier/screen/customer_screen/view/customer_page.dart';
import 'package:sumplier/screen/dashboard_screen/view/dashboard_page.dart';
import 'package:sumplier/screen/splash_screen/view/splash_page.dart';
import 'package:sumplier/screen/user_screen/view/user_page.dart';

import 'database/pref_helper.dart';
import 'enum/config_key.dart';
import 'api/api_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init();

  Customer? currentCustomer = PrefHelper.getModel(ConfigKey.customer.name,  (json) => Customer.fromJson(json));

  if(currentCustomer != null) {
    Config.instance.setCurrentCompany(currentCustomer);
  }

  // ApiService'i initialize et
  Get.put(ApiService());

  runApp(MyApp(initialRoute: currentCustomer != null ? '/UserPage' : '/CustomerPage'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/CustomerPage', page: () => CustomerPage()),
        GetPage(name: '/UserPage', page: () => UserPage()),
        GetPage(name: '/SplashPage', page: () => SplashPage()),
        GetPage(name: '/DashboardPage', page: () => DashboardPage()),
        GetPage(name: '/CartPage', page: () => CartPage())
      ],
    );
  }
}
