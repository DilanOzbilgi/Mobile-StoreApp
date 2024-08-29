import 'package:badinan_mobile_app/language/language_constants.dart';
import 'package:badinan_mobile_app/model/cart.dart';
import 'package:badinan_mobile_app/screen/about_us_screen.dart';
import 'package:badinan_mobile_app/screen/category_screen.dart';
import 'package:badinan_mobile_app/screen/notification_screen.dart';
import 'package:badinan_mobile_app/screen/orders_screen.dart';
import 'package:badinan_mobile_app/screen/profile_screen.dart';
import 'package:badinan_mobile_app/screen/search_screen.dart';
import 'package:badinan_mobile_app/screen/settings_screen.dart';
import 'package:badinan_mobile_app/screen/shopping_cart_screen.dart';
import 'package:badinan_mobile_app/widget/bottom_nav_bar.dart';
import 'package:badinan_mobile_app/widget/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<ShoppingCart>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(cart),
      drawer: _buildDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductListWidget(),
      ),
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

  AppBar _buildAppBar(ShoppingCart cart) {
    return AppBar(
      leading: _buildMenuIcon(),
      title: _buildAppBarTitle(cart),
    );
  }

  Widget _buildMenuIcon() {
    return IconButton(
      icon: Icon(Icons.menu, color: Colors.grey),
      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
    );
  }

  Row _buildAppBarTitle(ShoppingCart cart) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(),
        _buildActionButtons(cart),
      ],
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'images/main_logo.png',
      height: 100,
      width: 150,
    );
  }

  Row _buildActionButtons(ShoppingCart cart) {
    return Row(
      children: [
        _buildIconButton(
          iconData: Icons.search,
          onPress: () => _navigateToScreen(SearchPage()),
        ),
        Stack(
          children: <Widget>[
            _buildIconButton(
              iconData: Icons.shopping_cart,
              onPress: () => _navigateToScreen(ShoppingCartScreen()),
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
          ],
        ),
      ],
    );
  }

  IconButton _buildIconButton({
    required IconData iconData,
    required VoidCallback onPress,
  }) {
    return IconButton(
      icon: Icon(iconData, color: Colors.grey),
      onPressed: onPress,
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: _buildDrawerChildren(),
        ),
      ),
    );
  }

  List<Widget> _buildDrawerChildren() {
    return [
      _buildDrawerHeader(),
      _buildDivider(),
      _buildDrawerItem(
        icon: Icons.home,
        label: translation(context).labelHomePage,
        onTap: () => _navigateToScreen(HomePage()),
      ),
      _buildDivider(),
      _buildDrawerItem(
        icon: Icons.category,
        label: translation(context).labelCategory,
        onTap: () => _navigateToScreen(CategoriesPage()),
      ),
      _buildDivider(),
      _buildDrawerItem(
        icon: Icons.shopping_cart,
        label: translation(context).labelOrders,
        onTap: () => _navigateToScreen(OrdersScreen()),
      ),
      _buildDivider(),
      _buildDrawerItem(
        icon: Icons.account_circle,
        label: translation(context).labelAccount,
        onTap: () => _navigateToScreen(ProfilePage()),
      ),
      _buildDivider(),
      _buildDrawerItem(
        icon: Icons.notifications,
        label: translation(context).labelNotifications,
        onTap: () => _navigateToScreen(NotificationScreen()),
      ),
      _buildDivider(),
      _buildDrawerItem(
        icon: Icons.settings,
        label: translation(context).labelSettings,
        onTap: () => _navigateToScreen(SettingsScreen()),
      ),
      _buildDivider(),
      _buildDrawerItem(
        icon: Icons.info,
        label: translation(context).labelAboutUs,
        onTap: () => _navigateToScreen(AboutUsPage()),
      ),
    ];
  }

  DrawerHeader _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: _buildDrawerHeaderChildren(),
    );
  }

  Column _buildDrawerHeaderChildren() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCloseIconButton(),
        SizedBox(height: 40),
        _buildDrawerHeaderText(),
      ],
    );
  }

  IconButton _buildCloseIconButton() {
    return IconButton(
      icon: Icon(Icons.close, color: Color(0xFFE65100)),
      onPressed: () => Navigator.pop(context),
    );
  }

  Text _buildDrawerHeaderText() {
    return Text(
      translation(context).labelWelcome,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 24,
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(color: Colors.white);
  }

  ListTile _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFFE65100)),
      title: Text(label, style: TextStyle(color: Colors.grey)),
      onTap: onTap,
    );
  }

  void _navigateToScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
