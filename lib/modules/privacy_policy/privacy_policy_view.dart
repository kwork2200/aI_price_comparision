import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../theme/theme_controller.dart';
import 'privacy_policy_controller.dart';
import '../../widgets/navigation_bar.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});

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
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? const Color(0xFF1a1a2e)
                          : const Color(0xFF1565C0),
                    ),
                  ),
                  Text(
                    'We value your privacy and are committed to keeping your data safe',
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
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPrivacySection(
                    isDark,
                    'Effective Date: May 2026',
                    'Introduction',
                    'This Privacy Policy details how Vivo Price Compare collects, uses, and protects your information when you use our website. We are committed to transparency and ensuring your privacy is respected at all times.',
                  ),
                  SizedBox(height: 16.h),
                  _buildPrivacySection(
                    isDark,
                    '',
                    'Information We Collect',
                    'We collect only minimal, non-personal data to improve your browsing experience, including:\n\n'
                        '• Browser type and device type (for display optimization)\n'
                        '• Pages visited and time spent (via analytics tools like Google Analytics)\n'
                        '• Approximate location (country/city level — not your exact address)\n'
                        '• Referring website or search query (how you found us)\n\n'
                        'We do **not** collect names, phone numbers, email addresses, or payment information unless you contact us directly.',
                  ),
                  SizedBox(height: 16.h),
                  _buildPrivacySection(
                    isDark,
                    '',
                    'How We Use Your Information',
                    '• To understand which phone models and pages are most popular\n'
                        '• To improve website speed, layout, and content\n'
                        '• To detect and fix technical issues\n'
                        '• To show relevant ads through Google AdSense (if enabled)',
                  ),
                  SizedBox(height: 16.h),
                  _buildPrivacySection(
                    isDark,
                    '',
                    'Cookies',
                    'We use cookies and similar technologies to enhance your experience:\n\n'
                        '• Essential cookies for basic site functionality\n'
                        '• Analytics cookies to understand user behavior\n'
                        '• Advertising cookies for personalized ads\n\n'
                        'You can disable cookies through your browser settings, but this may affect site functionality.',
                  ),
                  SizedBox(height: 16.h),
                  _buildPrivacySection(
                    isDark,
                    '',
                    'Third-Party Links',
                    'Our website may contain links to third-party sites, including e-commerce platforms where you can purchase Vivo phones. We are not responsible for the privacy practices of these external sites. Please review their privacy policies before providing any personal information.',
                  ),
                  SizedBox(height: 16.h),
                  _buildPrivacySection(
                    isDark,
                    '',
                    'Data Security',
                    'We implement appropriate security measures to protect your information:\n\n'
                        '• Secure HTTPS encryption\n'
                        '• Regular security audits\n'
                        '• Limited data access to authorized personnel only\n'
                        '• Compliance with data protection regulations\n\n'
                        'However, no method of transmission over the internet is 100% secure.',
                  ),
                  SizedBox(height: 16.h),
                  _buildPrivacySection(
                    isDark,
                    '',
                    'Children\'s Privacy',
                    'Our website is not directed to children under 13. We do not knowingly collect personal information from children under 13. If you believe a child has provided us with information, please contact us immediately so we can delete such information.',
                  ),
                  SizedBox(height: 16.h),
                  _buildPrivacySection(
                    isDark,
                    '',
                    'Changes to This Policy',
                    'We may update this Privacy Policy from time to time. Any changes will be posted on this page with a revised "Effective Date." We encourage you to review this policy periodically to stay informed about how we protect your information.',
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
                ],
              ),
            ),
          ),
          )],
      ),
    );
  }

  Widget _buildPrivacySection(
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
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
          ],
          SizedBox(height: 15.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF212121),
            ),
          ),
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
