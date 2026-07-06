import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../modules/theme/theme_controller.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark =
        themeController.themeMode == ThemeMode.dark ||
        (themeController.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1a1a2e) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Price Compare',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          Row(
            children: [
              _buildNavButton('Home', Routes.HOME, isDark),
              _buildNavButton('About Us', Routes.ABOUT_US, isDark),
              _buildNavButton('Contact Us', Routes.CONTACT_US, isDark),
              _buildNavButton('Privacy Policy', Routes.PRIVACY_POLICY, isDark),
              _buildNavButton('Terms & Conditions', Routes.TERMS_CONDITIONS, isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String title, String route, bool isDark) {
    final isCurrentRoute = Get.currentRoute == route;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: () {
          if (Get.currentRoute != route) {
            Get.toNamed(route);
          }
        },
        style: TextButton.styleFrom(
          foregroundColor: isCurrentRoute 
              ? const Color(0xFF1565C0)
              : isDark 
                  ? Colors.white70
                  : const Color(0xFF424242),
          backgroundColor: isCurrentRoute 
              ? const Color(0xFF1565C0).withOpacity(0.1)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isCurrentRoute ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
