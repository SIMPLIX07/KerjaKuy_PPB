import 'package:flutter/material.dart';

class KaryawanPerusahaanTab extends StatelessWidget {
  const KaryawanPerusahaanTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dataKaryawan = [
      {
        "role": "UI/UX Designer",
        "anggota": 4,
        "color": Color(0xFFE3F2FD), 
      },
      {
        "role": "Frontend Developer",
        "anggota": 5,
        "color": Color(0xFFE8F5E9), 
      },
      {
        "role": "Backend Developer",
        "anggota": 3,
        "color": Color(0xFFFFF3E0), 
      },
      {
        "role": "Mobile Developer",
        "anggota": 2,
        "color": Color(0xFFFFEBEE), 
      },
      {
        "role": "HRD",
        "anggota": 1,
        "color": Color(0xFFF3E5F5), 
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Karyawan",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dataKaryawan.length,
        itemBuilder: (context, index) {
          final item = dataKaryawan[index];

          return Card(
            color: item["color"], 
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bagian Role + Jumlah Anggota
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["role"],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${item["anggota"]} anggota",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  // Tombol Lihat Detail
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text(item["role"]),
                            content: const Text("Semua anggota"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Tutup"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Lihat",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
