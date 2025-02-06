import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import './cart_page.dart';
import '../providers/wishlist_provider.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;

  const CategoryPage({
    super.key,
    required this.categoryName,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // Sample items for each category
  List<Map<String, dynamic>> getCategoryItems() {
    switch (widget.categoryName) {
      case 'BlackTestic':
        return [
          {
            'name': 'Black Opium Socks',
            'price': 89.99,
            'image': 'assets/images/black_opium_socks.jpg',
            'description': 'Elegant black socks',
          },
          {
            'name': 'Black Essence Shirt',
            'price': 129.99,
            'image': 'assets/images/black_shirt.jpg',
            'description': 'Premium black shirt',
          },
          // Add more items as needed
        ];
      case 'WhiteTectic':
        return [
          {
            'name': 'White Crystal Tee',
            'price': 79.99,
            'image': 'assets/images/white_tee.jpg',
            'description': 'Pure white t-shirt',
          },
          {
            'name': 'Never Jorts',
            'price': 45.99,
            'image': 'assets/images/never_jorts.jpg',
            'description': 'Stylish jorts',
          },
          
        ];
      case 'Box with DSF':
        return [
          {
            'name': 'White Boxing G-Love',
            'price': 149.99,
            'image': 'assets/images/wboxing_glove.jpg',
            'description': 'special boxing glove',
          },
          {
            'name': 'Black Boxing G-Love',
            'price': 149.99,
            'image': 'assets/images/bboxing_glove.jpg',
            'description': 'special boxing glove',
          },
        ];
      case 'Armbrella':
        return [
          {
            'name': 'White Armbrella',
            'price': 199.99,
            'image': 'assets/images/Wumbrella.jpg',
            'description': 'Luxury White Edition umbrella',
          },
          {
            'name': 'Black Armbrella',
            'price': 199.99,
            'image': 'assets/images/Bumbrella.jpg',
            'description': 'Luxury Black Edition umbrella',
          },
        ];
      default:
        return [];
    }
  }

  void _addToCart(BuildContext context, Map<String, dynamic> item) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    cart.addItem(
      item['name'], // Using name as ID for simplicity
      item['name'],
      item['price'],
      item['image'],
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${item['name']} added to cart',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () {
            // Remove any existing SnackBars
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // Navigate to cart page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );
          },
        ),
      ),
    );
  }

  void _toggleWishlist(Map<String, dynamic> item) {
    final wishlist = Provider.of<WishlistProvider>(context, listen: false);
    
    if (wishlist.isInWishlist(item['name'])) {
      wishlist.removeItem(item['name']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${item['name']} removed from wishlist',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      wishlist.addItem(
        item['name'],
        item['name'],
        item['price'],
        item['image'],
        item['description'],
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${item['name']} added to wishlist',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = getCategoryItems();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(
                    item['image'],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image, size: 50);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['description'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${item['price'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _addToCart(context, item),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Add to Cart'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: IconButton(
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(),
                              icon: Icon(
                                Provider.of<WishlistProvider>(context).isInWishlist(item['name'])
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () => _toggleWishlist(item),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 