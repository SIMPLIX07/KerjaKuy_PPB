import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/db_helper.dart';
import 'package:flutter_application_1/pages/detailPekerjaan/detail_pekerjaan.dart';
import 'dart:convert';

class LowonganTab extends StatefulWidget {
  const LowonganTab({super.key});

  @override
  State<LowonganTab> createState() => _LowonganTabState();
}

class _LowonganTabState extends State<LowonganTab> {
  List<Map<String, dynamic>> daftarLowongan = [];

  @override
  void initState() {
    super.initState();
    loadLowongan();
  }

  Future<void> loadLowongan() async {
    final data = await DBHelper.getLowongan();
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
                // 🔍 Search bar
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
                      decoration: InputDecoration(
                        hintText: 'Cari',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      style: const TextStyle(fontSize: 12),
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
                          crossAxisCount: 5,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1,
                          children: kategoriList.map((kategori) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                print("Klik: ${kategori['nama']}");
                              },
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
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 6,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
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

                    // Hindari crash kalau syarat NULL atau bukan JSON valid
                    final syaratList =
                        (pk['syarat'] != null &&
                            pk['syarat'].toString().isNotEmpty)
                        ? jsonDecode(pk['syarat'])
                        : [];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailPekerjaan(idLowongan: pk['id']),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: const Color(0xFF28AE9D)),
                        ),
                        color: const Color.fromARGB(255, 55, 55, 55),
                        margin: EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  pk['posisi'] ?? '',
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  pk['nama_perusahaan'] ?? '',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),

                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: syaratList.map<Widget>((s) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      s.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }).toList(),
                              ),

                              SizedBox(height: 16),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: const Color(0xFF28AE9D),
                                      ),
                                      Text(
                                        pk['lokasi'] ?? '',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF28AE9D),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                    ),
                                    child: Text(
                                      "Lamar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
