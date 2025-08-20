import 'dart:async';

import 'package:flutter/material.dart';
import 'package:coffeshop/server/database.dart';

class CoffeeProvider with ChangeNotifier {
  final String uid;
  late final Database _database;
  late final StreamSubscription _favouriteSubscription;

  List<Map> _favorites = [];

  List<Map> get favorites => _favorites;

  CoffeeProvider(this.uid) {
    _database = Database(uid: uid);
    _listenToFavorites();
  }

  void _listenToFavorites() {
    _favouriteSubscription = _database.favourites.listen((favs) {
      _favorites = favs;
      notifyListeners();
    });
  }

  Icon iconForCoffee(Map coffee) {
    final isFav = _favorites.any((fav) => fav['id'] == coffee['id']);
    return Icon(
      isFav ? Icons.favorite : Icons.favorite_border,
      color: Colors.white,
      size: 35,
    );
  }

  Future<void> toggleFavorite(Map coffee) async {
    final existing = _favorites.any((fav) => fav['id'] == coffee['id']);
    if (existing) {
      await _database.removeFavourite(coffee['id'].toString());
    } else {
      await _database.addFavorite(coffee);
    }
  }

  @override
  void dispose() {
    _favouriteSubscription.cancel();
    super.dispose();
  }
}
