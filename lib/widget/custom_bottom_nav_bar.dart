import 'package:badinan_mobile_app/language/language_constants.dart';
import 'package:badinan_mobile_app/screen/category_screen.dart';
import 'package:badinan_mobile_app/screen/home_page.dart';
import 'package:badinan_mobile_app/screen/profile_screen.dart';
import 'package:badinan_mobile_app/screen/shopping_cart_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final VoidCallback? onHomeTap;
  final VoidCallback? onCategoriesTap;
  final VoidCallback? onCartTap;
  final VoidCallback? onProfileTap;

  CustomBottomNavigationBar({
    this.onHomeTap,
    this.onCategoriesTap,
    this.onCartTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavigationItem(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            icon: Icons.home,
            label: translation(context).labelHomePage,
          ),
          _buildNavigationItem(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoriesPage()),
              );
            },
            icon: Icons.category,
            label: translation(context).labelCategory,
          ),
          _buildNavigationItem(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
              );
            },
            icon: Icons.shopping_cart,
            label: translation(context).labelCart,
          ),
          _buildNavigationItem(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: Icons.person,
            label: translation(context).labelProfileIcon,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem({VoidCallback? onTap, IconData? icon, String? label}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.grey),
            Text(label!, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
