import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant/plant_controller.dart';


class HomePage extends StatelessWidget {
  final PlantController controller = Get.put(PlantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plant Identification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Two buttons for camera and gallery
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () => controller.pickImageFromGallery(),
                  icon: Icon(Icons.photo),
                  label: Text('Upload from Gallery'),
                ),
                ElevatedButton.icon(
                  onPressed: () => controller.captureImageWithCamera(),
                  icon: Icon(Icons.camera_alt),
                  label: Text('Open Camera'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Display selected image
            Obx(() {
              if (controller.selectedImagePath.isEmpty) {
                return Text("No image selected");
              } else {
                return Image.file(
                  controller.selectedImage,
                  height: 200,
                  width: 200,
                );
              }
            }),
            SizedBox(height: 20),
            // Display result
            Obx(() {
              if (controller.result.isEmpty) {
                return Text("Result will appear here");
              } else {
                return Text(
                  controller.result.value,
                  style: TextStyle(fontSize: 16, color: Colors.green),
                  textAlign: TextAlign.center,
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
