import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/admin/manage_products_page.dart';
import 'package:flutter_application_1/pages/admin/manage_orders_page.dart';
import 'package:flutter_application_1/pages/admin/manage_categories_page.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildDashboardItem(
            context,
            'Manage Products',
            Icons.inventory,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ManageProductsPage(),
              ),
            ),
          ),
          _buildDashboardItem(
            context,
            'Manage Orders',
            Icons.shopping_bag,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ManageOrdersPage(),
              ),
            ),
          ),
          _buildDashboardItem(
            context,
            'Manage Categories',
            Icons.category,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ManageCategoriesPage(),
              ),
            ),
          ),
          _buildDashboardItem(
            context,
            'Analytics',
            Icons.analytics,
            () {
              // TODO: Implement analytics page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Analytics coming soon')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.black),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
} 