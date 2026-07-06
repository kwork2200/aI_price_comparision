import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_string.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'modules/theme/theme_controller.dart';
import 'widgets/adsense_ad_widget.dart';
import 'services/firebase_init_service.dart';
import 'services/remote_config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print('✅ Firebase initialized successfully');
    
    await RemoteConfigService().initialize();
    print('✅ Remote Config initialized');
    
    await FirebaseInitService.initializeAdSenseConfig();
    await FirebaseInitService.testAdSenseConfig();
  } catch (e) {
    print('❌ Firebase initialization error: $e');
  }

  
  final themeController = Get.put(ThemeController());
  await themeController.loadTheme();
  
  Get.put(AdSenseController(), permanent: true);

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (controller) => GetMaterialApp(
        title: AppString.comparisonApp,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: controller.themeMode,
        initialRoute: Routes.HOME,
        getPages: AppPages.routes,
        builder: (context, child) {
          return GetX<AdSenseController>(
            builder: (adSenseController) {
              final adClient = adSenseController.adClient.value;
              final adSlot = adSenseController.adSlot.value;
              
              return Column(
                children: [
                  if (kIsWeb)
                    AdSenseAdWidget(
                      adClient: adClient,
                      adSlot: adSlot,
                      height: 90,
                    ),
                  Expanded(
                    child: child!,
                  ),
                  if (kIsWeb)
                    AdSenseAdWidget(
                      adClient: adClient,
                      adSlot: adSlot,
                      height: 90,
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
