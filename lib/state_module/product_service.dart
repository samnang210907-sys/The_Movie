import 'dart:convert';
import 'package:http/http.dart' as http;

import 'product_model.dart';

class ProductService {
  Future<List<ProductModel>> search(String title) async {
    if (title.isEmpty) {
      return [];
    }

    try {
      final response = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/products/?title=$title'),
      );
      if (response.statusCode == 200) {
        final list = jsonDecode(response.body) as List<dynamic>;
        return list
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("Error status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductModel>> readApiData() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/products'),
      );
      if (response.statusCode == 200) {
        final list = jsonDecode(response.body) as List<dynamic>;
        return list
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw Exception("Error status code: ${response.statusCode}");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}