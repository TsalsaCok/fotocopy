import 'package:get/get.dart';

class SignupController extends GetxController {
  var email = ''.obs; // Observable untuk email
  var password = ''.obs; // Observable untuk password
  var confirmPassword = ''.obs; // Observable untuk confirm password

  void signup() {
    if (password.value == confirmPassword.value && email.isNotEmpty) {
      // Logika untuk pendaftaran pengguna
      print('Email: ${email.value}, Password: ${password.value}'); // Untuk demonstrasi
      // Tambahkan logika untuk menyimpan data pengguna jika perlu
      
      Get.offNamed('/dashboard'); // Arahkan ke halaman dashboard setelah signup
    } else {
      // Tampilkan pesan kesalahan jika password tidak cocok atau email kosong
      Get.snackbar('Error', 'Passwords do not match or email is empty');
    }
  }
}