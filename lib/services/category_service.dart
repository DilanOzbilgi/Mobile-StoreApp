import 'dart:convert';
import 'package:badinan_mobile_app/model/category.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('https://api.example.com/categories'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Category> categories = List<Category>.from(l.map((model)=> Category.fromJson(model)));

      return categories;
    } else {
      throw Exception('Kategoriler yüklenemedi.');
    }
  }
}