import 'package:flutter/material.dart';

class DetailBeritaPage extends StatelessWidget {
  final String judul;
  final String tanggal;
  final String imagePath;
  final String content;

  const DetailBeritaPage({
    super.key,
    required this.judul,
    required this.tanggal,
    required this.imagePath,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF28AE9D),
        title: const Text("Detail Berita"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    tanggal,
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    content,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
