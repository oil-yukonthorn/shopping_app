import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/screens/cart_screen/controllers/cart_screen_controller.dart';
import 'package:shopping_app/screens/home_screen/controllers/home_screen_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  final homeScreenController = Get.find<HomeScreenController>();
  final cartScreenController = Get.find<CartScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
        currentIndex: homeScreenController.selectedIndex.value,
        onTap: (index) {
          if (index == 1) {
            Get.toNamed('/cart');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: homeScreenController.selectedIndex.value == 0
                ? const Icon(
                    Icons.stars_rounded,
                    color: Colors.indigo,
                  )
                : const Icon(
                    Icons.stars_rounded,
                    color: Colors.grey,
                  ),
            label: "Shopping",
          ),
          BottomNavigationBarItem(
            icon: homeScreenController.selectedIndex.value == 1
                ? const Icon(
                    Icons.stars_outlined,
                    color: Colors.indigo,
                  )
                : const Icon(
                    Icons.stars_outlined,
                    color: Colors.grey,
                  ),
            label:
                "Cart ${cartScreenController.totalQuantity > 0 ? '${'(${cartScreenController.totalQuantity}'})' : ''}",
          ),
        ],
      );
    });
  }
}
