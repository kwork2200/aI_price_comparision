import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_string.dart';
import '../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void skip() {
    _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    // Set first-time flag to false
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    print(AppString.onboardingCompleted);
    
    // Navigate to home screen
    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
