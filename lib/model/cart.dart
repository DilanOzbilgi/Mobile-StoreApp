import 'package:badinan_mobile_app/model/product.dart';
import 'package:flutter/foundation.dart';
import 'package:badinan_mobile_app/model/cart_item.dart';

class ShoppingCart extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount {
    int count = 0;
    for (CartItem item in _items) {
      count += item.quantity;
    }
    return count;
  }

  void addToCart(Product product) {
    for (CartItem item in _items) {
      if (item.product == product) {
        item.incrementQuantity();
        notifyListeners(); // Sepet içeriği güncellendi, dinleyicilere bildir.
        return;
      }
    }
    // Ürün sepette yoksa yeni bir öğe oluşturun ve listeye ekleyin.
    _items.add(CartItem(product: product));
    notifyListeners(); // Sepet içeriği güncellendi, dinleyicilere bildir.
  }


  void removeItem(Product product) {
    _items.removeWhere((item) => item.product == product);
    notifyListeners(); // Sepet içeriği güncellendi, dinleyicilere bildir.
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  double getTotalWeight() {
    double totalWeight = 0;
    for (CartItem item in _items) {
      totalWeight += item.product.weight * item.quantity;
    }
    return totalWeight;
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (CartItem item in _items) {
      totalPrice += item.product.price * item.quantity;
    }
    return totalPrice;
  }
}
