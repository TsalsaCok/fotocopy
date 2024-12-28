import 'package:get/get.dart';
import 'package:fotocpy/app/modules/fotocopy/controllers/fotocopy_controller.dart';

class FotocopyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FotocopyController>(() => FotocopyController());
  }
}