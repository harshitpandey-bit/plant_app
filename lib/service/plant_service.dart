import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../models/plant.dart';

class PlantService extends GetxController {
  final Dio _dio = Dio();
  final RxList<Plant> plants = <Plant>[].obs; // Reactive list of plants

  // Example API URL (change this to your actual endpoint)
  final String _apiUrl = 'https://78aba79a-42ba-4454-8808-844af251d771-00-39zbu6qwiz388.worf.replit.dev/';

  @override
  void onInit() {
    super.onInit();
    fetchPlants(); // Fetch plants when service is initialized
  }

  Future<void> fetchPlants() async {
    try {
      final response = await _dio.get(_apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> plantList = response.data;
        print(plantList);
        final List<Plant> fetchedPlants = plantList.map((json) => Plant.fromJson(json)).toList();

        plants.assignAll(fetchedPlants); // Update reactive list with fetched plants
      } else {
        Get.snackbar("Error", "Failed to load plants");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while fetching plants");
      print(e);
    }
  }
}
