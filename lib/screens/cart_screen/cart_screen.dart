import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopping_app/screens/cart_screen/controllers/cart_screen_controller.dart';
import 'package:shopping_app/screens/cart_screen/widgets/cart_item.dart';
import 'package:shopping_app/screens/cart_screen/widgets/cart_summary.dart';
import 'package:shopping_app/screens/cart_screen/widgets/empty_cart_widget.dart';
import 'package:shopping_app/screens/cart_screen/widgets/success_widget.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final cartController = Get.put(CartScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (cartController.isCheckoutSuccess.value) {
          cartController.resetCheckout();
        }
        return true; // Allows the pop to proceed
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
                if (cartController.isCheckoutSuccess.value) {
                  cartController.resetCheckout();
                }
              }),
        ),
        body: Obx(() {
          if (cartController.isCheckoutSuccess.value) {
            return SuccessWidget(
              onTap: () {
                Get.back();
                cartController.resetCheckout();
              },
            );
          }
          if (cartController.cart.isEmpty) {
            return const EmptyCartWidget();
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartController.cart.length,
                  itemBuilder: (context, index) {
                    final product = cartController.cart[index];
                    return Dismissible(
                      key: Key('${product.id}'),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // Reset the quantity to 0 before removing the product
                        product.quantity.value = 0;
                        cartController.cart.remove(product);
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16.0),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: CartItem(
                        product: product,
                        controller: cartController,
                      ),
                    );
                  },
                ),
              ),
              CartSummary(
                  cart: cartController.cart,
                  controller: cartController,
                  onCheckout: () async {
                    await Get.showOverlay(
                      loadingWidget: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      asyncFunction: () async {
                        try {
                          await Future.delayed(const Duration(seconds: 2));

                          await cartController.checkout();
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            'Something went wrong',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );

                          debugPrint('Checkout Error: $e');
                        }
                      },
                    );
                  }),
            ],
          );
        }),
      ),
    );
  }
}
