import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/theme/app_string.dart';
import '../theme/theme_controller.dart';
import 'rate_us_controller.dart';

class RateUsView extends GetView<RateUsController> {
  const RateUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode == ThemeMode.dark ||
        (themeController.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(isDark),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  children: [
                    // Main content or thank you message
                    Obx(() => controller.showThankYou.value
                        ? _buildThankYouMessage(isDark)
                        : _buildRatingContent(isDark)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : const Color(0xFFFF6B35),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => controller.closeRateUs(),
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              Expanded(
                child: Text(
                  AppString.rateUsTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 48.w), // Balance the close button
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingContent(bool isDark) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        
        // Icon
        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B35).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.star_rate,
            color: const Color(0xFFFF6B35),
            size: 50.sp,
          ),
        ),
        
        SizedBox(height: 30.h),
        
        // Title
        Text(
          AppString.rateUsEnjoyingTitle,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        
        SizedBox(height: 12.h),
        
        // Subtitle
        Text(
          AppString.rateUsSubtitle,
          style: TextStyle(
            fontSize: 16.sp,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: 40.h),
        
        // Star rating
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => controller.setRating(index + 1),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Icon(
                  index < controller.rating.value
                      ? Icons.star
                      : Icons.star_border,
                  color: index < controller.rating.value
                      ? const Color(0xFFFF6B35)
                      : isDark ? Colors.grey[600] : Colors.grey[400],
                  size: 40.sp,
                ),
              ),
            );
          }),
        )),
        
        SizedBox(height: 20.h),
        
        // Rating text
        Obx(() => Text(
          _getRatingText(controller.rating.value),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black87,
          ),
        )),
        
        SizedBox(height: 40.h),
        
        // Submit button
        Obx(() => ElevatedButton(
          onPressed: controller.rating.value > 0 ? controller.submitRating : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6B35),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
            elevation: 0,
          ),
          child: Text(
            AppString.rateUsSubmitButton,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        )),
        
        SizedBox(height: 20.h),
        
        // Maybe later button
        TextButton(
          onPressed: () => controller.closeRateUs(),
          child: Text(
            AppString.rateUsMaybeLater,
            style: TextStyle(
              fontSize: 14.sp,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThankYouMessage(bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 60.h),
        
        // Thank you icon
        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 50.sp,
          ),
        ),
        
        SizedBox(height: 30.h),
        
        // Thank you text
        Text(
          AppString.rateUsThankYouTitle,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        
        SizedBox(height: 16.h),
        
        Text(
          controller.rating.value >= 4
              ? AppString.rateUsThankYouHigh
              : AppString.rateUsThankYouLow,
          style: TextStyle(
            fontSize: 16.sp,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: 40.h),
        
        // Close button
        ElevatedButton(
          onPressed: () => controller.closeRateUs(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6B35),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
            elevation: 0,
          ),
          child: Text(
            AppString.rateUsCloseButton,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return AppString.rateUsPoor;
      case 2:
        return AppString.rateUsFair;
      case 3:
        return AppString.rateUsGood;
      case 4:
        return AppString.rateUsVeryGood;
      case 5:
        return AppString.rateUsExcellent;
      default:
        return AppString.rateUsTapToRate;
    }
  }
}
