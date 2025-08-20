import 'package:coffeshop/routes/hero.dart';
import 'package:coffeshop/routes/home.dart';
import 'package:coffeshop/routes/profile.dart';
import 'package:flutter/material.dart';
import 'package:coffeshop/routes/coffeepage.dart';

class RouteGenerator {
  static const String hero = '/',
      profile = "/home/profile";
  static const String home = '/home';
  static const String coffepage = '/coffepage';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case hero:
        return MaterialPageRoute(builder: (_) => const herosection());
      case home:
        return MaterialPageRoute(builder: (_) => const Home());
      case coffepage:
        final arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => Coffeepage(coffe: arg));
     
      case profile:
        return MaterialPageRoute(builder: (_) => const Profile());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found!')),
      ),
    );
  }
}
