import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Storage'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: [
          // Logo keranjang belanja
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  // Navigasi ke halaman keranjang
                  Get.toNamed('/cart');
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Obx(
                  () => controller.cartItems.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${controller.cartItems.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Daftar produk
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Price: Rp.${product.price.toStringAsFixed(0)}\nStock: ${product.stock}',
                        style: const TextStyle(height: 1.5),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _showEditProductDialog(context, product);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              controller.removeProduct(product);
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (product.stock > 0) {
                                controller.buyProduct(product);
                              } else {
                                Get.snackbar(
                                  'Error',
                                  'Stock is empty',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red.withOpacity(0.8),
                                  colorText: Colors.white,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'Buy',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Tombol untuk menambahkan produk
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddProductDialog(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Add Product',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController stockController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Product',
      titleStyle: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Product Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: priceController,
            decoration: InputDecoration(
              labelText: 'Product Price',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: stockController,
            decoration: InputDecoration(
              labelText: 'Product Stock',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      textCancel: 'Cancel',
      cancelTextColor: Colors.red,
      textConfirm: 'Add',
      confirmTextColor: Colors.white,
      buttonColor: Colors.teal,
      onCancel: () {},
      onConfirm: () {
        final name = nameController.text;
        final price = double.tryParse(priceController.text);
        final stock = int.tryParse(stockController.text);
        if (name.isNotEmpty && price != null && stock != null) {
          controller.addProduct(name, price, stock);
          Get.back();
        } else {
          Get.snackbar(
            'Error',
            'Please provide valid inputs',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
          );
        }
      },
    );
  }

  void _showEditProductDialog(BuildContext context, Product product) {
    final TextEditingController stockController = TextEditingController(text: product.stock.toString());

    Get.defaultDialog(
      title: 'Edit Product',
      titleStyle: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
      content: Column(
        children: [
          TextField(
            controller: stockController,
            decoration: InputDecoration(
              labelText: 'Product Stock',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      textCancel: 'Cancel',
      cancelTextColor: Colors.red,
      textConfirm: 'Update',
      confirmTextColor: Colors.white,
      buttonColor: Colors.teal,
      onCancel: () {},
      onConfirm: () {
        final stock = int.tryParse(stockController.text);
        if (stock != null) {
          product.stock = stock;
          controller.saveProducts();
          Get.back();
        } else {
          Get.snackbar(
            'Error',
            'Please provide a valid stock number',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
          );
        }
      },
    );
  }
}
