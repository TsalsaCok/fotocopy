import 'package:fotocpy/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController());
  }
}

