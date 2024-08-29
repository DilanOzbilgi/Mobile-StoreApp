import 'package:badinan_mobile_app/language/language_constants.dart';
import 'package:badinan_mobile_app/model/cart.dart';
import 'package:badinan_mobile_app/model/product.dart';
import 'package:badinan_mobile_app/screen/shopping_cart_screen.dart';
import 'package:badinan_mobile_app/widget/custom_bottom_nav_bar.dart';
import 'package:badinan_mobile_app/widget/text_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;


  ProductDetailScreen(
      {required this.product, required String productName, required String categoryName});

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<ShoppingCart>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          translation(context).labelProductDetail,
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0), // Sağa doğru kaydırma miktarını ayarlayın
            child: Stack(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
                    );
                  },
                ),
                if (cart.itemCount > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Center(
                        child: Text(
                          '${cart.itemCount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 80),
            TextRow(
              label: translation(context).labelProductCode,
              value: product.productCode,
            ),
            TextRow(
              label: translation(context).labelWeight,
              value: '${product.weight.toString()} kg',
            ),
            TextRow(
              label: translation(context).labelPrice,
              value: '${product.price.toStringAsFixed(2)} TL',
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  cart.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          translation(context).labelProductAddedToCart
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE65100),
                ),
                child: Text(
                    translation(context).labelAddToCart
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
