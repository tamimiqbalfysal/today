import 'package:flutter/material.dart';
import 'new_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Today'),
      debugShowCheckedModeBanner: false, // Remove the debug banner
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Product> bookmarkedProducts = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _handleBookmarkedProducts(List<Product> newProducts) {
    setState(() {
      bookmarkedProducts.addAll(newProducts); // Add new products to the existing list
    });
  }

  void _removeTopItem() {
    if (bookmarkedProducts.isNotEmpty) {
      setState(() {
        bookmarkedProducts.removeAt(0); // Remove the first item
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800], // Dark green AppBar
        title: Text(widget.title),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer header removed
            ListTile(
              title: Text('Findit'),
              onTap: () {}, // Handle item 1 onTap
            ),
            ListTile(
              title: Text('Others'),
              onTap: () {}, // Handle item 2 onTap
            ),
            // Display bookmarked products directly, but not the "More" option
            ...bookmarkedProducts.map((product) => ListTile(
              title: Text(product.name),
              onTap: () {}, // Handle bookmarked product onTap
            )),
            // Always place the "More" option above the "Remove" button
            ListTile(
              title: Text('More'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPage()),
                ).then((value) => _handleBookmarkedProducts(value));
              },
            ),
            // Remove button at the bottom
            ListTile(
              title: Text('Remove'),
              onTap: _removeTopItem,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
