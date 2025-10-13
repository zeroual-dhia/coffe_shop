import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _coffees = [];
  List<Map<String, dynamic>> get selectedItems => List.unmodifiable(_coffees);

 

  int get totalPrice {
    int total = 0;
    for (var coffee in _coffees) {
      total += (coffee['price'] as num).toInt() * (coffee['quantity'] as int);
    }
    return total;
  }

  void addCoffee(coffee) {
    final index = _coffees.indexWhere((c) => c['id'] == coffee['id']);

    if (index != -1) {
      _coffees[index]['quantity'] += 1;
    } else {
      coffee['quantity'] = 1;
      _coffees.add(coffee);
    }

    notifyListeners();
  }

  void removeCoffee(coffee) {
    final index = _coffees.indexWhere((c) => c['id'] == coffee['id']);

    if (index != -1) {
      _coffees[index]['quantity'] -= 1;

      if (_coffees[index]['quantity'] <= 0) {
        _coffees.removeAt(index);
      }

      notifyListeners();
    }
  }

  void clearCart() {
    _coffees.clear();
    notifyListeners();
  }
}
