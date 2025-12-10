import 'package:flutter/material.dart';
import '../../../../database/db_helper.dart';
import 'package:flutter_application_1/pages/settings/settingPelamar/settingPelamar.dart';

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
  List<Map<String, dynamic>> _berita = [];
  bool _loadingBerita = true;

  @override
  void initState() {
    super.initState();
    _loadBerita();
  }

  Future<void> _loadBerita() async {
    final data = await DBHelper.getBerita();
    setState(() {
      _berita = data;
      _loadingBerita = false;
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
                      MaterialPageRoute(builder: (_) =>  ProfilePage(
                        userId: widget.userId,
                        nama: widget.username,
                        jobTitle: widget.jobTitle,
                      )),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xFF28AE9D),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
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
                  buildLamaranCard(
                    statusColor: Color(0xFF28AE9D),
                    icon: Icons.airplanemode_active,
                    text1: "Selamat anda diterima di perusahaan",
                    text2: "PT Garuda Indonesia",
                  ),
                  buildLamaranCard(
                    statusColor: Colors.red,
                    icon: Icons.airplanemode_active,
                    text1: "Mohon Maaf anda belum diterima",
                    text2: "Qatar Airways",
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
              child: Container(
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
                          child: Center(child: Icon(Icons.biotech, size: 40)),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Font Desk Agent",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Hilton",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
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
                              border: Border.all(
                                color: Color(0xFF28AE9D),
                                width: 2,
                              ),
                            ),
                            child: Center(child: Text("Gaji 8 Juta")),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Color(0xFF28AE9D),
                                width: 2,
                              ),
                            ),
                            child: Center(child: Text("Penuh Waktu")),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 20,
                          color: Color(0xFF28AE9D),
                        ),
                        SizedBox(width: 5),
                        Expanded(child: Text("Jakarta Pusat")),
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          _showJobDetailDialog(
                            jobTitle: "Mobile Developer",
                            companyName: "PT. Telkom Indonesia",
                            salary: "Rp 8.000.000 - Rp 12.000.000",
                            location: "Jakarta, Indonesia (Remote)",
                            description:
                                "Mencari Mobile Developer berpengalaman untuk membangun aplikasi inovatif.",
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF28AE9D),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                        ),
                        child: Text("Lamar"),
                      ),
                    ),
                  ],
                ),
              ),
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
