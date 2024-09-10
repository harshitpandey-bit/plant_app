import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/api_key_test_controller.dart';


class ApiKeyTestScreen extends StatelessWidget {
  final ApiKeyTestController controller = Get.put(ApiKeyTestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Key Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: controller.testApiKey,
              child: Text('Test API Key'),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return CircularProgressIndicator();
              }
              if (controller.apiResponse.value.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text('Response: ${controller.apiResponse.value}'),
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
