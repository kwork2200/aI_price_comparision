import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/theme_controller.dart';
import '../../widgets/navigation_bar.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.isRegistered<ThemeController>()
        ? Get.find<ThemeController>()
        : null;
    final isDark =
        themeController != null &&
        (themeController.themeMode == ThemeMode.dark ||
            (themeController.themeMode == ThemeMode.system &&
                MediaQuery.of(context).platformBrightness == Brightness.dark));

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
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? Colors.blue[50] : Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Vivo Price Compare',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.blue[500] : const Color(0xFF1565C0),

                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Your Independent Price Comparison Platform for Vivo Smartphones in India',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.blue[700] : const Color(0xFF424242),
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'We track real-time prices from top e-commerce platforms like Amazon, Flipkart, Croma, and Reliance Digital to help you find the best deals on Vivo phones. Never overpay for your smartphone again with our clear, side-by-side view of prices, offers, and availability.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.blue[700] : const Color(0xFF666666),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Why Choose Vivo Price Compare?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? Colors.blue[700]
                          : const Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 4.6,
                    children: [
                      _buildFeatureCard(
                        context,
                        Icons.trending_up,
                        'Live Price Tracking',
                        'Prices updated regularly from top retailers',
                        isDark,
                      ),
                      _buildFeatureCard(
                        context,
                        Icons.compare,
                        'Side-by-side Comparison',
                        'Compare specs and prices instantly',
                        isDark,
                      ),
                      _buildFeatureCard(
                        context,
                        Icons.security,
                        '100% Free & Safe',
                        'No registration needed, no hidden charges',
                        isDark,
                      ),
                      _buildFeatureCard(
                        context,
                        Icons.balance,
                        'Unbiased Results',
                        'We don\'t promote any single seller',
                        isDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF0f3460)
                    : const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? Colors.white24 : Colors.grey.shade300,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Our Mission',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'What We Stand For',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF212121),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Our mission is simple — empower every Indian buyer with transparent, accurate, and unbiased pricing information before they make a purchase decision.',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white70 : const Color(0xFF424242),
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Quote Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white10 : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark ? Colors.white24 : Colors.grey.shade200,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.format_quote,
                          size: 32,
                          color: isDark ? Colors.white54 : Colors.grey.shade400,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Smart shopping starts with informed decisions. We provide the data, you make the choice.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: isDark
                                ? Colors.white70
                                : const Color(0xFF666666),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            Row(
              children: [
                const SizedBox(width: 32),
                Icon(
                  Icons.info_outline,
                  color: isDark ? Colors.white : Colors.grey.shade600,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Affiliation Disclaimer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            Text(
              'Vivo Price Compare is an independent platform and is not affiliated with Vivo or any of the retailers listed on our site. We strive to provide accurate pricing information, but prices and availability are subject to change without notice.',
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0f3460) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue[700], size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white70 : const Color(0xFF666666),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
