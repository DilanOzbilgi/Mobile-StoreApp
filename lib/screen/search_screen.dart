import 'package:badinan_mobile_app/language/language_constants.dart';
import 'package:badinan_mobile_app/widget/custom_bottom_nav_bar.dart';
import 'package:badinan_mobile_app/widget/product_list.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            _buildSearchField(context),
            SizedBox(height: 20),
            Expanded(
              child: _buildSearchResults(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: isDarkMode ? Colors.white : Colors.grey,),
          hintText: translation(context).labelSearch,
          border: InputBorder.none,
        ),
        onChanged: (value) {
          // Arama sorgusu
        },
      ),
    );
  }



  Widget _buildSearchResults(BuildContext context) {
    // Listelenen veriler, kullanıcının girdiği arama sorgusuna göre filtrelenebilir.
    return Center(
      child: Text(
        translation(context).labelSearchInfo,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}



