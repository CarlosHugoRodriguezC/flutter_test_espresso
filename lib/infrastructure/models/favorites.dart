import 'package:flutter/material.dart';

class Favorites extends ChangeNotifier {
  final List<int> _favoriteItems = [];

  List<int> get items => _favoriteItems;

  void add(int item) {
    _favoriteItems.add(item);
    notifyListeners();
  }

  void remove(int item) {
    _favoriteItems.remove(item);
    notifyListeners();
  }
}