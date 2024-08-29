import 'package:badinan_mobile_app/screen/search_screen.dart';
import 'package:badinan_mobile_app/screen/shopping_cart_screen.dart';
import 'package:badinan_mobile_app/widget/custom_bottom_nav_bar.dart';
import 'package:badinan_mobile_app/widget/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badinan_mobile_app/model/cart.dart'; // ShoppingCart sınıfınızın bulunduğu yer

class ProductScreen extends StatelessWidget {
  final String categoryName;

  ProductScreen({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<ShoppingCart>(context);

    Widget buildCartIcon() {
      if (cart.itemCount > 0) {
        return Stack(
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
        );
      } else {
        return IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.grey),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'images/main_logo.png',
                  height: 100,
                  width: 150,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.search, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    );
                  },
                ),
                buildCartIcon(), // Sepet ikonunu burada çağırın
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductListWidget(),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
