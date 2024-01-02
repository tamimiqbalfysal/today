import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final List<Product> products = [
    Product(name: 'Product 1'),
    Product(name: 'Product 2'),
    Product(name: 'Product 3'),
  ];

  final List<Product> selectedProducts = [];
  String searchQuery = '';
  String bookmarkedProductsText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search products',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase())).length,
              itemBuilder: (context, index) {
                final product = products.where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase())).toList()[index];
                return CheckboxListTile(
                  title: Text(product.name),
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

class Product {
  final String name;

  Product({required this.name});
}
