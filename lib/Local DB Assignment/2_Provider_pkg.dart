import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  List<String> cartItems = [];

  void addItem(String item) {
    cartItems.add(item);
    notifyListeners();
  }

  void removeItem(String item) {
    cartItems.remove(item);
    notifyListeners();
  }
}

// ---------------- PRODUCT SCREEN ----------------
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  final List<String> products = const [
    "Shoes",
    "Watch",
    "Laptop",
    "Phone",
    "Bag",
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CartScreen(),
                    ),
                  );
                },
              ),
              Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 10,
                  child: Text(
                    "${cart.cartItems.length}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index]),
            trailing: ElevatedButton(
              onPressed: () {
                cart.addItem(products[index]);
              },
              child: const Text("Add"),
            ),
          );
        },
      ),
    );
  }
}

// ---------------- CART SCREEN ----------------
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
      ),

      body: cart.cartItems.isEmpty
          ? const Center(
        child: Text(
          "Cart is Empty",
          style: TextStyle(fontSize: 22),
        ),
      )
          : ListView.builder(
        itemCount: cart.cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cart.cartItems[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                cart.removeItem(cart.cartItems[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
