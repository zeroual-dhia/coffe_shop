import 'package:flutter/material.dart';

class HeroModel with ChangeNotifier {
  bool showLogin = false;
  void triggerShow() {
    showLogin = !showLogin;
    notifyListeners();
  }
}
