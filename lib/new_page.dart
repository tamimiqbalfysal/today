import 'package:flutter/material.dart';
import 'product.dart'; // Import the Product class
import 'thanku_g_page.dart'; // Import the ThankuGPage class

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final List<Product> products = [
    Product(name: 'Thanku G'),
    Product(name: 'Agami'),
    Product(name: 'X'),
  ];

  final List<Product> selectedProducts = [];
  String searchQuery = '';
  String bookmarkedProductsText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Apps'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search Apps',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase())).length,
              itemBuilder: (context, index) {
                final product = products.where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase())).toList()[index];
                return GestureDetector(
                  onTap: () {
                    if (product.name == 'Thanku G') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ThankuGPage()),
                      );
                    }
                  },
                  child: ListTile(
                    title: Text(product.name),
                    leading: Checkbox(
                      value: selectedProducts.contains(product),
                      onChanged: (value) {
                        setState(() {
                          if (value!) {
                            selectedProducts.add(product);
                          } else {
                            selectedProducts.remove(product);
                          }
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: bookmarkSelectedProducts,
            child: Text('Bookmark'),
          ),
          Text(bookmarkedProductsText)
        ],
      ),
    );
  }

  void bookmarkSelectedProducts() {
    setState(() {
      bookmarkedProductsText = 'Selected Products:\n';
      for (final product in selectedProducts) {
        bookmarkedProductsText += '${product.name}\n';
      }

      Navigator.pop(context, selectedProducts);
    });
  }
}