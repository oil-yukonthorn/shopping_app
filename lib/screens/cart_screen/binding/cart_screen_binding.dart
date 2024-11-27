import 'package:get/get.dart';
import 'package:shopping_app/screens/cart_screen/controllers/cart_screen_controller.dart';

class CartScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartScreenController());
  }
}
