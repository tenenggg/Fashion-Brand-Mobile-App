import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  
  // Sample product database - you can replace this with your actual products
  final List<Map<String, dynamic>> _allProducts = [
    {
      'name': 'Black Opium Socks',
      'price': 89.99,
      'image': 'assets/images/black_opium_socks.jpg',
      'description': 'Elegant black socks',
      'category': 'BlackTestic',
    },
    {
      'name': 'Black Essence Shirt',
      'price': 129.99,
      'image': 'assets/images/black_shirt.jpg',
      'description': 'Premium black shirt',
      'category': 'BlackTestic',
    },
    {
      'name': 'White Crystal Tee',
      'price': 79.99,
      'image': 'assets/images/white_tee.jpg',
      'description': 'Pure white t-shirt',
      'category': 'WhiteTectic',
    },
    {
      'name': 'Mystery Box',
      'price': 149.99,
      'image': 'assets/images/mystery_box.jpg',
      'description': 'Special collection box',
      'category': 'Box with DSF',
    },
    {
      'name': 'Designer Umbrella',
      'price': 199.99,
      'image': 'assets/images/umbrella.jpg',
      'description': 'Luxury umbrella',
      'category': 'Armbrella',
    },
  ];

  void _performSearch(String query) {
    print('Searching for: $query'); // Debug print
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = _allProducts.where((product) {
          final matchName = product['name'].toString().toLowerCase().contains(query.toLowerCase());
          final matchDesc = product['description'].toString().toLowerCase().contains(query.toLowerCase());
          final matchCategory = product['category'].toString().toLowerCase().contains(query.toLowerCase());
          return matchName || matchDesc || matchCategory;
        }).toList();
      }
      print('Found ${_searchResults.length} results'); // Debug print
    });
  }

  void _addToCart(BuildContext context, Map<String, dynamic> item) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    cart.addItem(
      item['name'],
      item['name'],
      item['price'],
      item['image'],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item['name']} added to cart'),
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          onChanged: _performSearch,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            hintText: 'Search products...',
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
          ),
        ),
      ),
      body: Column(
        children: [
          if (_searchResults.isNotEmpty)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final item = _searchResults[index];
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
                              Text(
                                item['description'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '\$${item['price']}',
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
                                  Consumer<WishlistProvider>(
                                    builder: (context, wishlist, child) {
                                      final isInWishlist = wishlist.isInWishlist(item['name']);
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: IconButton(
                                          padding: const EdgeInsets.all(8),
                                          constraints: const BoxConstraints(),
                                          icon: Icon(
                                            isInWishlist ? Icons.favorite : Icons.favorite_border,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            if (isInWishlist) {
                                              wishlist.removeItem(item['name']);
                                            } else {
                                              wishlist.addItem(
                                                item['name'],
                                                item['name'],
                                                item['price'],
                                                item['image'],
                                                item['description'],
                                              );
                                            }
                                          },
                                        ),
                                      );
                                    },
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
            )
          else if (_searchController.text.isNotEmpty)
            const Expanded(
              child: Center(
                child: Text('No results found'),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 