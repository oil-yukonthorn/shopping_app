import 'package:get/get.dart';
import 'package:shopping_app/api/services.dart';
import 'package:shopping_app/models/product.dart';

class ProductListScreenController extends GetxController {
  final services = Get.find<Services>();

  final RxList<Product> recommendedProducts = <Product>[].obs;
  final RxList<Product> latestProducts = <Product>[].obs;

  final RxBool isLoadingRecommendProducts = false.obs;
  final RxBool isLoadingLatestProducts = false.obs;

  RxBool refreshTrigger = false.obs;

  String? nextCursor;

  Future<void> fetchRecommendProducts() async {
    try {
      isLoadingRecommendProducts.value = true;
      final products = await services.fetchRecommendProducts();
      recommendedProducts.assignAll(products);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingRecommendProducts.value = false;
    }
  }

  Future<void> fetchLatestProducts({bool isInitialLoad = false}) async {
    if (isLoadingLatestProducts.value) {
      return;
    }

    try {
      isLoadingLatestProducts.value = true;

      final products = await services.fetchLatestProducts(
          cursor: isInitialLoad ? null : nextCursor);

      if (isInitialLoad) {
        latestProducts.assignAll(products.items);
      } else {
        latestProducts.addAll(products.items);
      }

      nextCursor = products.nextCursor;
    } catch (e) {
      rethrow;
    } finally {
      isLoadingLatestProducts.value = false;
    }
  }

  void triggerRefresh() {
    refreshTrigger.value = !refreshTrigger.value;
  }
}
