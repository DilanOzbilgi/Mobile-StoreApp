import 'package:badinan_mobile_app/model/product.dart';
import 'package:badinan_mobile_app/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';


class ProductListWidget extends StatelessWidget {

  List<Product> products = [
    Product(
      id: '',
      productName: 'Ürün 1',
      productCode: 'KOD-001',
      weight: 0.5,
      price: 10.99,
      imageUrl: 'images/smartphone.jpg',
    ),
    Product(
      id: '',
      productName: 'Ürün 2',
      productCode: 'KOD-002',
      weight: 1.0,
      price: 19.99,
      imageUrl: 'images/smartphone.jpg',
    ),
    Product(
      id: '',
      productName: 'Ürün 3',
      productCode: 'KOD-003',
      weight: 0.75,
      price: 15.49,
      imageUrl: 'images/smartphone.jpg',
    ),
    Product(
      id: '',
      productName: 'Ürün 4',
      productCode: 'KOD-004',
      weight: 0.5,
      price: 10.99,
      imageUrl: 'images/smartphone.jpg',
    ),
    Product(
      id: '',
      productName: 'Ürün 5',
      productCode: 'KOD-005',
      weight: 1.0,
      price: 19.99,
      imageUrl: 'images/smartphone.jpg',
    ),
    Product(
      id: '',
      productName: 'Ürün 6',
      productCode: 'KOD-006',
      weight: 0.75,
      price: 15.49,
      imageUrl: 'images/smartphone.jpg',
    ),
    Product(
      id: '',
      productName: 'Ürün 7',
      productCode: 'KOD-007',
      weight: 0.5,
      price: 10.99,
      imageUrl: 'images/smartphone.jpg',
    ),
    Product(
      id: '',
      productName: 'Ürün 8',
      productCode: 'KOD-008',
      weight: 1.0,
      price: 19.99,
      imageUrl: 'images/smartphone.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        Product product = products[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product, productName: '', categoryName: '',),
              ),
            );
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  product.imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text('Ürün Kodu: ${product.productCode}'),
                      SizedBox(height: 5),
                      Text('Ağırlık: ${product.weight.toString()} kg'),
                      SizedBox(height: 5),
                      Text('Fiyat: ${product.price.toStringAsFixed(2)} TL'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}