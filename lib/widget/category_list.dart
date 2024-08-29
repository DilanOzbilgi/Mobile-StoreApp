import 'package:badinan_mobile_app/model/category.dart';
import 'package:badinan_mobile_app/screen/product_sreen.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  // Kategoriler listesi (örnek olarak)
  final List<Category> categories = [
    Category(name: 'Elektronik', products: ['Telefon', 'Laptop', 'Tablet'], image: 'images/smartphone.jpg'),
    Category(name: 'Giyim', products: ['T-Shirt', 'Pantolon', 'Etek'], image: 'images/smartphone.jpg'),
    Category(name: 'Ayakkabı', products: ['Spor Ayakkabı', 'Topuklu Ayakkabı', 'Terlik'], image: 'images/smartphone.jpg'),
    Category(name: 'Yemek', products: ['Pizza', 'Pasta', 'Hamburger'], image: 'images/smartphone.jpg'),
    Category(name: 'Kitap', products: ['Roman', 'Kurgu', 'Bilim Kurgu'], image: 'images/smartphone.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductScreen(
                  categoryName: categories[index].name,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        categories[index].image,
                        height: 150,
                        width: 400,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Text(
                          categories[index].name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
