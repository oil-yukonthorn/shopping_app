import 'package:get/get.dart';

class Product {
  final int id;
  final String name;
  final num price;
  RxInt quantity;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      int quantity = 0})
      : quantity = RxInt(quantity);

  // Factory method to create an Item object from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'] as int? ?? 0,
    );
  }
}

class ProductListResponse {
  final List<Product> items;
  final String nextCursor;

  ProductListResponse({required this.items, required this.nextCursor});

  // Factory method to parse JSON into ItemListResponse
  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    return ProductListResponse(
      items: (json['items'] as List)
          .map((itemJson) => Product.fromJson(itemJson))
          .toList(),
      nextCursor: json['nextCursor'],
    );
  }
}
