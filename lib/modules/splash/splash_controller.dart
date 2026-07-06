import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  RxDouble progress = 1.0.obs; // Start at 1%
  
  @override
  void onInit() {
    super.onInit();
    
    print('🚀 SplashController: Starting splash screen');
    
    // Start progress animation
    _startProgressAnimation();
  }
  
  void _startProgressAnimation() async {
    print('⏳ Starting progress animation from 1% to 100%');
    
    // Animate progress from 1% to 100% over 3 seconds
    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 30)); // 30ms per increment = 3 seconds total
      progress.value = i.toDouble();
      
      if (i == 100) {
        print('✅ Progress complete! Navigating to onboarding...');
        _navigateToOnboarding();
      }
    }
  }
  
  void _navigateToOnboarding() async {
    print('📱 Loading app open ad...');
    
    // Load the ad and wait for it to complete
    // await AdMobService().loadAppOpenAd();

    print('📱 Splash time completed, checking ad availability...');
    _showAppOpenAdAndNavigate();
  }
  
  void _showAppOpenAdAndNavigate() async {
    print('📱 Checking if app open ad is available...');
    
    // Check if this is the first time user is opening the app
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    
    print('👤 First time user: $isFirstTime');
    
    // // Show app open ad if available, then navigate
    // if (AdMobService().isAppOpenAdAvailable) {
    //   print(' App open ad is available, showing ad...');
    //   AdMobService().showAppOpenAd();
    //
    //   // Navigate after a longer delay to allow ad to display
    //   Future.delayed(const Duration(seconds: 1), () {
    //     _navigateBasedOnFirstTime(isFirstTime);
    //   });
    // } else {
    //   print(' No app open ad available, navigating directly');
    //   _navigateBasedOnFirstTime(isFirstTime);
    // }
    _navigateBasedOnFirstTime(isFirstTime);
  }
  
  void _navigateBasedOnFirstTime(bool isFirstTime) {
    if (isFirstTime) {
      print('📱 First time user - starting onboarding flow');
      Get.offNamed('/home');
      // Get.offNamed('/onboarding');
    } else {
      print('Returning user - going directly to home');
      Get.offNamed('/home');

    }
  }
}
