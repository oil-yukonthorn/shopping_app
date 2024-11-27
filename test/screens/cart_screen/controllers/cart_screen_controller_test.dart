import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/api/services.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/screens/cart_screen/controllers/cart_screen_controller.dart';

class MockServices extends Mock implements Services {}

void main() {
  late MockServices mockServices;

  setUp(() {
    mockServices = MockServices();
    Get.put<Services>(mockServices);
  });

  tearDown(() {
    Get.reset();
  });

  group('CartScreenController -  Order Calculation', () {
    test('Calculates subtotal, discount, and total correctly', () {
      // Arrange
      final controller = CartScreenController();
      final cart = [
        Product(id: 1, name: 'Product A', price: 200, quantity: 3),
        Product(id: 2, name: 'Product B', price: 150, quantity: 4),
        Product(id: 3, name: 'Product C', price: 100, quantity: 1),
      ];

      final subtotal = controller.calculateSubtotal(cart);
      final discount = controller.calculateDiscount(cart);
      final total = subtotal - discount;

      expect(subtotal, 1300.0); // 3*200 + 4*150 + 1*100
      expect(discount, 50.0); // 20 for Product A + 30 for Product B
      expect(total, 1250.0); // 1300 - 50
    });
  });
}
