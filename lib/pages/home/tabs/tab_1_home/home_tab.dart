import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../database/db_helper.dart';
import 'package:flutter_application_1/pages/settings/settingPelamar/settingPelamar.dart';
import '../../../detailLowongan/detail_lowongan.dart';

class HomeTab extends StatefulWidget {
  final int userId;
  final String username;
  final String jobTitle;
  final VoidCallback onLihatLainnyaPressed;

  const HomeTab({
    super.key,
    required this.userId,
    required this.username,
    required this.jobTitle,
    required this.onLihatLainnyaPressed,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Map<String, dynamic>> _lamaran = [];
  bool _loadingLamaran = true;

  Map<String, dynamic>? rekomendasi;
  bool loadingRekom = true;
  List<Map<String, dynamic>> _berita = [];
  bool _loadingBerita = true;

  Future<void> _loadLamaran() async {
    final data = await DBHelper.getLamaranByUserId(widget.userId);

    setState(() {
      _lamaran = data.take(2).toList();
      _loadingLamaran = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadRekomendasi();
    _loadBerita();
    _loadLamaran();
  }

  Future<void> _loadBerita() async {
    final data = await DBHelper.getBerita();
    setState(() {
      _berita = data;
      _loadingBerita = false;
    });
  }

  Future<void> _loadRekomendasi() async {
    final data = await DBHelper.getRekomendasiLowongan(widget.userId);
    setState(() {
      rekomendasi = data;
      loadingRekom = false;
    });
  }

  void _showJobDetailDialog({
    required String jobTitle,
    required String companyName,
    required String salary,
    required String description,
    required String location,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF28AE9D),
                ),
              ),
              Text(
                companyName,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Divider(color: Colors.grey[300]),
                SizedBox(height: 10),
                Text("Gaji:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  salary,
                  style: TextStyle(fontSize: 15, color: Colors.green[700]),
                ),
                SizedBox(height: 15),
                Text("Lokasi:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(location, style: TextStyle(fontSize: 15)),
                SizedBox(height: 15),
                Text(
                  "Deskripsi Pekerjaan:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(description, style: TextStyle(fontSize: 15)),
                SizedBox(height: 25),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Batal", style: TextStyle(color: Colors.red)),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF28AE9D),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Lamar Sekarang"),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Berhasil melamar $jobTitle!")),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildLamaranCard({
    required Color statusColor,
    required IconData icon,
    required String text1,
    required String text2,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 5,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(90),
            ),
          ),
          SizedBox(width: 15),
          Icon(icon, size: 35),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text1, style: TextStyle(fontSize: 12)),
                Text(text2, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rekomCard(Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 90,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  border: Border.all(color: Color(0xFF28AE9D)),
                ),
                child: Center(child: Icon(Icons.work, size: 40)),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['posisi'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(data['nama_perusahaan']),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Color(0xFF28AE9D), width: 2),
                  ),
                  child: Center(child: Text("Gaji: ${data['gaji']}")),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Color(0xFF28AE9D), width: 2),
                  ),
                  child: Center(child: Text("${data['tipe']}")),
                ),
              ),
            ],
          ),

          SizedBox(height: 15),

          Row(
            children: [
              Icon(Icons.location_pin, size: 20, color: Color(0xFF28AE9D)),
              SizedBox(width: 5),
              Expanded(child: Text(data['lokasi'] ?? "Lokasi tidak tersedia")),
            ],
          ),

          SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                print("=== DATA REKOMENDASI DIKIRIM ===");
                print("Posisi: ${data['posisi']}");
                print("Perusahaan: ${data['nama_perusahaan']}");
                print("Gaji: ${data['gaji']}");
                print("Tipe: ${data['tipe']}");
                print("Lokasi: ${data['lokasi']}");
                print("Deskripsi: ${data['deskripsi']}");
                print("Syarat: ${data['syarat']}");
                print("================================");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailLowonganPage(
                      userId: widget.userId,
                      perusahaanId: data['perusahaan_id'],
                      posisi: data['posisi'] ?? "",
                      namaPerusahaan: data['nama_perusahaan'] ?? "",
                      gaji: data['gaji'] ?? "",
                      tipe: data['tipe'] ?? "",
                      lokasi: data['lokasi'] ?? "",
                      deskripsi: data['deskripsi'] ?? "",
                      syarat: data['syarat'] ?? "",
                      lowonganId: data['id'],
                    ),
                  ),
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF28AE9D),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: Text("Lamar"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),

            // Header
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfilePage(
                          userId: widget.userId,
                          nama: widget.username,
                          jobTitle: widget.jobTitle,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        FutureBuilder<Map<String, dynamic>?>(
                          future: DBHelper.getUserById(widget.userId),
                          builder: (context, snapshot) {
                            final photoPath = snapshot.data?['photo_path'];

                            return CircleAvatar(
                              radius: 25,
                              backgroundColor: const Color(0xFF28AE9D),
                              backgroundImage:
                                  photoPath != null &&
                                      photoPath.toString().isNotEmpty
                                  ? FileImage(File(photoPath))
                                  : null,
                              child:
                                  (photoPath == null ||
                                      photoPath.toString().isEmpty)
                                  ? const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )
                                  : null,
                            );
                          },
                        ),

                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.username,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(widget.jobTitle),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.notifications),
                ],
              ),
            ),

            // Search
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Cari",
                  hintText: "Masukkan jenis pekerjaan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),

            SizedBox(height: 25),

            // Lamaran Anda
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Lamaran Anda",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10),

            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xFF242121),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _loadingLamaran
                      ? const CircularProgressIndicator()
                      : _lamaran.isEmpty
                      ? const Text(
                          "Belum ada lamaran",
                          style: TextStyle(color: Colors.white),
                        )
                      : Column(
                          children: _lamaran.map((item) {
                            final status = item['status'];
                            final namaPerusahaan = item['namaPerusahaan'];
                            final posisi = item['posisi'];

                            Color statusColor;
                            String text1;

                            if (status == 'Diterima') {
                              statusColor = const Color(0xFF28AE9D);
                              text1 = "Selamat, Anda diterima sebagai $posisi";
                            } else if (status == 'Ditolak') {
                              statusColor = Colors.red;
                              text1 = "Mohon maaf, Anda belum diterima";
                            } else {
                              statusColor = Colors.orange;
                              text1 = "Lamaran Anda sedang diproses";
                            }

                            return buildLamaranCard(
                              statusColor: statusColor,
                              icon: Icons.work_outline,
                              text1: text1,
                              text2: namaPerusahaan,
                            );
                          }).toList(),
                        ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                  color: Color(0xFF28AE9D),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Diterima",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Tidak diterima",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: widget.onLihatLainnyaPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF28AE9D),
                          foregroundColor: Colors.white,
                          fixedSize: Size(100, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Lihat Lainnya",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Rekomendasi
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Rekomendasi",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10),

            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xFF242121),
                borderRadius: BorderRadius.circular(12),
              ),
              child: loadingRekom
                  ? Center(child: CircularProgressIndicator())
                  : rekomendasi == null
                  ? Center(
                      child: Text(
                        "Belum ada rekomendasi.",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : rekomCard(rekomendasi!),
            ),

            SizedBox(height: 30),

            // Berita
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Berita Pekerjaan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 15),

            _loadingBerita
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: _berita.length,
                    itemBuilder: (context, index) {
                      final berita = _berita[index];
                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Foto muncul disini",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              berita['deskripsi'],
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                berita['tanggal'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
