import 'dart:io';
import 'package:flutter/material.dart';

class LowonganCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  final VoidCallback onLamar;
  final VoidCallback? onLogoTap;

  const LowonganCard({
    super.key,
    required this.data,
    required this.onTap,
    required this.onLamar, this.onLogoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF242121),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onLogoTap,
                child: Container(
                  width: 90,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    border: Border.all(color: const Color(0xFF28AE9D)),
                    image: data['photo_profile'] != null &&
                            data['photo_profile'].toString().isNotEmpty
                        ? DecorationImage(
                            image: FileImage(File(data['photo_profile'])),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: (data['photo_profile'] == null ||
                          data['photo_profile'].toString().isEmpty)
                      ? const Icon(
                          Icons.business,
                          size: 40,
                          color: Color(0xFF28AE9D),
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['posisi'] ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      data['nama_perusahaan'] ?? '',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// INFO
          Row(
            children: [
              Expanded(
                child: _pill("Gaji: ${data['gaji'] ?? '-'}"),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _pill(data['tipe'] ?? '-'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// LOKASI + LAMAR
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    size: 18,
                    color: Color(0xFF28AE9D),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    data['lokasi'] ?? '-',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: onLamar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF28AE9D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Lamar"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill(String text) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF28AE9D), width: 2),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
