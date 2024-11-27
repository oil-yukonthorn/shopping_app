import 'package:get/get.dart';
import 'package:shopping_app/api/services.dart';
import 'package:shopping_app/models/product.dart';

class CartScreenController extends GetxController {
  final services = Get.find<Services>();

  final RxList<Product> cart = <Product>[].obs;
  var isCheckoutSuccess = false.obs;

  int get totalQuantity =>
      cart.fold(0, (sum, product) => sum + product.quantity.value);

  void addToCart(Product product) {
    final existingProduct = cart
        .firstWhereOrNull((p) => p.id == product.id && p.name == product.name);

    if (existingProduct == null) {
      cart.add(Product(
        id: product.id,
        name: product.name,
        price: product.price,
        quantity: 1,
      ));
    } else {
      existingProduct.quantity++;
      cart.refresh();
    }
  }

  void increaseQuantity(Product product) {
    final cartProduct =
        cart.firstWhere((p) => p.id == product.id && p.name == product.name);
    cartProduct.quantity++;
    cart.refresh();
  }

  void decreaseQuantity(Product product) {
    final cartProduct =
        cart.firstWhere((p) => p.id == product.id && p.name == product.name);

    if (cartProduct.quantity > 1) {
      cartProduct.quantity--;
    } else {
      cart.remove(cartProduct);
    }
    cart.refresh();
  }

  void clearCart() {
    for (var product in cart) {
      product.quantity.value = 0;
    }
    cart.clear();
  }

  Future<void> checkout() async {
    try {
      if (cart.isNotEmpty) {
        final cartIds = cart.map((element) => element.id).toList();

        final body = {"products": cartIds};

        await services.orderCheckout(body);
        isCheckoutSuccess.value = true;
        clearCart();
      }
    } catch (e) {
      rethrow;
    }
  }

  void resetCheckout() {
    isCheckoutSuccess.value = false;
  }

  double calculateSubtotal(List<Product> cart) {
    return cart.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity.value),
    );
  }

  double calculateDiscount(List<Product> cart, {double discountRate = 0.05}) {
    double totalDiscount = 0.0;

    for (var item in cart) {
      final int quantity = item.quantity.value;
      final num price = item.price;

      // ตรวจสอบข้อมูลให้แน่ใจว่าถูกต้อง
      if (quantity <= 0 || price <= 0) {
        print("Invalid item: Quantity=$quantity, Price=$price");
        continue; // ข้ามสินค้าที่ข้อมูลไม่ถูกต้อง
      }

      // คำนวณจำนวนคู่ (Pairs)
      final int pairs = quantity ~/ 2;

      // ราคารวมของคู่
      final double pairTotalPrice = pairs * (price * 2);

      // ส่วนลดสำหรับคู่
      final double discount = pairTotalPrice * discountRate;

      print("Product: ${item.name}, Quantity: $quantity, Pairs: $pairs");
      print("Pair Total Price: $pairTotalPrice, Discount: $discount");

      totalDiscount += discount; // รวมส่วนลดทั้งหมด
    }

    return totalDiscount;
  }
}
