// fetch_product.dart
import 'dart:convert';
import 'package:bloc_project/models/models.dart';
import 'package:http/http.dart' as http;
// Import the Product model

// Function to fetch product data
Future<Product> fetchProduct() async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products'));

  if (response.statusCode == 200) {
    // Parse the JSON data and return a Product object
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load product');
  }
}
