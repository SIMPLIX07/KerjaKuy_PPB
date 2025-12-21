import 'dart:io';
import 'package:flutter/material.dart';
import '../../database/db_helper.dart';

class DetailPerusahaanPage extends StatefulWidget {
  final int perusahaanId;

  const DetailPerusahaanPage({
    super.key,
    required this.perusahaanId,
  });

  @override
  State<DetailPerusahaanPage> createState() => _DetailPerusahaanPageState();
}

class _DetailPerusahaanPageState extends State<DetailPerusahaanPage> {
  Map<String, dynamic>? perusahaan;

  @override
  void initState() {
    super.initState();
    _loadPerusahaan();
  }

  Future<void> _loadPerusahaan() async {
    final data = await DBHelper.getPerusahaanById(widget.perusahaanId);
    setState(() => perusahaan = data);
  }

  @override
  Widget build(BuildContext context) {
    if (perusahaan == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          /// ===== HEADER IMAGE =====
          Stack(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: perusahaan!['photo_background'] != null
                      ? DecorationImage(
                          image: FileImage(
                            File(perusahaan!['photo_background']),
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: Colors.grey.shade300,
                ),
              ),
              Container(
                height: 220,
                color: Colors.black.withOpacity(0.4),
              ),
              Positioned(
                left: 16,
                top: 40,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          perusahaan!['photo_profile'] != null
                              ? FileImage(
                                  File(perusahaan!['photo_profile']),
                                )
                              : null,
                      child: perusahaan!['photo_profile'] == null
                          ? const Icon(Icons.business, size: 30)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          perusahaan!['namaPerusahaan'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Perusahaan",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// ===== CONTENT =====
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow(Icons.email, perusahaan!['email']),
                  _infoRow(Icons.location_on, perusahaan!['alamat']),
                  _infoRow(Icons.phone, perusahaan!['noTelepon']),

                  const SizedBox(height: 20),

                  const Text(
                    "Tentang Perusahaan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    perusahaan!['deskripsi'],
                    style: const TextStyle(fontSize: 15, height: 1.6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF28AE9D)),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
