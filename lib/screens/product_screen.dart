import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plant/models/cart.dart';
import 'package:plant/utils/custom_widgets.dart';
import '../controller/cart_controller.dart';
import '../models/plant.dart';

class PlantDetailScreen extends StatelessWidget {
  final Plant plant;
  CustomWidgets customWidgets = CustomWidgets();
  PlantDetailScreen({required this.plant});
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: customWidgets.customAppBar(
          title: "",
          leading: Icons.shopify_sharp,
          actions: [ GestureDetector(
              onTap: () => Get.toNamed('/cart'),
              child: Icon(Icons.shopping_cart_outlined))]),
      body: Column(
        children: [
          _buildImageCarousel(),
          _buildPlantDetails(),
          Spacer(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    return CarouselSlider(
      items: [plant.image] // Assuming only one image for the plant
          .map((imageUrl) {
        return Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: 1000.0,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: true,
      ),
    );
  }

  Widget _buildPlantDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plant.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "\$${plant.price}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'This is a description of the plant. It gives an overview of the plant\'s features, its benefits, and how to take care of it.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Handle Add to Cart action
                final cartItem = CartItem(
                  id: plant.id,
                  title: plant.title,
                  image: plant.image,
                  price: plant.price,
                );

                cartController.addItem(cartItem);

                print("cartController.cartItems.toString()");
                Get.snackbar('Added to Cart', '${plant.title} has been added to your cart');

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Background color
              ),
              child: Text(
                'Add to Cart',
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Handle Buy Now action
                             },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
              ),
              child: Text(
                'Buy Now',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
