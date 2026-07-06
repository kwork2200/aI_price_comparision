import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/app_string.dart';
import '../theme/theme_controller.dart';
import 'settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode == ThemeMode.dark ||
        (themeController.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final isDark = themeController.themeMode == ThemeMode.dark ||
            (themeController.themeMode == ThemeMode.system &&
                MediaQuery.of(context).platformBrightness == Brightness.dark);
        
        return Scaffold(
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                // ── App Bar ──────────────────────────────────────────────
                _buildAppBar(isDark),
                Divider(height: 1, color: Colors.grey[200]),

                // ── Settings List ────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        // ── GENERAL ──────────────────────────────────────
                        _buildSectionLabel(AppString.settingsSectionGeneral, isDark),
                        _buildSectionCard(
                          isDark: isDark,
                          children: [
                            _buildArrowItem(
                              emoji: '🌐',
                              title: AppString.settingsAppLanguage,
                              subtitle: AppString.settingsAppLanguageSubtitle,
                              isDark: isDark,
                              onTap: () {
                                Get.toNamed('/language');
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // ── MODE ─────────────────────────────────────────
                        _buildSectionLabel(AppString.settingsSectionMode, isDark),
                        _buildSectionCard(
                          isDark: isDark,
                          children: [
                            Obx(() => _buildToggleItem(
                              emoji: '🌙',
                              title: AppString.settingsDarkMode,
                              subtitle: AppString.settingsDarkModeSubtitle,
                              value: controller.isDarkMode,
                              onChanged: (_) => controller.toggleDarkMode(),
                              isDark: isDark,
                            )),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // ── OTHERS ───────────────────────────────────────
                        _buildSectionLabel(AppString.settingsSectionOthers, isDark),
                        _buildSectionCard(
                          isDark: isDark,
                          children: [
                            _buildArrowItem(
                              emoji: '⭐',
                              title: AppString.settingsRateUs,
                              subtitle: AppString.settingsRateUsSubtitle,
                              isDark: isDark,
                              onTap: () {
                                Get.toNamed('/rate_us');
                              },
                            ),
                            _buildDivider(isDark),
                            _buildArrowItem(
                              emoji: '📨',
                              title: AppString.settingsShare,
                              subtitle: AppString.settingsShareSubtitle,
                              isDark: isDark,
                              onTap: () {
                                _shareApp();
                              },
                              showArrow: false, // matches screenshot — no arrow
                            ),
                            _buildDivider(isDark),
                            _buildArrowItem(
                              emoji: '💬',
                              title: AppString.settingsFeedback,
                              subtitle: AppString.settingsFeedbackSubtitle,
                              isDark: isDark,
                              onTap: () {
                                Get.toNamed('/feedback');
                              },
                            ),
                            _buildDivider(isDark),
                            _buildArrowItem(
                              emoji: '🛡️',
                              title: AppString.settingsPrivacyPolicy,
                              subtitle: AppString.settingsPrivacyPolicySubtitle,
                              isDark: isDark,
                              onTap: () {
                                Get.toNamed('/privacy_policy');
                              },
                            ),
                            _buildDivider(isDark),
                            _buildArrowItem(
                              emoji: '📋',
                              title: AppString.settingsVersion,
                              subtitle: AppString.settingsVersionNumber,
                              isDark: isDark,
                              showArrow: false,
                              onTap: null,
                            ),
                          ],
                        ),

                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── App Bar ──────────────────────────────────────────────────────
  Widget _buildAppBar(bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : Colors.black87,
              size: 22.sp,
            ),
          ),
          Text(
            AppString.settingsTitle,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Section label (grey small caps) ─────────────────────────────
  Widget _buildSectionLabel(String label, bool isDark) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, bottom: 8.h),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.grey[400] : Colors.grey[500],
        ),
      ),
    );
  }

  // ─── White card wrapping a section ───────────────────────────────
  Widget _buildSectionCard({
    required bool isDark,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  // ─── Thin divider inside a card ──────────────────────────────────
  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      indent: 72.w,
      color: isDark ? Colors.grey[700] : Colors.grey[200],
    );
  }

  // ─── Row with arrow (or no arrow) ────────────────────────────────
  Widget _buildArrowItem({
    required String emoji,
    required String title,
    required String subtitle,
    required bool isDark,
    VoidCallback? onTap,
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            // Emoji icon
            SizedBox(
              width: 40.w,
              child: Text(emoji, style: TextStyle(fontSize: 30.sp)),
            ),
            SizedBox(width: 16.w),

            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.grey[400] : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: isDark ? Colors.grey[500] : Colors.grey[400],
              ),
          ],
        ),
      ),
    );
  }

  // ─── Share App Method ─────────────────────────────────────────────
  void _shareApp() {
    try {
      Share.share(
        AppString.settingsShareMessage,
        subject: AppString.settingsShareSubject,
      );
    } catch (e) {
      Get.snackbar(AppString.settingsShareError, '${AppString.settingsShareErrorMsg}$e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // ─── Row with toggle switch ───────────────────────────────────────
  Widget _buildToggleItem({
    required String emoji,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDark,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          // Emoji icon
          SizedBox(
            width: 40.w,
            child: Text(emoji, style: TextStyle(fontSize: 30.sp)),
          ),
          SizedBox(width: 16.w),

          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: isDark ? Colors.grey[400] : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          // Toggle — grey when off (matches screenshot)
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFFF6B35),
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}