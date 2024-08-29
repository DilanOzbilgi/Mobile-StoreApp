import 'package:badinan_mobile_app/model/product.dart';
import 'package:flutter/foundation.dart';

class CartItem extends ChangeNotifier {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
  void incrementQuantity() {
    quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }
}
