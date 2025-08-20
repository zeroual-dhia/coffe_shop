import 'package:flutter/material.dart';

class Showregister extends ChangeNotifier {
  bool showregister = true;

  void toggleView() {
    showregister = !showregister;
    notifyListeners();
  }
}
