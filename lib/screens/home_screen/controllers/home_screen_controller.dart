import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  // Current selected index
  var selectedIndex = 0.obs;

  // Update selected index
  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
