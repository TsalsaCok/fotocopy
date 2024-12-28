import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background color
          Container(
            color: Colors.teal.shade100, // Mengatur warna latar belakang
          ),
          // Overlay content
          Positioned.fill(
            child: Container(
              color: Colors.teal.withOpacity(0.1), // Warna overlay dengan transparansi
            ),
          ),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Elevated text
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'WELCOME TO THE APP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28, // Meningkatkan ukuran font
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade900, // Warna teks utama
                  ),
                ),
              ),
              // Description text
              Text(
                'FOTOCOPY GORILLA FIRE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal.shade700, // Warna teks deskripsi
                ),
              ),
              // Image Container
              Container(
                margin: EdgeInsets.symmetric(vertical: 16), // Menambahkan margin vertikal
                height: 200, // Tinggi maksimum gambar
                width: double.infinity, // Lebar penuh
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images.png'), // Gambar
                    fit: BoxFit.contain, // Mengatur agar gambar sesuai dengan proporsinya
                  ),
                  borderRadius: BorderRadius.circular(8), // Radius sudut
                ),
              ),
              const Spacer(),
              // Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == 1
                          ? Colors.teal
                          : const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Action button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ElevatedButton(
                  onPressed: () => Get.toNamed('/fotocopy'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'MULAI',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ],
      ),
    );
  }
}
