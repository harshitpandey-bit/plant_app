// import 'dart:typed_data';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mime/mime.dart';
//
// class ApiService {
//   final String apiKey = "AIzaSyCTYc93wVE3stjZC8OhAvBuw8cdVgsgW7w";
//
//   Future<String?> generateContentWithImage(XFile image, String prompt) async {
//     try {
//
//       var model = GenerativeModel(
//         model: 'gemini-1.5-flash',
//         apiKey: apiKey,
//       );
//
//       // Read image bytes
//       var imgBytes = await image.readAsBytes();
//
//
//       var imageMimeType = lookupMimeType(image.path) ?? 'application/octet-stream';
//
//
//       final content = [
//         Content.multi([
//           TextPart(prompt),
//           DataPart(imageMimeType, imgBytes),
//         ]),
//       ];
//
//
//       final response = await model.generateContent(content);
//
//
//       String?  text ="";
//       if (response != null && response.candidates.isNotEmpty) {
//         final parts = response.candidates.first.content.toJson()['parts'] as List<dynamic>?;
//         if (parts != null && parts.isNotEmpty) {
//           final part = parts[0] as Map<String, dynamic>;
//            text = part['text'] as String?;
//           print(text);
//         } else {
//           print('Parts is null or empty');
//         }
//
//         return text;
//       } else {
//         print('No content found in the response');
//         return 'No content found';
//       }
//     } catch (e) {
//       print('Error generating content: $e');
//       return 'Error occurred';
//     }
//   }
// }
// import 'dart:typed_data';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mime/mime.dart';
//
// class ApiService {
//   final String apiKey;
//
//   ApiService(this.apiKey);
//
//   Future<String?> generateContentWithImage(XFile image, String prompt) async {
//     try {
//       // Initialize the generative model with the API key
//       var model = GenerativeModel(
//         model: 'gemini-1.5-flash',
//         apiKey: apiKey,
//       );
//
//       // Read image bytes
//       final imgBytes = await image.readAsBytes();
//       final imageMimeType = lookupMimeType(image.path) ?? 'application/octet-stream';
//
//       // Create content parts
//       final content = Content.multi([
//         TextPart(prompt),
//         DataPart(imageMimeType, imgBytes),
//       ]);
//
//       // Generate content using the model
//       final response = await model.generateContent([content]);
//
//       // Process response
//       if (response != null && response.candidates.isNotEmpty) {
//         final parts = response.candidates.first.content.toJson()['parts'] as List<dynamic>?;
//         if (parts != null && parts.isNotEmpty) {
//           final part = parts[0] as Map<String, dynamic>;
//           return part['text'] as String?;
//         } else {
//           print('Parts are null or empty');
//           return 'No content found';
//         }
//       } else {
//         print('No candidates found in the response');
//         return 'No content found';
//       }
//     } catch (e) {
//       print('Error generating content: $e');
//       return 'Error occurred';
//     }
//   }
// }
import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class ApiService {
  final String apiKey;

  ApiService(this.apiKey);

  Future<Map<String, String>?> generateContentWithImage(XFile image, String prompt) async {
    try {
      // Initialize the generative model with the API key
      var model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

      // Read image bytes
      final imgBytes = await image.readAsBytes();
      final imageMimeType = lookupMimeType(image.path) ?? 'application/octet-stream';

      // Create content parts
      final content = Content.multi([
        TextPart(prompt),
        DataPart(imageMimeType, imgBytes),
      ]);

      // Generate content using the model
      final response = await model.generateContent([content]);

      // Process response
      if (response != null && response.candidates.isNotEmpty) {
        // Assuming the response returns a structured text format with 'Name:' and 'Description:'
        final parts = response.candidates.first.content.toJson()['parts'] as List<dynamic>?;

        if (parts != null && parts.isNotEmpty) {
          final part = parts[0] as Map<String, dynamic>;

          final text = part['text'] as String?;
          if (text != null) {
            // Parse the text to extract 'Name:' and 'Description:'
            final name = _extractField(text, 'Name');
            final description = _extractField(text, 'Description');


            return {
              'name': name ?? 'Unknown',
              'description': description ?? 'Description not available',
            };
          } else {
            return {'name': 'Unknown', 'description': 'No description available'};
          }
        } else {
          print('Parts are null or empty');
          return {'name': 'No content found', 'description': 'No description available'};
        }
      } else {
        print('No candidates found in the response');
        return {'name': 'No content found', 'description': 'No description available'};
      }
    } catch (e) {
      print('Error generating content: $e');
      return {'name': 'Error occurred', 'description': 'Could not retrieve description'};
    }
  }

  // Helper function to extract fields like 'Name:' and 'Description:'
  String? _extractField(String text, String fieldName) {
    final regex = RegExp(fieldName + r':\s*(.+?)(?:\n|$)', caseSensitive: false);
    final match = regex.firstMatch(text);
    if (match == null) {
      print('No match found for field: $fieldName');
      return null;
    }
    return match.group(1)?.trim();
  }


}
