import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class RateUsController extends GetxController {
  final RxInt rating = 0.obs;
  final RxBool showThankYou = false.obs;

  void setRating(int value) {
    rating.value = value;
  }

  Future<void> submitRating() async {
    if (rating.value == 0) {
      Get.snackbar('Error', 'Please select a rating',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // If rating is 4 or 5, redirect to app store
    if (rating.value >= 4) {
      showThankYou.value = true;
      await Future.delayed(const Duration(seconds: 2));
      await _openAppStore();
    } else {
      // For lower ratings, show feedback form or contact
      showThankYou.value = true;
    }
  }

  Future<void> _openAppStore() async {
    try {
      // Replace with your actual app store URL
      final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.example.app');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Error opening app store: $e');
    }
  }

  void closeRateUs() {
    Get.back();
  }

  void resetRating() {
    rating.value = 0;
    showThankYou.value = false;
  }
}
