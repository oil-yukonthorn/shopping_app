import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});
  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      // Log the request
      print('GET Request: $url');

      final response = await http.get(url);

      // Log the response status
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          return jsonDecode(response.body); // Decode the JSON response
        } else {
          return null; // Return null for empty response
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error
      print('Error in GET Request: $e');
      throw Exception('Failed to connect to API: $e');
    }
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      // Log the request
      print('POST Request: $url');
      print('Request Body: ${jsonEncode(body)}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Log the response status
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          return jsonDecode(response.body); // Decode the JSON response
        } else {
          return null; // Return null for empty response
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error
      print('Error in POST Request: $e');
      throw Exception('Failed to connect to API: $e');
    }
  }
}
