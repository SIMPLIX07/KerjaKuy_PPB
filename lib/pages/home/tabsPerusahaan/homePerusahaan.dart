import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat/chatPerusahaanPage.dart';
import 'package:flutter_application_1/database/db_helper.dart';
import 'package:flutter_application_1/pages/settings/settingPelamar/settingPerusahaan/settingPerusahaan.dart';
import '../../detailPelamar/detailPelamar.dart';
import '../../buatLowongan/buatLowongan.dart';

class HomePerusahaan extends StatefulWidget {
  final String namaPerusahaan;
  final int perusahaanId;

  const HomePerusahaan({
    super.key,
    required this.namaPerusahaan,
    required this.perusahaanId,
  });

  @override
  State<HomePerusahaan> createState() => _HomePerusahaanState();
}

class _HomePerusahaanState extends State<HomePerusahaan> {
  Map<String, dynamic>? perusahaan;
  List<Map<String, dynamic>> lowongan = [];

  Future<void> _loadPerusahaan() async {
    final data = await DBHelper.getPerusahaanById(widget.perusahaanId);

    setState(() {
      perusahaan = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLowongan();
    _loadPerusahaan();
  }

  Future<void> _loadLowongan() async {
    final loadedLowongan = await DBHelper.getLowonganByPerusahaanId(
      widget.perusahaanId,
    );

    setState(() {
      lowongan = loadedLowongan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Buatlowongan(
                    perusahaanId: widget.perusahaanId,
                    namaPerusahaan: widget.namaPerusahaan,
                  ),
                ),
              );

              // refresh setelah kembali
              if (result == true) {
                _loadLowongan();
              }
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF28AE9D),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text("Buat Lowongan"),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              // HEADER
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfilePage(
                          perusahaanId: widget.perusahaanId,
                          namaPerusahaan: widget.namaPerusahaan,
                        ),
                      ),
                    );

                    if (result == true) {
                      _loadPerusahaan(); //  REFRESH FOTO
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade300,
                              image:
                                  perusahaan?['photo_profile'] != null &&
                                      perusahaan!['photo_profile']
                                          .toString()
                                          .isNotEmpty
                                  ? DecorationImage(
                                      image: FileImage(
                                        File(perusahaan!['photo_profile']),
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child:
                                (perusahaan?['photo_profile'] == null ||
                                    perusahaan!['photo_profile']
                                        .toString()
                                        .isEmpty)
                                ? const Icon(
                                    Icons.business,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                : null,
                          ),

                          const SizedBox(width: 12),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.namaPerusahaan,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Pemilik Perusahaan",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      /// ICON MESSAGE 
                      IconButton(
                        icon: const Icon(Icons.message),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatListPerusahaanPage(
                                perusahaanId: widget.perusahaanId,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Lowongan Anda",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 10),

              // ========== CONTAINER HITAM ==========
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 45, 45, 45),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: lowongan.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Text(
                            "Belum ada lowongan, ayo buat lowongan sekarang",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: lowongan.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final job = lowongan[index];

                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailPelamarPage(
                                        lowonganId: job['id'],
                                        namaLowongan: job['judul'],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 5,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF28AE9D),
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              job['judul'],
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Periode: ${job['mulai']} - ${job['akhir']}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Text(
                                          job['pelamar'].toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
