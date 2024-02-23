import 'package:decoar/models/favorite_model.dart';
import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  final Map<String, FavoriteItem> _favoriteItems = {};

  void addFavorite(String id, String name, double price, String imgUrl) {
    if (!_favoriteItems.containsKey(id)) {
      _favoriteItems[id] = FavoriteItem(
        id: id,
        name: name,
        price: price,
        imgUrl: imgUrl,
      );
      notifyListeners();
    }
  }

  void removeFavorite(String id) {
    _favoriteItems.remove(id);
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favoriteItems.containsKey(id);
  }

  List<FavoriteItem> get favoriteItems {
    return _favoriteItems.values.toList();
  }
}
