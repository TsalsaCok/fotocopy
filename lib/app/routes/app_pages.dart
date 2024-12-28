import 'package:fotocpy/app/modules/checkout/bindings/checkout_binding.dart';
import 'package:fotocpy/app/modules/checkout/views/checkout_view.dart';
import 'package:fotocpy/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:fotocpy/app/modules/dashboard/views/dashboard_view.dart';

import 'package:fotocpy/app/modules/signup/views/signup_view.dart';
import 'package:fotocpy/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:fotocpy/app/modules/home/views/home_view.dart';
import 'package:fotocpy/app/modules/fotocopy/bindings/fotocopy_binding.dart';
import 'package:fotocpy/app/modules/signup/bindings/signup_binding.dart';
import 'package:fotocpy/app/modules/fotocopy/views/fotocopy_view.dart';
import 'package:fotocpy/app/modules/fiture/views/fiture_view.dart';
import 'package:fotocpy/app/modules/fiture/bindings/fiture_binding.dart';
import 'package:fotocpy/app/modules/cart/views/cart_view.dart';
import 'package:fotocpy/app/modules/cart/bindings/cart_binding.dart';


class AppPages {
  static const initial = AppRoutes.home;

  static final routes = [
    // Home route
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
    ),

    // Fotocopy route with binding
    GetPage(
      name: AppRoutes.fotocopy,
      page: () => FotocopyPage(),
      binding: FotocopyBinding(),
    ),

    // Signup route with binding
    GetPage(
      name: AppRoutes.signup,
      page: () => SignupPage(),
      binding: SignupBinding(),
    ),

    // Dashboard route with binding
    GetPage(
      name: AppRoutes.dashboard,
      page: () =>  DashboardView(),
      binding: DashboardBinding(),
    ),

    // Fiture route with binding
    GetPage(
      name: AppRoutes.fiture,
      page: () =>  FitureView(),
      binding: FitureBinding(),
    ),

    // Cart route with binding
    GetPage(
      name: AppRoutes.cart,
      page: () =>  CartView(),
      binding: CartBinding(),
    ),

    // Checkout route with binding
    GetPage(
      name: AppRoutes.checkout,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
  ];
}
