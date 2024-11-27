import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/api/api_client.dart';
import 'package:shopping_app/screens/cart_screen/binding/cart_screen_binding.dart';
import 'package:shopping_app/screens/cart_screen/cart_screen.dart';
import 'package:shopping_app/screens/home_screen/binding/home_screen_binding.dart';
import 'package:shopping_app/screens/home_screen/home_screen.dart';
import 'package:shopping_app/screens/product_list_screen/binding/product_list_screen_binding.dart';
import 'package:shopping_app/screens/product_list_screen/product_list_screen.dart';

import 'api/services.dart';
import 'dart:io';

void main() {
  final String baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:8080' //  Android emulator
      : 'http://localhost:8080'; //  iOS simulator

  final apiClient = ApiClient(baseUrl: baseUrl);
  Get.put(Services(apiClient: apiClient));

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    getPages: [
      GetPage(
        name: '/home',
        page: () => HomeScreen(),
        binding: HomeScreenBinding(),
      ),
      GetPage(
        name: '/shopping',
        page: () => ProductListScreen(),
        binding: ProductListScreenBinding(),
      ),
      GetPage(
        name: '/cart',
        page: () => CartScreen(),
        binding: CartScreenBinding(),
      ),
    ],
  ));
}
