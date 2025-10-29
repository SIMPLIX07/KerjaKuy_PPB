import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

Widget _buildInterviewItem({
  required String date,
  required String time,
  required String company,
  bool isCompleted = false,
}) {
  return Container(
    padding: EdgeInsets.all(16),
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tanggal: $date",
          style: TextStyle(
            fontSize: 14,
            color: isCompleted ? Colors.grey : Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Jam: $time",
          style: TextStyle(
            fontSize: 14,
            color: isCompleted ? Colors.grey : Colors.black,
          ),
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
        if (isCompleted)
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "Selesai",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
            Stack(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      //avatar
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      //data user
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 120),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Icon(Icons.notifications),
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
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 190,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Cari",
                          hintText: "Masukkan jenis pekerjaan",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    //section lamaran
                    Container(
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Text(
                            "Lamaran Anda",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
                                  width: 300 * 0.9,
                                  height: 50,
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
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(
                                            90,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.pedal_bike_rounded, size: 40),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 200,
                                        height: 40,
                                        child: Column(
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
                                  width: 300 * 0.9,
                                  height: 50,
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
                                      SizedBox(width: 10),
                                      Icon(Icons.pedal_bike_rounded, size: 40),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 200,
                                        height: 40,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Mohon Maaf anda belum diterima",
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
                                  width: 300 * 0.9,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
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
                                                    color: const Color.fromARGB(
                                                      255,
                                                      0,
                                                      255,
                                                      81,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          50,
                                                        ),
                                                  ),
                                                ),
                                                SizedBox(width: 3),
                                                Text(
                                                  "Diterima",
                                                  style: TextStyle(
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
                                                        BorderRadius.circular(
                                                          50,
                                                        ),
                                                  ),
                                                ),
                                                SizedBox(width: 3),
                                                Text(
                                                  "Ditolak",
                                                  style: TextStyle(
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
                                          color: Colors.lightGreen,
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Text(
                                          "Lihat Lainnya",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
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
                    SizedBox(height: 10),
                    Text(
                      "Rekomendasi",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 160,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 246, 243, 243),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Icon(Icons.biotech, size: 70),
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
                              Align(
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
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          border: Border.all(
                                            color: Colors.green,
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
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          border: Border.all(
                                            color: Colors.green,
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
                              Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      width: 120,
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_city, size: 20),
                                          SizedBox(width: 5),
                                          Text("Jakarta Pusat"),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Lamar",
                                          style: TextStyle(color: Colors.white),
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
                    SizedBox(height: 5),
                    Text(
                      "Berita Pekerjaan",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //sisi kiri
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 120 - 72,
                              decoration: BoxDecoration(color: Colors.amber),
                            ),
                          ],
                        ),
                        //Sisi Kanan
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 120 - 72,
                              decoration: BoxDecoration(color: Colors.amber),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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

            // PAGE 3
            Column(
              children: [
                // HEADER
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 17, 209, 174),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jadwal \nWawancara",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),

                // TAB BAR DI BAWAH HEADER - DIPINDAH KELUAR DARI HEADER
                Container(
                  color: const Color.fromARGB(255, 255, 255, 255), // Warna sama dengan header
                  child: Container(
                    height: 50,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: const Color.fromARGB(255, 17, 209, 174),
                      indicatorWeight: 3,
                      labelColor: const Color.fromARGB(255, 0, 0, 0),
                      unselectedLabelColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      tabs: [
                        Tab(text: "Akan Datang"),
                        Tab(text: "Riwayat"),
                      ],
                    ),
                  ),
                ),

                // TAB BAR VIEW UNTUK KONTEN
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // TAB 1: AKAN DATANG
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Wawancara Mendatang",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 12),
                            Expanded(
                              child: ListView(
                                children: [
                                  _buildInterviewItem(
                                    date: "20-06-2025",
                                    time: "16.00 PM",
                                    company: "PT. APRL",
                                  ),

                                  _buildInterviewItem(
                                    date: "22-06-2025",
                                    time: "15.00 PM",
                                    company: "PT. ASTRA",
                                  ),

                                  _buildInterviewItem(
                                    date: "02-07-2025",
                                    time: "10.00 AM",
                                    company: "PT. COCACQUA",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // TAB 2: SELESAI
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Riwayat Wawancara",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Daftar wawancara yang telah diselesaikan",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 12),
                            Expanded(
                              child: ListView(
                                children: [
                                  _buildInterviewItem(
                                    date: "15-06-2025",
                                    time: "14.00 PM",
                                    company: "PT. Google Indonesia",
                                    isCompleted: true,
                                  ),
                                  _buildInterviewItem(
                                    date: "10-06-2025",
                                    time: "09.00 AM",
                                    company: "PT. Microsoft Asia",
                                    isCompleted: true,
                                  ),
                                  _buildInterviewItem(
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
                ),
              ],
            ),

            Center(child: Text("Page 4", style: TextStyle(fontSize: 24))),
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
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: "Page 3",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.task), label: "Page 4"),
          ],
        ),
      ),
    );
  }
}
