import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:plant/service/api_service.dart';




class PlantIdentificationController extends GetxController {
  var selectedImage = Rxn<File>();
  var plantInfo = ''.obs;
  var isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();
  final ApiService apiService = ApiService();

  void pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      identifyPlant(selectedImage.value!);
    }
  }

  void takePhotoWithCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      identifyPlant(selectedImage.value!);
    }
  }

  Future<void> identifyPlant(File image) async {
    isLoading.value = true;

    String? fileUri = await apiService.uploadImage(image);
    if (fileUri != null) {
      await apiService.generateContentWithImage(fileUri, plantInfo);
    }

    isLoading.value = false;
  }
}
