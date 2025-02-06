import 'package:flutter/foundation.dart';

class WishlistItem {
  final String id;
  final String name;
  final double price;
  final String image;
  final String description;

  WishlistItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });
}

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistItem> _items = {};

  Map<String, WishlistItem> get items => {..._items};

  int get itemCount => _items.length;

  void addItem(String id, String name, double price, String image, String description) {
    if (!_items.containsKey(id)) {
      _items.putIfAbsent(
        id,
        () => WishlistItem(
          id: id,
          name: name,
          price: price,
          image: image,
          description: description,
        ),
      );
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  bool isInWishlist(String id) {
    return _items.containsKey(id);
  }
} 