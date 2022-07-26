import 'package:flutter/foundation.dart';

class CartItemP {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItemP(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItemP> _items = {};

  Map<String, CartItemP> get items {
    return {..._items};
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingPro) => CartItemP(
              id: existingPro.id,
              title: existingPro.title,
              quantity: existingPro.quantity + 1,
              price: existingPro.price * (existingPro.quantity + 1)));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItemP(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
