import 'dart:convert';
import 'package:badinan_mobile_app/model/product.dart';
import 'package:http/http.dart' as http;


class ProductService {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://api.example.com/products'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Product> products = List<Product>.from(l.map((model)=> Product.fromJson(model)));

      return products;
    } else {
      throw Exception('Ürünler yüklenemedi.');
    }
  }
}