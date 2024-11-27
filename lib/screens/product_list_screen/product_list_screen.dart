import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/screens/cart_screen/controllers/cart_screen_controller.dart';
import 'package:shopping_app/screens/product_list_screen/controllers/product_list_screen_controller.dart';
import 'package:shopping_app/screens/product_list_screen/widgets/error_widget_with_retry.dart';
import 'package:shopping_app/screens/product_list_screen/widgets/product_item.dart';
import 'package:shopping_app/screens/product_list_screen/widgets/product_item_skeleton.dart';
import 'package:shopping_app/screens/product_list_screen/widgets/product_list_view.dart';
import 'package:shopping_app/screens/product_list_screen/widgets/section_title.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});

  final controller = Get.find<ProductListScreenController>();
  final cartScreenController = Get.find<CartScreenController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    controller.fetchLatestProducts(isInitialLoad: true);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !controller.isLoadingLatestProducts.value &&
          controller.nextCursor != null) {
        controller.fetchLatestProducts();
      }
    });

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(title: "Recommend Product"),
                    Obx(() {
                      controller.refreshTrigger.value;
                      return FutureBuilder(
                        future: controller.fetchRecommendProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ProductListView(
                              isLoading: true,
                              itemCount: 4,
                              itemBuilder: (context, index) =>
                                  const ProductItemSkeleton(),
                            );
                          } else if (snapshot.hasError) {
                            return ErrorWidgetWithRetry(
                              errorMessage:
                                  "Failed to load recommended products.",
                              onRetry: controller.triggerRefresh,
                            );
                          } else {
                            return Obx(() => ProductListView(
                                  isLoading: false,
                                  itemCount:
                                      controller.recommendedProducts.length < 4
                                          ? controller
                                              .recommendedProducts.length
                                          : 4,
                                  itemBuilder: (context, index) {
                                    final product =
                                        controller.recommendedProducts[index];
                                    return ProductItem(
                                      product: product,
                                      controller: cartScreenController,
                                    );
                                  },
                                ));
                          }
                        },
                      );
                    }),
                    const SizedBox(height: 24),
                    const SectionTitle(title: "Latest Products"),
                  ],
                ),
              ),
              Obx(() {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < controller.latestProducts.length) {
                        final product = controller.latestProducts[index];
                        return ProductItem(
                          product: product,
                          controller: cartScreenController,
                        );
                      } else if (controller.isLoadingLatestProducts.value) {
                        return ProductListView(
                          isLoading: true,
                          itemCount: 6,
                          itemBuilder: (context, index) =>
                              const ProductItemSkeleton(),
                        );
                      }

                      return null;
                    },
                    childCount: controller.latestProducts.length +
                        (controller.isLoadingLatestProducts.value ? 1 : 0),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
