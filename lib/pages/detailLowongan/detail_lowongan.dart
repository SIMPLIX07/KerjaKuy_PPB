import 'package:flutter/material.dart';
import '../../database/db_helper.dart';

class DetailLowonganPage extends StatelessWidget {
  final int lowonganId;
  final int userId;
  final int perusahaanId;
  final String posisi;
  final String namaPerusahaan;
  final String gaji;
  final String tipe;
  final String lokasi;
  final String deskripsi;
  final String syarat;

  const DetailLowonganPage({
    super.key,
    required this.userId,
    required this.perusahaanId,
    required this.posisi,
    required this.namaPerusahaan,
    required this.gaji,
    required this.tipe,
    required this.lokasi,
    required this.deskripsi,
    required this.syarat,
    required this.lowonganId,
  });

  List<String> parseBulletText(String text) {
    return text.split('\n').where((e) => e.trim().isNotEmpty).toList();
  }

  void _showPilihCVDialog(BuildContext context) async {
    final cvList = await DBHelper.getCVByUserId(userId);

    int? selectedCvId;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Text(
                "Pilih CV untuk di submit",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: cvList.isEmpty
                  ? Text(
                      "Anda belum memiliki CV. Silakan buat CV terlebih dahulu.",
                    )
                  : SizedBox(
                      width: double.maxFinite,
                      height: 300,
                      child: ListView.builder(
                        itemCount: cvList.length,
                        itemBuilder: (context, index) {
                          final cv = cvList[index];

                          return InkWell(
                            onTap: () {
                              setState(() => selectedCvId = cv['id']);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: selectedCvId == cv['id']
                                    ? Colors.teal.shade100
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color(0xFF28AE9D),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.description,
                                    size: 40,
                                    color: Color(0xFF28AE9D),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cv["title"] ?? "Tanpa Judul",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          cv["subtitle"] ?? "",
                                          style: const TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              actions: [
                TextButton(
                  child: Text("Cancel", style: TextStyle(color: Colors.red)),
                  onPressed: () => Navigator.pop(context),
                ),

                ElevatedButton(
                  onPressed: selectedCvId == null
                      ? null
                      : () async {
                          await DBHelper.insertLamaran(
                            user_id: userId,
                            perusahaan_id: perusahaanId,
                            cv_id: selectedCvId!,
                            lowongan_id: lowonganId,
                          );

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Lamaran berhasil dikirim")),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF28AE9D),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Submit"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deskripsiList = parseBulletText(deskripsi);
    final syaratList = parseBulletText(syarat);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // HEADER
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey.shade300),
            child: Stack(
              children: [
                // BACK BUTTON
                Positioned(
                  top: 40,
                  left: 15,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                // COMPANY INFO
                Positioned(
                  bottom: 15,
                  left: 20,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.business, size: 36),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            namaPerusahaan,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            posisi,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
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

          // BODY
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GAJI
                  Row(
                    children: [
                      Icon(Icons.attach_money, size: 26),
                      SizedBox(width: 8),
                      Text(gaji, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 12),

                  // TIPE
                  Row(
                    children: [
                      Icon(Icons.work, size: 26),
                      SizedBox(width: 8),
                      Text(tipe, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 12),

                  // LOKASI
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 26),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(lokasi, style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),

                  SizedBox(height: 35),

                  // DESKRIPSI
                  Text(
                    "Deskripsi Pekerjaan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 12),

                  ...deskripsiList.map(
                    (e) => Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("• ", style: TextStyle(fontSize: 18)),
                          Expanded(
                            child: Text(e, style: TextStyle(fontSize: 17)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 35),

                  // SYARAT
                  Text(
                    "Syarat:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 12),

                  ...syaratList.map(
                    (e) => Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("• ", style: TextStyle(fontSize: 18)),
                          Expanded(
                            child: Text(e, style: TextStyle(fontSize: 17)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // BUTTON LAMAR
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  _showPilihCVDialog(context);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF28AE9D),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Lamar",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
