import 'package:flutter/material.dart';

class DetailLowonganPage extends StatelessWidget {
  final String posisi;
  final String namaPerusahaan;
  final String gaji;
  final String tipe;
  final String lokasi;
  final String deskripsi;
  final String syarat;

  const DetailLowonganPage({
    super.key,
    required this.posisi,
    required this.namaPerusahaan,
    required this.gaji,
    required this.tipe,
    required this.lokasi,
    required this.deskripsi,
    required this.syarat,
  });

  List<String> parseBulletText(String text) {
    return text.split('\n').where((e) => e.trim().isNotEmpty).toList();
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
                      Text(
                        gaji,
                        style: TextStyle(fontSize: 18), 
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // TIPE
                  Row(
                    children: [
                      Icon(Icons.work, size: 26),
                      SizedBox(width: 8),
                      Text(
                        tipe,
                        style: TextStyle(fontSize: 18), 
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // LOKASI
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 26),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          lokasi,
                          style: TextStyle(fontSize: 18), 
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 35),

                  // DESKRIPSI
                  Text(
                    "Deskripsi Pekerjaan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20, 
                    ),
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
                            child: Text(
                              e,
                              style: TextStyle(fontSize: 17), 
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 35),

                  // SYARAT
                  Text(
                    "Syarat:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20, 
                    ),
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
                            child: Text(
                              e,
                              style: TextStyle(fontSize: 17), 
                            ),
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
              height: 55, // sedikit diperbesar
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Lamaran terkirim")));
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
                  style: TextStyle(
                    fontSize: 19, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
