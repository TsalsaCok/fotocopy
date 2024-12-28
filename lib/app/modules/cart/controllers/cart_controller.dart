// file: lib/modules/cart/controllers/cart_controller.dart
import 'package:get/get.dart';
import 'package:fotocpy/app/data/models/cart_item.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price);

  void addToCart(CartItem item) {
    cartItems.add(item);
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
  }

  void checkout() {
    if (cartItems.isEmpty) {
      Get.snackbar(
        'Checkout Failed',
        'Your cart is empty.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    // Placeholder for actual checkout logic
    Get.snackbar(
      'Success',
      'Checkout successful!',
      snackPosition: SnackPosition.BOTTOM,
    );
    cartItems.clear();
  }
}