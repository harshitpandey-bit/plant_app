import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/plant_identification_controller.dart';


class PlantIdentificationScreen extends StatelessWidget {
  final PlantIdentificationController controller = Get.put(PlantIdentificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Identification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: controller.pickImageFromGallery,
              child: Text('Upload Photo from Gallery'),
            ),
            ElevatedButton(
              onPressed: controller.takePhotoWithCamera,
              child: Text('Take Photo with Camera'),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return CircularProgressIndicator();
              }
              if (controller.selectedImage.value != null) {
                return Column(
                  children: [
                    Image.file(controller.selectedImage.value!),
                    SizedBox(height: 20),
                    if (controller.plantInfo.value.isNotEmpty)
                      Text('Plant Identified: ${controller.plantInfo.value}'),
                  ],
                );
              }
              return Container();
            }),
          ],
        ),
      ),
    );
  }
}
