import 'dart:io';

import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import '../detailCV/detailCV.dart';

class DetailPelamarPage extends StatefulWidget {
  final int lowonganId;
  final String namaLowongan;

  const DetailPelamarPage({
    super.key,
    required this.lowonganId,
    required this.namaLowongan,
  });

  @override
  State<DetailPelamarPage> createState() => _DetailPelamarPageState();
}

class _DetailPelamarPageState extends State<DetailPelamarPage> {
  Map<String, dynamic>? lowonganDetail;
  List<Map<String, dynamic>> pelamar = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Ambil detail lowongan dari DB
    final detail = await DBHelper.getDetailLowongan(widget.lowonganId);

    // Ambil pelamar berdasarkan lowongan ID
    final dataPelamar = await DBHelper.getPelamarByLowongan(widget.lowonganId);

    setState(() {
      lowonganDetail = detail;
      pelamar = dataPelamar;
    });
  }

  List<String> parseList(String text) {
    return text.split('\n').where((e) => e.trim().isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (lowonganDetail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final deskripsi = parseList(lowonganDetail!["deskripsi"] ?? "");
    final syarat = parseList(lowonganDetail!["syarat"] ?? "");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // HEADER
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              image:
                  lowonganDetail!["photo_background"] != null &&
                      lowonganDetail!["photo_background"].toString().isNotEmpty
                  ? DecorationImage(
                      image: FileImage(
                        File(lowonganDetail!["photo_background"]),
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: Colors.grey.shade300,
            ),
            child: Stack(
              children: [
                // Overlay gelap
                Container(color: Colors.black.withOpacity(0.35)),

                // BACK BUTTON
                Positioned(
                  top: 40,
                  left: 15,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                // PROFILE + INFO
                Positioned(
                  bottom: 15,
                  left: 20,
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image:
                              lowonganDetail!["photo_profile"] != null &&
                                  lowonganDetail!["photo_profile"]
                                      .toString()
                                      .isNotEmpty
                              ? DecorationImage(
                                  image: FileImage(
                                    File(lowonganDetail!["photo_profile"]),
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child:
                            (lowonganDetail!["photo_profile"] == null ||
                                lowonganDetail!["photo_profile"]
                                    .toString()
                                    .isEmpty)
                            ? const Icon(Icons.business, size: 36)
                            : null,
                      ),

                      const SizedBox(width: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lowonganDetail!["nama_perusahaan"],
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.namaLowongan,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // BODY SCROLL
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GAJI
                  Row(
                    children: [
                      const Icon(Icons.attach_money, size: 26),
                      const SizedBox(width: 8),
                      Text(
                        lowonganDetail!["gaji"] ?? "",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // TIPE
                  Row(
                    children: [
                      const Icon(Icons.work, size: 26),
                      const SizedBox(width: 8),
                      Text(
                        lowonganDetail!["tipe"] ?? "",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // LOKASI
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 26),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          lowonganDetail!["lokasi"] ?? "",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Deskripsi Pekerjaan",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ...deskripsi.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("• ", style: TextStyle(fontSize: 18)),
                          Expanded(child: Text(e)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Syarat",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ...syarat.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("• ", style: TextStyle(fontSize: 18)),
                          Expanded(child: Text(e)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // SECTION PELAMAR
                  const Text(
                    "Pelamar",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  pelamar.isEmpty
                      ? const Text(
                          "Belum ada pelamar.",
                          style: TextStyle(fontSize: 16),
                        )
                      : Table(
                          columnWidths: const {
                            0: FlexColumnWidth(3),
                            1: FlexColumnWidth(4),
                            2: FlexColumnWidth(2),
                          },
                          border: TableBorder.all(color: Colors.black12),
                          children: [
                            const TableRow(
                              decoration: BoxDecoration(color: Colors.teal),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Nama",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "CV",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            ...pelamar.map((p) {
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(p["nama"]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(p["email"]),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.teal,
                                    ),
                                    onPressed: () async {
                                      final perusahaan_id =
                                          await DBHelper.getPerusahaanIdByLowonganId(
                                            widget.lowonganId,
                                          );

                                      print(
                                        "=== DEBUG DATA NAVIGASI DETAIL CV ===",
                                      );
                                      print(
                                        "Lowongan ID : ${widget.lowonganId}",
                                      );
                                      print("Perusahaan ID : $perusahaan_id");
                                      print("User ID : ${p["user_id"]}");
                                      print("CV ID : ${p["cv_id"]}");
                                      print(
                                        "=====================================",
                                      );
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => DetailCVPelamarPage(
                                            lowonganId: widget.lowonganId,
                                            perusahaanId: perusahaan_id!,
                                            userId: p["user_id"],
                                            cvId: p["cv_id"],
                                          ),
                                        ),
                                      );

                                      if (result == true) {
                                        _loadData(); // 🔥 REFRESH LIST PELAMAR
                                      }
                                    },
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
