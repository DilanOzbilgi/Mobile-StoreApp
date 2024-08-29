import 'package:badinan_mobile_app/language/language_constants.dart';
import 'package:badinan_mobile_app/model/cart.dart';
import 'package:badinan_mobile_app/model/cart_item.dart';
import 'package:badinan_mobile_app/model/product.dart';
import 'package:badinan_mobile_app/screen/home_page.dart';
import 'package:badinan_mobile_app/widget/bottom_nav_bar.dart';
import 'package:badinan_mobile_app/widget/text_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  String discountCode = '';
  int _currentIndex = 2;
  double discountRate = 0;


  void removeItemFromCart(CartItem cartItem) {
    final Product product = cartItem.product;
    Provider.of<ShoppingCart>(context, listen: false).removeItem(product);
  }

  double calculateTotalWeight(ShoppingCart cart) {
    return cart.getTotalWeight();
  }

  double calculateTotalPrice(ShoppingCart cart) {
    return cart.calculateTotalPrice();
  }

  void checkDiscountCode() {
    if (discountCode == 'DISCOUNT10') {
      discountRate = 0.10;
    } else {
      discountRate = 0;
    }
  }

  double calculateDiscountAmount(ShoppingCart cart) {
    double totalPrice = calculateTotalPrice(cart);
    checkDiscountCode();
    return totalPrice * discountRate;
  }

  double calculateTotalAmount(ShoppingCart cart) {
    double totalPrice = calculateTotalPrice(cart);
    double discountAmount = calculateDiscountAmount(cart);
    return totalPrice - discountAmount;
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<ShoppingCart>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          translation(context).labelShoppingCart,
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  if (cart.items.isNotEmpty) _buildCartItems(cart),
                  if (cart.items.isNotEmpty) SizedBox(height: 10),
                  if (cart.items.isNotEmpty) _buildDiscountCodeInput(),
                  if (cart.items.isNotEmpty) SizedBox(height: 10),
                  if (cart.items.isNotEmpty) _buildOrderSummary(cart),
                  if (cart.items.isNotEmpty) SizedBox(height: 30),
                  if (cart.items.isNotEmpty) _buildOrderButton(),
                ],
              ),
            ),
          ),
          if (cart.items.isEmpty) _buildEmptyCart(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCartItems(ShoppingCart cart) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: cart.items.length,
      itemBuilder: (context, index) {
        CartItem cartItem = cart.items[index];
        Product product = cartItem.product;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  product.imageUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (cartItem.quantity > 1) {
                          setState(() {
                            cartItem.decrementQuantity();
                          });
                        } else {
                          removeItemFromCart(cartItem); // Remove the item when quantity is 1
                        }
                      },
                    ),
                    Text(
                      cartItem.quantity.toString(),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          cartItem.incrementQuantity();
                        });
                      },
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    removeItemFromCart(cartItem); // Remove the item when the delete icon is tapped
                  },
                  child: Column(
                    children: [
                      Icon(Icons.delete),
                      Text(
                        translation(context).labelRemove,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  Widget _buildEmptyCart() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              translation(context).labelEmptyCart,
            ),
            SizedBox(height: 20),
            _buildContinueShoppingButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(ShoppingCart cart) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            translation(context).labelOrderSummary,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(translation(context).labelTotalWeight),
              Text('${calculateTotalWeight(cart)} kg'),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(translation(context).labelTotalPrice),
              Text('${calculateTotalPrice(cart).toStringAsFixed(2)} TL'),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(translation(context).labelDiscountAmount),
              Text('${calculateDiscountAmount(cart).toStringAsFixed(2)} TL'),
            ],
          ),
          SizedBox(height: 10),
          Divider(color: Colors.grey, thickness: 1),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translation(context).labelTotalAmountToPay,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyText1?.color),
              ),
              Text(
                '${calculateTotalAmount(cart).toStringAsFixed(2)}  TL',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyText1?.color),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContinueShoppingButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
      style: ElevatedButton.styleFrom(primary: Color(0xFFE65100)),
      child: Text(translation(context).labelContinueShopping),
    );
  }

  Widget _buildDiscountCodeInput() {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    discountCode = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: translation(context).labelEnterDiscountCode,
                  labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: Color(0xFFE65100),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: Color(0xFFE65100),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: checkDiscountCode,
            style: ElevatedButton.styleFrom(primary: Color(0xFFE65100)),
            child: Text(
              translation(context).labelApply,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(child: Container()),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                // Sipariş verme işlemleri
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFE65100),
              ),
              child: Text(
                translation(context).labelPlaceOrder,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
