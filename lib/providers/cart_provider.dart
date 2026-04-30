import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> product) {
    int index =
        cartItems.indexWhere((item) => item["name"] == product["name"]);

    if (index != -1) {
      cartItems[index]["qty"]++;
    } else {
      cartItems.add({...product, "qty": 1});
    }

    notifyListeners();
  }

  void increaseQty(int index) {
    cartItems[index]["qty"]++;
    notifyListeners();
  }

  void decreaseQty(int index) {
    if (cartItems[index]["qty"] > 1) {
      cartItems[index]["qty"]--;
    }
    notifyListeners();
  }

  double get total {
    double sum = 0;
    for (var item in cartItems) {
      sum += item["price"] * item["qty"];
    }
    return sum;
  }
}
