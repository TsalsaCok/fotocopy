// file: lib/pages/fiture/fiture_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FitureController extends GetxController {
  var categories = [
    {'icon': Icons.inventory, 'label': 'Stok Barang'},
    {'icon': Icons.shopping_basket, 'label': 'Kasir'},
  ].obs;
}