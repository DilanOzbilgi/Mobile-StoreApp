import 'package:badinan_mobile_app/language/language_constants.dart';
import 'package:badinan_mobile_app/screen/category_screen.dart';
import 'package:badinan_mobile_app/screen/home_page.dart';
import 'package:badinan_mobile_app/screen/profile_screen.dart';
import 'package:badinan_mobile_app/screen/shopping_cart_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .canvasColor,
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
          _buildBottomNavItem(
            context: context,
            icon: Icons.home,
            label: translation(context).labelHomePage,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            isSelected: currentIndex == 0,
          ),
          _buildBottomNavItem(
            context: context,
            icon: Icons.category,
            label: translation(context).labelCategory,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoriesPage()),
              );
            },
            isSelected: currentIndex == 1,
          ),
          _buildBottomNavItem(
            context: context,
            icon: Icons.shopping_cart,
            label: translation(context).labelCart,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
              );
            },
            isSelected: currentIndex == 2,
          ),
          _buildBottomNavItem(
            context: context,
            icon: Icons.person,
            label: translation(context).labelProfileIcon,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            isSelected: currentIndex == 3,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Color(0xFFE65100) : Colors.grey,
                size: 25),
            SizedBox(height: 3),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isSelected ? Color(0xFFE65100) : Colors.grey,
                    fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
