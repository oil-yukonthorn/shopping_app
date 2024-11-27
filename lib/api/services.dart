import 'package:shopping_app/api/api_client.dart';
import 'package:shopping_app/models/product.dart';

class Services {
  final ApiClient apiClient;

  Services({required this.apiClient});

  Future<ProductListResponse> fetchLatestProducts(
      {int limit = 20, String? cursor}) async {
    try {
      final queryParams = {'limit': limit.toString()};
      if (cursor != null) {
        queryParams['cursor'] = cursor;
      }

      final endpoint =
          Uri(path: '/products', queryParameters: queryParams).toString();

      final jsonData = await apiClient.get(endpoint);

      return ProductListResponse.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to fetch latest products: $e');
    }
  }

  Future<List<Product>> fetchRecommendProducts() async {
    try {
      final endpoint = Uri(path: '/recommended-products').toString();

      final jsonData = await apiClient.get(endpoint);
      return List.generate(
              jsonData.length, (index) => Product.fromJson(jsonData[index]))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch recommned products: $e');
    }
  }

  Future<void> orderCheckout(Map<String, dynamic>? body) async {
    try {
      final endpoint = Uri(path: '/orders/checkout').toString();
      print(body);
      await apiClient.post(endpoint, body: body);
    } catch (e) {
      throw Exception('Failed to order checkout: $e');
    }
  }
}
