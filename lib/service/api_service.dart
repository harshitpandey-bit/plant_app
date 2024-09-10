import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class ApiService {
  final String apiKey = '';

  Future<String?> generateContentWithImage(XFile image, String prompt) async {
    try {
      // Initialize the Generative Model with API Key
      var model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

      // Read image bytes
      var imgBytes = await image.readAsBytes();

      // Lookup MIME type
      var imageMimeType = lookupMimeType(image.path) ?? 'application/octet-stream';

      // Prepare content
      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart(imageMimeType, imgBytes),
        ]),
      ];

      // Generate content
      final response = await model.generateContent(content);

      // Extract and return relevant information from response
      String?  text ="";
      if (response != null && response.candidates.isNotEmpty) {
        // Assuming response.candidates is a list and we need the first candidate's text
        final parts = response.candidates.first.content.toJson()['parts'] as List<dynamic>?;
        if (parts != null && parts.isNotEmpty) {
          final part = parts[0] as Map<String, dynamic>;
           text = part['text'] as String?;
          print(text); // Output: This is a Money Plant (Epipremnum aureum).
        } else {
          print('Parts is null or empty');
        }

        return text;
      } else {
        print('No content found in the response');
        return 'No content found';
      }
    } catch (e) {
      print('Error generating content: $e');
      return 'Error occurred';
    }
  }
}
