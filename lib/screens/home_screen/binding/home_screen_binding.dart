import 'package:get/get.dart';
import 'package:shopping_app/screens/home_screen/controllers/home_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
  }
}
