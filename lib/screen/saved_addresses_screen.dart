import 'package:badinan_mobile_app/language/language_constants.dart';
import 'package:badinan_mobile_app/widget/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({Key? key}) : super(key: key);

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
          translation(context).labelSavedAddresses,
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
