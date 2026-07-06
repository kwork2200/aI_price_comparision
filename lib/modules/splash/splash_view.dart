import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_string.dart';
import '../theme/theme_controller.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode == ThemeMode.dark ||
        (themeController.themeMode == ThemeMode.system && 
         MediaQuery.of(context).platformBrightness == Brightness.dark);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark 
                ? AppColors.splashGradientDark 
                : AppColors.splashGradientLight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 80.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    // App icon with animation
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 800),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            width: 120.w,
                            height: 120.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20 * value,
                                  spreadRadius: 5 * value,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(10),
                              child: Image.asset(
                              AppString.splashLogoPath,
                                width: 100.w,
                                height: 100.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 32.h),
                    
                    // "Laugh" text
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 1000),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Text(
                            AppString.splashAppName,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                              fontSize: 42.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 8.h),
                    
                    // "Prank Sound" text
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 1200),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Text(
                            AppString.splashAppSubtitle,
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                              fontSize: 24.sp,
                              letterSpacing: 0.8,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 60.h),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 1400),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Column(
                        children: [
                          // Progress bar
                          Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.r),
                              child: Obx(() => LinearProgressIndicator(
                                value: controller.progress.value / 100,
                                backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  isDark ? Colors.white : Colors.black87,
                                ),
                              )),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          
                          // Progress text
                          Obx(() => Text(
                            '${controller.progress.value.toInt()}%',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
