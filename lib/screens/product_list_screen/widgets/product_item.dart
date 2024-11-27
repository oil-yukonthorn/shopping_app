import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/screens/cart_screen/controllers/cart_screen_controller.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final CartScreenController controller;

  const ProductItem({
    super.key,
    required this.product,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cartProduct = controller.cart.firstWhereOrNull(
          (p) => p.id == product.id && p.name == product.name);

      return ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        title: Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${product.price.toStringAsFixed(2)} / unit",
          style: const TextStyle(color: Colors.indigo, fontSize: 16),
        ),
        trailing: cartProduct == null
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                onPressed: () => controller.addToCart(product),
                child: const Text(
                  "Add to cart",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => controller.decreaseQuantity(product),
                    icon: const Icon(
                      Icons.remove_circle_sharp,
                      color: Colors.indigo,
                    ),
                  ),
                  Text(
                    "${cartProduct.quantity.value}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => controller.increaseQuantity(product),
                    icon: const Icon(
                      Icons.add_circle_sharp,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
