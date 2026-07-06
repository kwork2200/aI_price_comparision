import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load privacy policy content if needed
    loadPrivacyPolicy();
  }

  Future<void> loadPrivacyPolicy() async {
    isLoading.value = true;
    // In a real app, you might fetch this from a server
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading.value = false;
  }

  void closePrivacyPolicy() {
    Get.back();
  }
}
