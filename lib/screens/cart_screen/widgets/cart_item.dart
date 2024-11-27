import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/formatter/number_input_formatter.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/screens/cart_screen/controllers/cart_screen_controller.dart';

class CartItem extends StatelessWidget {
  final Product product;
  final CartScreenController controller;

  const CartItem({
    super.key,
    required this.product,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, color: Colors.indigo),
                ),
                Text(
                  "${NumberInputFormatter.formatNumber(product.price)} / unit",
                  style: const TextStyle(color: Colors.indigo),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => controller.decreaseQuantity(product),
                icon: const Icon(
                  Icons.remove_circle_sharp,
                  color: Colors.indigo,
                ),
              ),
              Obx(() => Text(
                    product.quantity.value.toString(),
                    style: const TextStyle(fontSize: 16),
                  )),
              IconButton(
                onPressed: () => controller.increaseQuantity(product),
                icon: const Icon(
                  Icons.add_circle_sharp,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
