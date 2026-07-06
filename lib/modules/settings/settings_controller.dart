import 'package:get/get.dart';
import '../theme/theme_controller.dart';

class SettingsController extends GetxController {
  late final ThemeController themeController;
  
  // Independent toggle switches
  final playInBackground = false.obs;
  final loop = false.obs;
  final notifications = true.obs;
  final autoPlay = false.obs;
  
  // Volume control
  final volume = 0.5.obs;
  
  // Sound selection
  final selectedSound = 0.obs;
  final int totalSounds = 5;

  void togglePlayInBackground() => playInBackground.toggle();
  void toggleLoop() => loop.toggle();
  void toggleNotifications() => notifications.toggle();
  void toggleDarkMode() => _toggleTheme();
  void toggleAutoPlay() => autoPlay.toggle();

  void _toggleTheme() {
    final currentTheme = themeController.themeModeString.value;
    switch (currentTheme) {
      case 'Light':
        themeController.setTheme('Dark');
        break;
      case 'Dark':
        themeController.setTheme('Light');
        break;
      default:
        themeController.setTheme('Dark');
        break;
    }
  }

  bool get isDarkMode {
    final currentTheme = themeController.themeModeString.value;
    return currentTheme == 'Dark' || 
           (currentTheme == 'System Default' && 
            Get.isPlatformDarkMode);
  }

  void previousSound() {
    if (selectedSound.value > 0) selectedSound.value--;
  }

  void nextSound() {
    if (selectedSound.value < totalSounds - 1) selectedSound.value++;
  }

  void selectSound(int index) {
    selectedSound.value = index;
  }

  void setVolume(double val) => volume.value = val;

  @override
  void onInit() {
    super.onInit();
    themeController = Get.find<ThemeController>();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
