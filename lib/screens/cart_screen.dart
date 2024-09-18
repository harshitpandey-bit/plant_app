import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cart_controller.dart'; // Update with the correct path

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.green,
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(child: Text('Your cart is empty.'));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {

                  final item = cartController.cartItems[index];
                  print("------------->${item.title}");
                  return ListTile(
                    leading: Image.network(item.image, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(item.title),
                    subtitle: Text('\$${item.price} x ${item.quantity}'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_shopping_cart),
                      onPressed: () => cartController.removeItem(item.id),
                    ),
                    onTap: () {
                      // Optional: Navigate to item details or quantity adjustment
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Obx(() => Text('\$${cartController.totalPrice}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle checkout action
                },
                child: Text('Checkout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
