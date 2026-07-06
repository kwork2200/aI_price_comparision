import 'package:get/get.dart';
import 'app_routes.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';
import '../modules/onboarding/onboarding_binding.dart';
import '../modules/onboarding/onboarding_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/settings/settings_binding.dart';
import '../modules/settings/settings_view.dart';
import '../modules/rate_us/rate_us_binding.dart';
import '../modules/rate_us/rate_us_view.dart';
import '../modules/privacy_policy/privacy_policy_binding.dart';
import '../modules/privacy_policy/privacy_policy_view.dart';
import '../modules/about_us/about_us_binding.dart';
import '../modules/about_us/about_us_view.dart';
import '../modules/contact_us/contact_us_binding.dart';
import '../modules/contact_us/contact_us_view.dart';
import '../modules/terms_conditions/terms_conditions_binding.dart';
import '../modules/terms_conditions/terms_conditions_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.RATE_US,
      page: () => const RateUsView(),
      binding: RateUsBinding(),
    ),
    GetPage(
      name: Routes.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: Routes.ABOUT_US,
      page: () => const AboutUsView(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: Routes.CONTACT_US,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: Routes.TERMS_CONDITIONS,
      page: () => const TermsConditionsView(),
      binding: TermsConditionsBinding(),
    ),
  ];
}
