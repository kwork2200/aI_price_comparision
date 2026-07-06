import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_string.dart';
import '../theme/theme_controller.dart';
import 'onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: controller.skip,
                  child: Text(
                    AppString.onboardingSkip,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7) ?? Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  children: [
                    _buildFirstPage(context),
                    _buildSecondPage(context),
                    _buildThirdPage(context),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Row(
                      children: List.generate(
                        3,
                        (index) => _buildDot(index == controller.currentPage.value,context),
                      ),
                    )),
                    Obx(() => ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent2,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                        elevation: 5,
                        shadowColor: AppColors.accent2.withOpacity(0.5),
                      ),
                      child: Text(
                        controller.currentPage.value == 2 ? AppString.onboardingSelectCategory : AppString.onboardingNext,
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.accent2 : AppColors.accent2.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }


  Widget _buildFirstPage(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode == ThemeMode.dark ||
        (themeController.themeMode == ThemeMode.system && 
         MediaQuery.of(context).platformBrightness == Brightness.dark);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          // Yellow blob background with illustration
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Animated yellow blob
                    Container(
                      height: 280.h,
                      width: 280.w,
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.3 * value),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Tablet illustration with figure

                    SizedBox( height: 200.h,
                      width: 160.w,
                    child: Image.asset("assets/images/onbording_1-removebg-preview.png"),),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 40.h),
          
          // Main title

          Text(
            AppString.onboardingWelcomeTitle,
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.accent2,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          
          // Subtitle
          Text(
            AppString.onboardingWelcomeSubtitle,
            style: TextStyle(
              fontSize: 16.sp,
              color: isDark ? Colors.white70 : Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondPage(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode == ThemeMode.dark ||
        (themeController.themeMode == ThemeMode.system && 
         MediaQuery.of(context).platformBrightness == Brightness.dark);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bored illustration with yellow background
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Yellow circular background
                    Container(
                      height: 280.h,
                      width: 280.w,
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.3 * value),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Sad boy illustration
                    SizedBox( height: 200.h,
                      width: 200.w,
                      child: Image.asset("assets/images/onbording_2-removebg-preview.png"),),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 40.h),
          
          // Title
          Text(
            AppString.onboardingBoredTitle,
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.accent2,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          
          // Subtitle
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              AppString.onboardingBoredSubtitle,
              style: TextStyle(
                fontSize: 16.sp,
                color: isDark ? Colors.white70 : Colors.grey[600],
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ],
        ),
      ),
    );
  }

  Widget _buildScatteredLetter(String letter, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 10 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Text(
              letter,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _buildThirdPage(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode == ThemeMode.dark ||
        (themeController.themeMode == ThemeMode.system && 
         MediaQuery.of(context).platformBrightness == Brightness.dark);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 280.h,
                      width: 280.w,
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.3 * value),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox( height: 250.h,
                      width: 200.w,
                      child: Image.asset("assets/images/onbprding_3-removebg-preview.png"),),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 40.h),
          Text(
            AppString.onboardingPrankTitle,
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.accent2,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              AppString.onboardingPrankSubtitle,
              style: TextStyle(
                fontSize: 16.sp,
                color: isDark ? Colors.white70 : Colors.grey[600],
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ],
        ),
      ),
    );
  }

}
