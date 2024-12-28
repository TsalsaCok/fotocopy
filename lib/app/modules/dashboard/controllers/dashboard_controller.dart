import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



class Product {
  final String name;
  final double price;
  int stock;

  Product({required this.name, required this.price, required this.stock});

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'stock': stock,
      };

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      stock: json['stock'],
    );
  }
}

class CartItem {
  final String name;
  final double price;
  int quantity; // Tambahkan properti quantity

  CartItem({required this.name, required this.price, this.quantity = 1});

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'] ?? 1,
    );
  }
}

class DashboardController extends GetxController {
  final storage = GetStorage(); // Penyimpanan lokal
  var products = <Product>[].obs;
  var cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts(); // Memuat data produk
    loadCartItems(); // Memuat data keranjang
  }

  // Menambahkan produk ke daftar
  void addProduct(String name, double price, int stock) {
    final newProduct = Product(name: name, price: price, stock: stock);
    products.add(newProduct);
    saveProducts();
    Get.snackbar('Success', 'Product $name has been added');
  }

  // Menghapus produk dari daftar
  void removeProduct(Product product) {
    products.remove(product);
    saveProducts();
    Get.snackbar('Success', 'Product ${product.name} has been removed');
  }

  // Membeli produk (tambahkan ke keranjang)
  void buyProduct(Product product) {
    if (product.stock > 0) {
      product.stock--;

      // Periksa apakah produk sudah ada di keranjang
      final existingItem = cartItems.firstWhereOrNull(
          (item) => item.name == product.name);

      if (existingItem != null) {
        // Jika ada, tambahkan quantity
        existingItem.quantity++;
      } else {
        // Jika tidak ada, tambahkan sebagai item baru
        cartItems.add(CartItem(name: product.name, price: product.price));
      }

      saveProducts();
      saveCartItems();
      Get.snackbar('Success', 'You added ${product.name} to cart');
    } else {
      Get.snackbar(
        'Error',
        '${product.name} is out of stock',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  // Menyimpan produk ke penyimpanan lokal
  void saveProducts() {
    final productList = products.map((product) => product.toJson()).toList();
    storage.write('products', productList);
  }

  // Memuat produk dari penyimpanan lokal
  void loadProducts() {
    final productList = storage.read<List>('products');
    if (productList != null) {
      products.value =
          productList.map((product) => Product.fromJson(product)).toList();
    }
  }

  // Menyimpan item keranjang ke penyimpanan lokal
  void saveCartItems() {
    final cartList = cartItems.map((item) => item.toJson()).toList();
    storage.write('cartItems', cartList);
  }

  // Memuat item keranjang dari penyimpanan lokal
  void loadCartItems() {
    final cartList = storage.read<List>('cartItems');
    if (cartList != null) {
      cartItems.value =
          cartList.map((item) => CartItem.fromJson(item)).toList();
    }
  }
}
