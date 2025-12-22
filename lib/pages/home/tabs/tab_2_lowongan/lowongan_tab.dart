import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/db_helper.dart';
import 'package:flutter_application_1/detailPerusahaan/detailPerusahaan.dart';
import 'package:flutter_application_1/pages/detailLowongan/detail_lowongan.dart';
import 'package:flutter_application_1/pages/detailPekerjaan/detail_pekerjaan.dart';
import 'package:flutter_application_1/pages/lowongan/lowongan_filter_page.dart';
import 'dart:convert';
import '../../../../widget/lowongan_card.dart';

class LowonganTab extends StatefulWidget {
  final int userId;

  LowonganTab({super.key, required this.userId});

  @override
  State<LowonganTab> createState() => _LowonganTabState();
}

class _LowonganTabState extends State<LowonganTab> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> daftarLowongan = [];

  @override
  void initState() {
    super.initState();
    loadLowongan();
  }

  Future<void> loadLowongan() async {
    final data = await DBHelper.getRekomendasiLowonganList(widget.userId);

    setState(() {
      daftarLowongan = data;
    });
  }

  final List<Map<String, dynamic>> kategoriList = [
    {'icon': Icons.bar_chart, 'nama': 'Akutansi'},
    {'icon': Icons.code, 'nama': 'Web Development'},
    {'icon': Icons.analytics, 'nama': 'Data Analyst'},
    {'icon': Icons.brush, 'nama': 'Desain Grafis'},
    {'icon': Icons.account_balance, 'nama': 'Perbankan'},
    {'icon': Icons.school, 'nama': 'Pendidikan'},
    {'icon': Icons.wifi, 'nama': 'Telekomunikasi'},
    {'icon': Icons.account_balance_rounded, 'nama': 'Pemerintahan'},
    {'icon': Icons.video_camera_back, 'nama': 'Video Editor'},
    {'icon': Icons.campaign, 'nama': 'Digital Marketing'},
    {'icon': Icons.design_services, 'nama': 'UI/UX'},
    {'icon': Icons.phone_android, 'nama': 'Mobile Development'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (value) {
                        if (value.trim().isEmpty) return;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LowonganFilterPage(
                              userId: widget.userId,
                              keyword: value.trim(),
                            ),
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari (UI/UX, Flutter, Data)',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),

                // Kategori Populer
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    left: 5,
                    right: 5,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Kategori Populer",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 55, 55, 55),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 4,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1,
                          children: kategoriList.map((kategori) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                final keyword = kategori['nama'];

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LowonganFilterPage(
                                      userId: widget.userId,
                                      keyword: keyword,
                                    ),
                                  ),
                                );
                              },
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        kategori['icon'],
                                        size: 20,
                                        color: const Color(0xFF28AE9D),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        kategori['nama'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                // Rekomendasi
                const Text(
                  "Rekomendasi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: daftarLowongan.length,
                  itemBuilder: (context, index) {
                    final pk = daftarLowongan[index];

                    return LowonganCard(
                      data: pk,

                      onLogoTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPerusahaanPage(
                              perusahaanId: pk['perusahaan_id'],
                            ),
                          ),
                        );
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailPekerjaan(idLowongan: pk['id']),
                          ),
                        );
                      },
                      onLamar: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailLowonganPage(
                              userId: widget.userId,
                              perusahaanId: pk['perusahaan_id'],
                              posisi: pk['posisi'] ?? "",
                              namaPerusahaan: pk['nama_perusahaan'] ?? "",
                              gaji: pk['gaji'] ?? "",
                              tipe: pk['tipe'] ?? "",
                              lokasi: pk['lokasi'] ?? "",
                              deskripsi: pk['deskripsi'] ?? "",
                              syarat: pk['syarat'] ?? "",
                              lowonganId: pk['id'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
