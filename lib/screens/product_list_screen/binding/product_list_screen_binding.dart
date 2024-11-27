import 'package:get/get.dart';
import 'package:shopping_app/screens/product_list_screen/controllers/product_list_screen_controller.dart';

class ProductListScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductListScreenController());
  }
}
