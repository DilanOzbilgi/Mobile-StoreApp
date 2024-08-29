import 'package:badinan_mobile_app/language/language_constants.dart';
import 'package:badinan_mobile_app/widget/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool isHomePage = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          translation(context).labelMyOrders,
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Center(
        child: Text(translation(context).labelPastOrders),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}


