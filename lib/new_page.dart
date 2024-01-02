import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  String _pageText = 'Welcome to the new paggge!';
  List<String> _items = ['Products 1', 'Products 2', 'Products 3']; // Define your list of items
  String _searchQuery = ''; // Store the search query

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Search'),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  if (_searchQuery.isEmpty ||
                      item.toLowerCase().contains(_searchQuery.toLowerCase())) {
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        // Handle item tap (e.g., display details, navigate)
                      },
                    );
                  } else {
                    return Container(); // Hide if not matching search query
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}