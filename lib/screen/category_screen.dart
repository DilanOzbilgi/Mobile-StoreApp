import 'package:badinan_mobile_app/model/cart.dart';
import 'package:badinan_mobile_app/screen/search_screen.dart';
import 'package:badinan_mobile_app/screen/shopping_cart_screen.dart';
import 'package:badinan_mobile_app/widget/bottom_nav_bar.dart';
import 'package:badinan_mobile_app/widget/category_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int _currentIndex = 1;
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
                Stack(
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
                    if (cart.items.isNotEmpty)
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
              ],
            ),
          ],
        ),
      ),
      body: CategoriesList(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
