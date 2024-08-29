import 'package:badinan_mobile_app/language/language_constants.dart';
import 'package:badinan_mobile_app/widget/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          translation(context).labelSetting,
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Center(
        child: Text(''),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
