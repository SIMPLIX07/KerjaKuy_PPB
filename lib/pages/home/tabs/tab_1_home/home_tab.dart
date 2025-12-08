import 'package:flutter/material.dart';
import '../../../../database/db_helper.dart';
import 'package:flutter_application_1/pages/settings/settingPelamar/settingPelamar.dart';

class HomeTab extends StatefulWidget {
  final String username;
  final String jobTitle;
  final VoidCallback onLihatLainnyaPressed;

  const HomeTab({
    super.key,
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

  void _showAllLamaranDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Semua Lamaran"),
          content: Container(
            width: double.maxFinite,
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // CARD 1: Garuda Indonesia (Diterima)
                  Container(
                    width: 400 * 0.9,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Container(
                          height: 40,
                          width: 5,
                          decoration: BoxDecoration(
                            color: Color(0xFF28AE9D), // Hijau
                            borderRadius: BorderRadius.circular(90),
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(Icons.airplanemode_active, size: 40),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selamat anda diterima di perusahaan",
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "PT Garuda Indonesia",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  // CARD 2: Qatar Airways (Ditolak)
                  Container(
                    width: 400 * 0.9,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Container(
                          height: 40,
                          width: 5,
                          decoration: BoxDecoration(
                            color: Colors.red, // Merah
                            borderRadius: BorderRadius.circular(90),
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(Icons.airplanemode_active, size: 40),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mohon Maaf anda belum diterima",
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Qatar Airways",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  // CARD 3: PT. KAI (Diproses)
                  Container(
                    width: 400 * 0.9,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Container(
                          height: 40,
                          width: 5,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(90),
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(Icons.train, size: 40),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lamaran anda sedang diproses",
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "PT. KAI",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Tutup"),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
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
              children: <Widget>[
                Divider(color: Colors.grey[300]),
                SizedBox(height: 10),
                Text(
                  "Gaji:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(
                  salary,
                  style: TextStyle(fontSize: 15, color: Colors.green[700]),
                ),
                SizedBox(height: 15),
                Text(
                  "Lokasi:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(location, style: TextStyle(fontSize: 15)),
                SizedBox(height: 15),
                Text(
                  "Deskripsi Pekerjaan:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(description, style: TextStyle(fontSize: 15)),
                SizedBox(height: 20),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Batal", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
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
                print("Melamar pekerjaan: $jobTitle di $companyName");
                Navigator.of(dialogContext).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Berhasil melamar $jobTitle!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 70,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ), // jarak kiri-kanan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Avatar
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProfilePage(),
                                ),
                              );
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xFF28AE9D),
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),

                          SizedBox(width: 10),
                          // Nama & jabatan
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
                      Icon(Icons.notifications),
                    ],
                  ),
                ),
                //Pencarian bar
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 350,
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
                //section lamaran
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsetsGeometry.only(left: 25),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Lamaran Anda",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        // Pembungkus Hitam
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 36, 33, 33),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Container(
                              //Garuda Indonesia
                              width: 400 * 0.9,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                // isi dari garuda
                                children: [
                                  SizedBox(width: 5),
                                  Container(
                                    height: 40,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF28AE9D),
                                      borderRadius: BorderRadius.circular(90),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Icon(Icons.airplanemode_active, size: 40),
                                  SizedBox(width: 20),
                                  Container(
                                    width: 200,
                                    height: 40,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Selamat anda diterima di perusahaan",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          "PT Garuda Indonesia",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              //Garuda Indonesia
                              width: 400 * 0.9,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                // isi dari garuda
                                children: [
                                  SizedBox(width: 5),
                                  Container(
                                    height: 40,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(90),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Icon(Icons.airplanemode_active, size: 40),
                                  SizedBox(width: 20),
                                  Container(
                                    width: 200,
                                    height: 40,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Mohon Maaf anda belum diterima",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          "Qatar Airways",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 400 * 0.9,
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          // diterima
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 5,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF28AE9D),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "Diterima",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          // diterima
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 5,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  255,
                                                  255,
                                                  0,
                                                  0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "Tidak diterima",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: widget.onLihatLainnyaPressed,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF28AE9D),
                                      foregroundColor: Colors.white,
                                      fixedSize: Size(100, 30),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: EdgeInsets.zero,
                                      alignment: Alignment.center,
                                    ),
                                    child: Text(
                                      "Lihat Lainnya",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Section rekomendasi
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Rekomendasi",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  // Pembungkus Hitam
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 250,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 36, 33, 33),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 190,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20, top: 10),
                                  width: 130,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                    border: Border.all(
                                      color: Color(0xFF28AE9D),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.biotech, size: 50),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Font Desk Agent",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Hilton"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: 250,
                                height: 40,
                                child: Row(
                                  children: [
                                    Container(
                                      // Gaji
                                      width: 100,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Color(0xFF28AE9D),
                                          width: 2,
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Gaji 8 Juta"),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      //Penuh Waktu
                                      width: 100,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Color(0xFF28AE9D),
                                          width: 2,
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Penuh Waktu"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  width: 120,
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        size: 20,
                                        color: Color(0xFF28AE9D),
                                      ),
                                      SizedBox(width: 5),
                                      Text("Jakarta Pusat"),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    print("Tombol Lamar ditekan!");
                                    _showJobDetailDialog(
                                      jobTitle: "Mobile Developer",
                                      companyName: "PT. Telkom INdonesia",
                                      salary: "Rp 8.000.000 - Rp 12.000.000",
                                      location: "Jakarta, Indonesia (Remote)",
                                      description:
                                          "Mencari Mobile Developer berpengalaman untuk membangun aplikasi inovatif. Menguasai Flutter/React Native adalah nilai plus.", // Deskripsi
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF28AE9D),
                                    foregroundColor: Colors.white,
                                    fixedSize: Size(100, 40),
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.center,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    "Lamar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //Berita Pekerjaan
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Berita Pekerjaan",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _loadingBerita
                    ? Center(child: CircularProgressIndicator())
                    : Wrap(
                        spacing: 15, // jarak kanan-kiri antar kolom
                        runSpacing: 20, // jarak antar baris
                        children: _berita.map((berita) {
                          return Container(
                            width: 190,
                            height: 350,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // FOTO
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  width: 170,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Foto muncul disini",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 10),

                                // HEADLINE
                                Container(
                                  height: 110,
                                  width: 170,
                                  child: Text(
                                    berita['deskripsi'],
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                // Tanggal
                                Container(
                                  width: 190,
                                  height: 90,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        berita['tanggal'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
