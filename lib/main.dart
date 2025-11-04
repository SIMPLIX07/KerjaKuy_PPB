import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28AE9D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flutter_dash, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "KerjaKuy",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Masuk - KerjaKuy"),
        backgroundColor: Color(0xFF28AE9D),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Selamat Datang!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF28AE9D),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF28AE9D),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Text("Masuk"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

// Pesan perusahaan - PAGE 3
class PesanPerusahaanPage extends StatelessWidget {
  final String companyName;
  final String date;
  final String time;
  final String message;

  const PesanPerusahaanPage({
    super.key,
    required this.companyName,
    required this.date,
    required this.time,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row bar back
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: const Color(0xFF28AE9D),
              width: double.infinity,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "Pesan Perusahaan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Isi halaman
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Perusahaan
                      Text(
                        companyName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF28AE9D),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Waktu
                      Row(
                        children: [
                          Text(
                            time,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            date,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      // Pesan
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//WIDGET UNTUK PAGE 3
Widget lamaran({
  required String companyName,
  required String status,
  VoidCallback? onTap,
}) {
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

  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
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
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          const SizedBox(width: 10),
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
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(message, style: const TextStyle(fontSize: 13)),
                    Text(
                      "oleh $companyName",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
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
      home: const SplashScreen(),
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

  final List<Map<String, dynamic>> pekerjaanList = [
    {
      'posisi': 'Surfeyor FnB',
      'perusahaan': '+joddi',
      'syarat': ['kontrak', '1 tahun', 'WFO', 'Penuh Waktu'],
      'lokasi': 'Jakarta',
    },
    {
      'posisi': 'Surfeyor FnB',
      'perusahaan': '+joddi',
      'syarat': ['kontrak', '1 tahun', 'WFO', 'Penuh Waktu'],
      'lokasi': 'Jakarta',
    },
    {
      'posisi': 'Surfeyor FnB',
      'perusahaan': '+joddi',
      'syarat': ['kontrak', '1 tahun', 'WFO', 'Penuh Waktu'],
      'lokasi': 'Jakarta',
    },
  ];

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
                                        ElevatedButton(
                                          onPressed: _showAllLamaranDialog,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF28AE9D),
                                            foregroundColor: Colors.white,
                                            fixedSize: Size(100, 30),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                            height: 200,
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
                                      ElevatedButton(
                                        onPressed: () {
                                          print("Tombol Lamar ditekan!");
                                          _showJobDetailDialog(
                                            jobTitle: "Mobile Developer",
                                            companyName: "PT. Telkom INdonesia",
                                            salary:
                                                "Rp 8.000.000 - Rp 12.000.000",
                                            location:
                                                "Jakarta, Indonesia (Remote)",
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
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
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
            // Page 2
            Expanded(
              // atau langsung pakai Scaffold body
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
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10),
                          child: GridView.count(
                            shrinkWrap: true,

                            physics:
                                const NeverScrollableScrollPhysics(), 
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
                                        color: Colors.blueAccent,
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
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: GridView.count(
                      crossAxisCount: 1,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 12,
                      childAspectRatio: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: pekerjaanList.map((pk) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: const Color(0xFF28AE9D)),
                          ),
                          color: const Color.fromARGB(255, 55, 55, 55),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  style: TextStyle(color: Colors.white),
                                  pk['posisi'],
                                ),
                                subtitle: Text(
                                  style: TextStyle(color: Colors.white),
                                  pk['perusahaan'],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: GridView.count(
                                  crossAxisCount: 3, // jumlah kolom syarat
                                  mainAxisSpacing: 6,
                                  crossAxisSpacing: 6,
                                  childAspectRatio: 3.5,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: (pk['syarat'] as List<dynamic>).map(
                                    (s) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white12,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        padding: EdgeInsets.all(6),
                                        child: Text(
                                          s.toString(),
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
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
                              companyName: "PT Garuda Indonesia",
                              status: "Diterima",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PesanPerusahaanPage(
                                      companyName: "PT Garuda Indonesia",
                                      date: "5 November 2025",
                                      time: "09:00 AM",
                                      message:
                                          "Yth. Gilang Pradana\n"
                                          "\n"
                                          "Kami dari PT Garuda Indonesia ingin mengucapkan selamat "
                                          "atas keberhasilan Anda melewati seluruh tahapan seleksi "
                                          "untuk posisi Marketing Staf.",
                                    ),
                                  ),
                                );
                              },
                            ),

                            lamaran(
                              companyName: "Telkomsel",
                              status: "Diterima",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PesanPerusahaanPage(
                                      companyName: "Telkomse",
                                      date: "20 Februari 2022",
                                      time: "21:00 PM",
                                      message:
                                          "Yth. Gilang Pradana\n"
                                          "\n"
                                          "Kami dari Telkomsel ingin mengucapkan selamat "
                                          "atas keberhasilan Anda melewati seluruh tahapan seleksi "
                                          "untuk posisi Marketing Staf.",
                                    ),
                                  ),
                                );
                              },
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.work), label: "Lowongan"),
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
