import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PlantController extends GetxController {
  var selectedImagePath = ''.obs;
  var result = ''.obs;
  late File selectedImage;

  // Method to pick image from gallery
  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImagePath.value = image.path;
      selectedImage = File(image.path);
      identifyPlant(selectedImage);
    }
  }

  // Method to capture image with camera
  Future<void> captureImageWithCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImagePath.value = image.path;
      selectedImage = File(image.path);
      identifyPlant(selectedImage);
    }
  }

  // Method to send image to Google Gemini API for plant identification
  Future<void> identifyPlant(File image) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://gemini.google.com/plant-identification'));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    // Add any necessary headers
    request.headers.addAll({
      'Authorization': 'AIzaSyCTYc93wVE3stjZC8OhAvBuw8cdVgsgW7w', // Replace with your actual API Key
    });

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var data = jsonDecode(responseData);
      result.value = data['plant_name']; // Parse the plant name from response
    } else {
      result.value = "Failed to identify the plant";
    }
  }
}
