import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../theme/theme_controller.dart';
import 'terms_conditions_controller.dart';
import '../../widgets/navigation_bar.dart';

class TermsConditionsView extends GetView<TermsConditionsController> {
  const TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark =
        themeController.themeMode == ThemeMode.dark ||
        (themeController.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1a1a2e)
          : const Color(0xFFF5F6FA),
      body: Column(
        children: [
          const AppNavigationBar(),
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? Colors.blue[50] : Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? const Color(0xFF1a1a2e)
                          : const Color(0xFF1565C0),
                    ),
                  ),
                  Text(
                    'Please read these terms carefully before using Vivo Price Compare',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 7.sp,
                      color: isDark
                          ? const Color(0xFF1a1a2e)
                          : const Color(0xFF424242),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTermsSection(
                    isDark,
                    'Effective Date: May 2026',
                    'Acceptance of Terms',
                    'By accessing and using Vivo Price Compare, you accept and agree to be bound by these Terms & Conditions. If you do not agree to these terms, please do not use our website or services.',
                  ),
                  SizedBox(height: 16.h),
                  _buildTermsSection(
                    isDark,
                    '',
                    '1. Nature of Service',
                    'Vivo Price Compare is an independent price comparison platform that provides information about Vivo smartphone prices from various e-commerce websites. We do not sell products directly, nor do we represent Vivo or any retailer.',
                  ),
                  SizedBox(height: 16.h),
                  _buildTermsSection(
                    isDark,
                    '',
                    '2. Information Accuracy',
                    'While we strive to provide accurate and up-to-date pricing information, we cannot guarantee the completeness or accuracy of all data. Prices and availability are subject to change without notice. Please verify information directly with retailers before making purchase decisions.',
                  ),
                  SizedBox(height: 16.h),
                  _buildTermsSection(
                    isDark,
                    '',
                    '3. User Responsibilities',
                    'As a user of our platform, you agree to:\n\n'
                    '• Use the platform for legitimate purposes only\n'
                    '• Not attempt to manipulate or interfere with our systems\n'
                    '• Respect the intellectual property rights of others\n'
                    '• Provide accurate information when contacting us\n'
                    '• Not use automated tools to scrape our data',
                  ),
                  SizedBox(height: 16.h),
                  _buildTermsSection(
                    isDark,
                    '',
                    '4. Third-Party Links',
                    'Our website contains links to third-party e-commerce platforms where you can purchase Vivo phones. We are not responsible for the quality, accuracy, or reliability of these external sites. Your interactions with third-party sites are governed by their respective terms and privacy policies.',
                  ),
                  SizedBox(height: 16.h),
                  _buildTermsSection(
                    isDark,
                    '',
                    '5. Intellectual Property',
                    'All content on Vivo Price Compare, including but not limited to text, graphics, logos, and software, is owned by or licensed to us and is protected by copyright and other intellectual property laws. You may not use our content without our prior written consent.',
                  ),
                  SizedBox(height: 16.h),
                  _buildTermsSection(
                    isDark,
                    '',
                    '6. Prohibited Use',
                    'You are strictly prohibited from:\n\n'
                    '• Using the platform for any illegal or unauthorized purpose\n'
                    '• Attempting to gain unauthorized access to our systems\n'
                    '• Interfering with or disrupting the service or servers\n'
                    '• Using the platform to transmit malicious code or viruses\n'
                    '• Reproducing or redistributing our content without permission',
                  ),
                  SizedBox(height: 16.h),
                  _buildTermsSection(
                    isDark,
                    '',
                    '7. Governing Law',
                    'These Terms & Conditions shall be governed by and construed in accordance with the laws of India. Any disputes arising from these terms or your use of our platform shall be subject to the exclusive jurisdiction of the courts in Surat, Gujarat.',
                  ),
                  SizedBox(height: 16.h),
                  _buildTermsSection(
                    isDark,
                    '',
                    '8. Changes to Terms',
                    'We reserve the right to modify these Terms & Conditions at any time. Changes will be posted on this page with an updated "Effective Date." Your continued use of our platform after any changes constitutes acceptance of the modified terms.',
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
                ],
              ),
            ),
          ), )],
      ),
    );
  }

  Widget _buildTermsSection(
    bool isDark,
    String effectiveDate,
    String title,
    String content,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0f3460) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? Colors.white24 : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (effectiveDate.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                effectiveDate,
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 5.sp,
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
          Text(
            title,
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF212121),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 5.sp,
              color: isDark ? Colors.white70 : const Color(0xFF424242),
            ),
          ),
        ],
      ),
    );
  }
}
