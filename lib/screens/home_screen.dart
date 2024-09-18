import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:plant/screens/product_screen.dart';
import 'package:plant/utils/custom_widgets.dart';

import '../controller/home_controller.dart';
import '../service/plant_service.dart';

class HomeScreen extends StatelessWidget {
  CustomWidgets customWidgets = CustomWidgets();
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final PlantService plantService = Get.find();

    return Scaffold(
      appBar: customWidgets
          .customAppBar(title: "Plantify", leading: Icons.menu_sharp, actions: [
        GestureDetector(
            onTap: () => Get.toNamed('/cart'),
            child: Icon(Icons.shopping_cart_outlined))
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(context),
            SizedBox(height: 20),
            _buildCarouselSlider(),
            SizedBox(height: 20),
            _buildRecommendedForYou(),
            SizedBox(height: 20),
            _buildRecommendedForYou(),
            SizedBox(height: 20),
            _buildRecommendedForYou(),
            SizedBox(height: 20),
            _buildRecommendedForYou(),
            SizedBox(height: 20),
            _buildRecommendedForYou(),
            SizedBox(height: 20),

            // _buildImagePicker(controller),
            // SizedBox(height: 20),
            // _buildPlantInfo(controller),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.pickImage(ImageSource.camera),
        child: Icon(Icons.camera_alt_rounded),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title:
          Text('Plant Identification', style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.green,
      leading: Icon(Icons.menu),
      actions: [
        Icon(
          Icons.shopping_cart_outlined,
          color: Colors.white,
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SearchBar(hintText: "Search Plant"),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return Column(
      children: [
        Container(
          height: 200, // Adjust the height as needed
          child: CarouselSlider.builder(
            itemCount: _plantImages.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    _plantImages[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                _currentPageNotifier.value = index;
              },
            ),
          ),
        ),
        SizedBox(height: 10),
        _buildCarouselIndicators(),
      ],
    );
  }

  Widget _buildCarouselIndicators() {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPageNotifier,
      builder: (context, currentPage, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _plantImages.length,
            (index) => Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == index ? Colors.green : Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecommendedForYou() {
    return Obx(() {
      final plants = Get.find<PlantService>().plants;
      print(plants.toString());
      if (plants.isEmpty) {
        return Center(
            child:
                CircularProgressIndicator()); // Show a loading indicator while fetching
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Recommended for You',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: plants.length,
              itemBuilder: (context, index) {
                final plant = plants[index];
                return Container(
                  width: 150,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () => Get.to(() => PlantDetailScreen(plant: plant)),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.0)),
                              child: Image.network(
                                plant.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              plant.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '\$${plant.price}',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildImagePicker(HomeController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Obx(() {
            if (controller.image.value != null) {
              return _buildImagePreview(controller.image.value!);
            }
            return SizedBox(height: 200, width: 200); // Placeholder if no image
          }),
          SizedBox(height: 20),
          _buildImageButton(
            onPressed: () => controller.pickImage(ImageSource.gallery),
            icon: Icons.photo_library,
            label: 'Upload from Gallery',
          ),
          SizedBox(height: 20),
          _buildImageButton(
            onPressed: () => controller.pickImage(ImageSource.camera),
            icon: Icons.camera_alt,
            label: 'Open Camera',
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview(XFile image) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          File(image.path),
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildImageButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
    );
  }

  Widget _buildPlantInfo(HomeController controller) {
    return Obx(() {
      if (controller.name.value.isNotEmpty) {
        return Column(
          children: [
            Text(
              'Plant Name:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              controller.name.value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            _buildDescriptionBox(controller.description.value),
          ],
        );
      } else {
        return SizedBox(); // Return an empty SizedBox if no result
      }
    });
  }

  Widget _buildDescriptionBox(String description) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  final List<String> _plantImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToFnsvqrDuPIUZbs5bH416bbCsuAVhI9uUew&s',
    'https://media.istockphoto.com/id/1360316288/photo/sansevieria-plant-in-a-modern-flower-pot-stands-on-a-gray-table-on-a-white-background-home.jpg?s=612x612&w=0&k=20&c=EZr-aRvCK5mBjr_Y0QlcdNy71reiav-j119XPudcCF0=',
    'https://images.pexels.com/photos/796620/pexels-photo-796620.jpeg',
    // Add more URLs as needed
  ];
}
