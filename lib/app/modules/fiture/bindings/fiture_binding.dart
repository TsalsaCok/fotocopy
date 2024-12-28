import 'package:get/get.dart';

import '../controllers/fiture_controller.dart';

class FitureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FitureController>(
      () => FitureController(),
    );
  }
}
