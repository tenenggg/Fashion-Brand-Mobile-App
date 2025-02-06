import 'package:flutter/material.dart';

class ManageOrdersPage extends StatelessWidget {
  const ManageOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Orders'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with actual orders count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text('Order #${1000 + index}'),
              subtitle: Text('Status: ${index % 2 == 0 ? "Pending" : "Delivered"}'),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'status',
                    child: Text('Update Status'),
                  ),
                  const PopupMenuItem(
                    value: 'details',
                    child: Text('View Details'),
                  ),
                ],
                onSelected: (value) {
                  // TODO: Implement order management actions
                },
              ),
            ),
          );
        },
      ),
    );
  }
} 