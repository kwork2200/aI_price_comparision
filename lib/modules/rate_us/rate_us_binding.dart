import 'package:get/get.dart';
import 'rate_us_controller.dart';

class RateUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RateUsController>(() => RateUsController());
  }
}
