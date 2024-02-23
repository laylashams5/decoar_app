import 'package:decoar/models/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String productId, double price, String name, String image) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          imgUrl: existingCartItem.imgUrl,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: name,
          imgUrl: image,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
    debugPrint("Item added. Current items: $_items");
  }

  void removeItem(String productId) {
    if (_items.containsKey(productId)) {
      _items.remove(productId);
      notifyListeners();
      debugPrint("Item removed. Current items: $_items"); // Debugging
    }
  }

  void increaseItemQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          imgUrl: existingCartItem.imgUrl,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
      notifyListeners();
    }
  }

  void decreaseItemQuantity(String productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]!.quantity > 1) {
        _items.update(
          productId,
          (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            imgUrl: existingCartItem.imgUrl,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity - 1,
          ),
        );
      } else {
        removeItem(productId);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  bool isInCart(String productId) {
    return _items.containsKey(productId);
  }
}
