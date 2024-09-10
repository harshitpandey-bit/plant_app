import 'package:get/get.dart';
import '../service/api_service.dart';

class ApiKeyTestController extends GetxController {
  var apiResponse = ''.obs;
  var isLoading = false.obs;
  final ApiService apiService = ApiService();

  void testApiKey() async {
    isLoading.value = true;
    await apiService.testApiKey(apiResponse);
    isLoading.value = false;
  }
}
