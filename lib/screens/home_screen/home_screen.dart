import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/screens/cart_screen/cart_screen.dart';
import 'package:shopping_app/screens/cart_screen/controllers/cart_screen_controller.dart';
import 'package:shopping_app/screens/home_screen/controllers/home_screen_controller.dart';
import 'package:shopping_app/screens/home_screen/widgets/custom_bottom_nav_bar.dart';
import 'package:shopping_app/screens/product_list_screen/controllers/product_list_screen_controller.dart';
import 'package:shopping_app/screens/product_list_screen/product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.find<HomeScreenController>();

  final productListScreenController = Get.put(ProductListScreenController());

  final cartScreenController = Get.put(CartScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.selectedIndex.value) {
          case 0:
            return ProductListScreen();
          case 1:
            return CartScreen();
          default:
            return const Center(child: Text('Page not found'));
        }
      }),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
