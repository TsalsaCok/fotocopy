import 'package:get/get.dart';

class FotocopyController extends GetxController {
  var email = ''.obs; // Observable untuk email
  var password = ''.obs; // Observable untuk password

  void login() {
    // Logika login Anda
    print('Email: ${email.value}, Password: ${password.value}'); // Untuk demonstrasi
  }
}