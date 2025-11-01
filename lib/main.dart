import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//WIDGET UNTUK PAGE 4
Widget lamaran({required String companyName, required String status}) {
  // status lamaran(PAGE 3)
  Color statusColor;
  if (status == 'Diproses') {
    statusColor = Colors.amber;
  } else if (status == 'Diterima') {
    statusColor = Colors.green;
  } else {
    statusColor = Colors.red;
  }

  // teks sesuai status(PAGE 3)
  String message;
  if (status == 'Diproses') {
    message = "Lamaran anda sedang diproses";
  } else if (status == 'Diterima') {
    message = "Selamat! Lamaran anda diterima";
  } else {
    message = "Mohon maaf, lamaran anda belum diterima";
  }

  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 70,
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
        ),
        SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.business, color: Colors.grey[600]),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                  Text(
                    "oleh $companyName",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

//WIDGET UNTUK PAGE 4
Widget wawancara({
  required String date,
  required String time,
  required String company,
  bool isCompleted = false,
}) {
  Color statusColor;

  if (isCompleted) {
    statusColor = Colors.green;
  } else {
    statusColor = Colors.amber;
  }

  return Container(
    margin: EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        // Garis indikator di sebelah kiri
        Container(
          width: 4,
          height: 100,
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
        ),
        SizedBox(width: 12),
        // Konten utama
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Baris pertama: Tanggal dengan ikon
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    SizedBox(width: 6),
                    Text(
                      "Tanggal: $date",
                      style: TextStyle(
                        fontSize: 14,
                        color: isCompleted ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                // Baris kedua: Jam dengan ikon
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey),
                    SizedBox(width: 6),
                    Text(
                      "Jam: $time",
                      style: TextStyle(
                        fontSize: 14,
                        color: isCompleted ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Wawancara dengan $company",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.grey : Colors.black,
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late TabController _tabControllerPage3;
  late TabController _tabControllerPage4;

  @override
  void initState() {
    super.initState();
    _tabControllerPage3 = TabController(length: 3, vsync: this);
    _tabControllerPage4 = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabControllerPage3.dispose();
    _tabControllerPage4.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            // PAGE 1 - HOME
            SingleChildScrollView(
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
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(width: 10),
                                // Nama & jabatan
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Muhammad Salman Al Farizy",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Senior Analyst"),
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
                                            borderRadius: BorderRadius.circular(
                                              90,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Icon(
                                          Icons.airplanemode_active,
                                          size: 40,
                                        ),
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
                                            borderRadius: BorderRadius.circular(
                                              90,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Icon(
                                          Icons.airplanemode_active,
                                          size: 40,
                                        ),
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
                                                          BorderRadius.circular(
                                                            50,
                                                          ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "Diterima",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            255,
                                                            0,
                                                            0,
                                                          ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            50,
                                                          ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "Tidak diterima",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF28AE9D),
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: Text(
                                            "Lihat Lainnya",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.white,
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
                            height: 180,
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
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          top: 10,
                                        ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF28AE9D),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Lamar",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //sisi kiri
                          Column(
                            children: [
                              Container(
                                width: 190,
                                height: 350,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  //Isi dari berita
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //foto berita
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      width: 170,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Foto muncul disini",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    //Headline berita
                                    SizedBox(height: 10),
                                    Container(
                                      height: 110,
                                      width: 170,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Klaim Pengangguran AS Naik Tipis, dekati posisi terendah dalam sejarah",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //Tangal
                                    Container(
                                      width: 190,
                                      height: 90,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Jumat, 23 Desember 2025",
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
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 190,
                                height: 350,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  //Isi dari berita
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //foto berita
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      width: 170,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Foto muncul disini",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    //Headline berita
                                    SizedBox(height: 10),
                                    Container(
                                      height: 110,
                                      width: 170,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Klaim Pengangguran AS Naik Tipis, dekati posisi terendah dalam sejarah",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //Tangal
                                    Container(
                                      width: 190,
                                      height: 90,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Jumat, 23 Desember 2025",
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
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 190,
                                height: 350,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  //Isi dari berita
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //foto berita
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      width: 170,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Foto muncul disini",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    //Headline berita
                                    SizedBox(height: 10),
                                    Container(
                                      height: 110,
                                      width: 170,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Klaim Pengangguran AS Naik Tipis, dekati posisi terendah dalam sejarah",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //Tangal
                                    Container(
                                      width: 190,
                                      height: 90,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Jumat, 23 Desember 2025",
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
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                          //Sisi Kanan
                          Column(
                            children: [
                              Container(
                                width: 190,
                                height: 350,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  //Isi dari berita
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //foto berita
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      width: 170,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Foto muncul disini",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    //Headline berita
                                    SizedBox(height: 10),
                                    Container(
                                      height: 110,
                                      width: 170,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Klaim Pengangguran AS Naik Tipis, dekati posisi terendah dalam sejarah",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //Tangal
                                    Container(
                                      width: 190,
                                      height: 90,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Jumat, 23 Desember 2025",
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
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 190,
                                height: 350,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  //Isi dari berita
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //foto berita
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      width: 170,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Foto muncul disini",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    //Headline berita
                                    SizedBox(height: 10),
                                    Container(
                                      height: 110,
                                      width: 170,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Klaim Pengangguran AS Naik Tipis, dekati posisi terendah dalam sejarah",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //Tangal
                                    Container(
                                      width: 190,
                                      height: 90,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Jumat, 23 Desember 2025",
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
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 190,
                                height: 350,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  //Isi dari berita
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //foto berita
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      width: 170,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Foto muncul disini",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    //Headline berita
                                    SizedBox(height: 10),
                                    Container(
                                      height: 110,
                                      width: 170,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Klaim Pengangguran AS Naik Tipis, dekati posisi terendah dalam sejarah",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //Tangal
                                    Container(
                                      width: 190,
                                      height: 90,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Jumat, 23 Desember 2025",
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
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Test Safe   Area",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Center(
                    child: Text("Page 2", style: TextStyle(fontSize: 24)),
                  ),
                ),
              ],
            ),

            // PAGE 3 - LAMARAN
            Column(
              children: [
                // HEADER
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFF28AE9D)),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lamaran Pekerjaan",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // TAB BAR
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabControllerPage3,
                    indicatorColor: const Color(0xFF28AE9D),
                    indicatorWeight: 3,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: const [
                      Tab(text: "Diproses"),
                      Tab(text: "Diterima"),
                      Tab(text: "Ditolak"),
                    ],
                  ),
                ),

                // TAB CONTENT
                Expanded(
                  child: TabBarView(
                    controller: _tabControllerPage3,
                    children: [
                      // TAB 1: Diproses
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: ListView(
                          children: [
                            lamaran(
                              companyName: "PT Garuda Indonesia",
                              status: "Diproses",
                            ),
                            lamaran(
                              companyName: "PT Coca-Cola",
                              status: "Diproses",
                            ),
                          ],
                        ),
                      ),

                      // TAB 2: Diterima
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: ListView(
                          children: [
                            lamaran(
                              companyName: "PT Indomie",
                              status: "Diterima",
                            ),
                            lamaran(
                              companyName: "PT Astra International",
                              status: "Diterima",
                            ),
                          ],
                        ),
                      ),

                      // TAB 3: Ditolak
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: ListView(
                          children: [
                            lamaran(
                              companyName: "PT Unilever",
                              status: "Ditolak",
                            ),
                            lamaran(
                              companyName: "PT Tokopedia",
                              status: "Ditolak",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // PAGE 4 - JADWAL WAWANCARA
            Column(
              children: [
                // HEADER
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Color(0xFF28AE9D)),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jadwal Wawancara",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // TAB BAR
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabControllerPage4,
                    indicatorColor: const Color(0xFF28AE9D),
                    indicatorWeight: 3,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: const [
                      Tab(text: "Akan Datang"),
                      Tab(text: "Riwayat"),
                    ],
                  ),
                ),

                // TAB CONTENT
                Expanded(
                  child: TabBarView(
                    controller: _tabControllerPage4,
                    children: [
                      // TAB 1: Akan Datang
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: ListView(
                          children: [
                            wawancara(
                              date: "20-06-2025",
                              time: "16.00 PM",
                              company: "PT. APRL",
                            ),
                            wawancara(
                              date: "22-06-2025",
                              time: "15.00 PM",
                              company: "PT. ASTRA",
                            ),
                            wawancara(
                              date: "02-07-2025",
                              time: "10.00 AM",
                              company: "PT. COCACQUA",
                            ),
                          ],
                        ),
                      ),

                      // TAB 2: Riwayat
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: ListView(
                          children: [
                            wawancara(
                              date: "15-06-2025",
                              time: "14.00 PM",
                              company: "PT. Google Indonesia",
                              isCompleted: true,
                            ),
                            wawancara(
                              date: "10-06-2025",
                              time: "09.00 AM",
                              company: "PT. Microsoft Asia",
                              isCompleted: true,
                            ),
                            wawancara(
                              date: "05-06-2025",
                              time: "13.30 PM",
                              company: "PT. Amazon Web Services",
                              isCompleted: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: PhysicalModel(
        color: Colors.white,
        elevation: 8,
        shadowColor: Colors.black,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Page 1"),
            BottomNavigationBarItem(icon: Icon(Icons.work), label: "Page 2"),
            BottomNavigationBarItem(icon: Icon(Icons.task), label: "Lamaran"),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: "Jadwal",
            ),
          ],
        ),
      ),
    );
  }
}
