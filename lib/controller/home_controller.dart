// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:plant/service/api_service.dart';
// import 'dart:async';
//
// class HomeController extends GetxController {
//   final ImagePicker _picker = ImagePicker();
//   final ApiService _apiService = ApiService('AIzaSyCTYc93wVE3stjZC8OhAvBuw8cdVgsgW7w');
//
//   Rx<XFile?> image = Rx<XFile?>(null);
//   RxString name = ''.obs; // New observable for plant name
//   RxString description = ''.obs; // New observable for plant description
//
//   Future<void> pickImage(ImageSource source) async {
//     final XFile? pickedImage = await _picker.pickImage(source: source);
//     if (pickedImage != null) {
//       image.value = pickedImage;
//       await generateContent();
//     }
//   }
//
//   Future<void> generateContent() async {
//     if (image.value != null) {
//       final prompt = "Please analyze the image provided and identify the plant. Provide the plant name and description. If the image does not contain a plant, respond with 'NOT A PLANT'.";
//
//       final response = await _apiService.generateContentWithImage(image.value!, prompt);
//
//       if (response != null) {
//         _parseResponse(response);
//       } else {
//         name.value = 'Failed to get result';
//         description.value = '';
//       }
//     }
//   }
//
//   void _parseResponse(String response) {
//     // Assuming the response comes in a format like "Name: PlantName\nDescription: PlantDescription"
//     final parts = response.split('\n');
//     if (parts.length >= 2) {
//       print(parts)
//       name.value = parts[0].replaceFirst('Name: ', '').trim();
//       description.value = parts[1].replaceFirst('Description: ', '').trim();
//     } else {
//       name.value = 'Unknown';
//       description.value = 'Description not available';
//     }
//   }
// }
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:plant/service/api_service.dart';
// import 'dart:async';
//
// class HomeController extends GetxController {
//   final ImagePicker _picker = ImagePicker();
//   final ApiService _apiService = ApiService('YOUR_API_KEY'); // Make sure to replace this with the actual key
//
//   Rx<XFile?> image = Rx<XFile?>(null);
//   RxString name = ''.obs; // Observable for plant name
//   RxString description = ''.obs; // Observable for plant description
//
//   Future<void> pickImage(ImageSource source) async {
//     final XFile? pickedImage = await _picker.pickImage(source: source);
//     if (pickedImage != null) {
//       image.value = pickedImage;
//       await generateContent();
//     }
//   }
//
//   Future<void> generateContent() async {
//     if (image.value != null) {
//       final prompt = "Please analyze the image provided and identify the plant. Provide the plant name and description. If the image does not contain a plant, respond with 'NOT A PLANT'.";
//
//       final response = await _apiService.generateContentWithImage(image.value!, prompt);
//
//       if (response != null) {
//         _parseResponse(response);
//       } else {
//         name.value = 'Failed to get result';
//         description.value = '';
//       }
//     }
//   }
//
//   void _parseResponse(String response) {
//     // Assuming the response comes in a format like "Name: PlantName\nDescription: PlantDescription"
//     final parts = response.split('\n');
//     if (parts.length >= 2) {
//       print(parts); // Debugging to see response parts
//       name.value = parts[0].replaceFirst('Name: ', '').trim();
//       description.value = parts[1].replaceFirst('Description: ', '').trim();
//     } else {
//       name.value = 'Unknown';
//       description.value = 'Description not available';
//     }
//   }
// }
  import 'package:get/get.dart';
  import 'package:image_picker/image_picker.dart';
  import 'package:plant/service/api_service.dart';
  import 'dart:async';

  class HomeController extends GetxController {
    final ImagePicker _picker = ImagePicker();
    final ApiService _apiService = ApiService('AIzaSyCTYc93wVE3stjZC8OhAvBuw8cdVgsgW7w'); // Make sure to replace this with the actual key

    Rx<XFile?> image = Rx<XFile?>(null);
    RxString name = ''.obs; // Observable for plant name
    RxString description = ''.obs; // Observable for plant description

    Future<void> pickImage(ImageSource source) async {
      final XFile? pickedImage = await _picker.pickImage(source: source);
      if (pickedImage != null) {
        image.value = pickedImage;
        await generateContent();
      }
    }

    Future<void> generateContent() async {
      if (image.value != null) {
        final prompt = """
  Please analyze the image provided and identify the plant. Provide the plant name followed by the description in the following format:
  Name: [Plant Name]
  Description: [Description of the plant]
  If the image does not contain a plant, respond with 'NOT A PLANT'.
  """;
        final Map<String, String>? response = await _apiService.generateContentWithImage(image.value!, prompt);
        print(response.toString());
        if (response != null) {

          _parseResponse(response);
        } else {
          name.value = 'Failed to get result';
          description.value = '';
        }
      }
    }

    void _parseResponse(Map<String, String> response) {
      // Get the name and description
      final fullName = response['name'] ?? 'Unknown';
      final fullDescription = response['description'] ?? 'Description not available';

      // Clear current values
      name.value = '';
      description.value = '';

      // Gradually display the name
      _typeText(fullName, name);

      // After the name is displayed, gradually display the description
      Timer(Duration(milliseconds: fullName.length * 50), () {
        _typeText(fullDescription, description);
      });
    }

// Helper function to "type" the text gradually
    void _typeText(String text, RxString target) {
      int index = 0;
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        if (index < text.length) {
          target.value += text[index];
          index++;
        } else {
          timer.cancel();
        }
      });
    }

  }
