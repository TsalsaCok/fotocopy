import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fotocpy/app/modules/dashboard/controllers/dashboard_controller.dart';

class CheckoutView extends StatelessWidget {
  final DashboardController controller = Get.find<DashboardController>();

  CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    double totalPrice = controller.cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
    final TextEditingController paymentController = TextEditingController();
    final TextEditingController changeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  // Tabel dengan desain kolom yang dimodifikasi
                  Table(
                    border: TableBorder.all(color: Colors.grey, width: 1.0),
                    columnWidths: const {
                      0: FlexColumnWidth(2), // Nama Item (2 dari 10)
                      1: FlexColumnWidth(2), // Jumlah (2 dari 10)
                      2: FlexColumnWidth(3), // Qty (3 dari 10)
                      3: FlexColumnWidth(3), // Total Harga (3 dari 10)
                    },
                    children: [
                      // Header tabel
                      TableRow(
                        decoration: const BoxDecoration(color: Colors.grey),
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Nama Item',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Qty',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Harga',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Total Harga',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      // Data tabel
                      ...controller.cartItems.map((item) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.name, textAlign: TextAlign.left),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${item.quantity}', textAlign: TextAlign.center),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Rp.${item.price.toStringAsFixed(0)}', textAlign: TextAlign.right),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Rp.${(item.price * item.quantity).toStringAsFixed(0)}', textAlign: TextAlign.right),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Total Harga: Rp.${totalPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: paymentController,
                    decoration: const InputDecoration(
                      labelText: 'Bayar',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final payment = double.tryParse(value) ?? 0;
                      final change = payment - totalPrice;
                      changeController.text = change >= 0 ? 'Rp.${change.toStringAsFixed(0)}' : 'Rp.0.00';
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: changeController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Kembalian',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.snackbar('Success', 'Payment Completed!', snackPosition: SnackPosition.BOTTOM);
                controller.cartItems.clear();
                controller.saveCartItems();
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Complete Payment',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
