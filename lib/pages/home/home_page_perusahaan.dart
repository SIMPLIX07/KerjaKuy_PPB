import 'package:flutter/material.dart';
//import 'tabsPerusahaan/tab_1_home_perusahaan.dart';
//import 'tabsPerusahaan/tab_2_lowongan_saya.dart';
import 'tabsPerusahaan/karyawanPerusahaan.dart';
import 'tabsPerusahaan/homePerusahaan.dart';
import 'tabsPerusahaan/jadwal_wawancara_perusahaan.dart';

class HomePagePerusahaan extends StatefulWidget {
  final int perusahaanId;
  final String namaPerusahaan;
  const HomePagePerusahaan({
    super.key,
    required this.namaPerusahaan,
    required this.perusahaanId,
  });

  @override
  State<HomePagePerusahaan> createState() => _HomePagePerusahaanState();
}

class _HomePagePerusahaanState extends State<HomePagePerusahaan>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: false,
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomePerusahaan(
              namaPerusahaan: widget.namaPerusahaan,
              perusahaanId: widget.perusahaanId,
            ),
            KaryawanPerusahaanTab(perusahaanId: widget.perusahaanId),
            JadwalWawancaraPerusahaan(perusahaanId: widget.perusahaanId),
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
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.work), label: "Lowongan"),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Karyawan",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: "Wawancara",
            ),
          ],
        ),
      ),
    );
  }
}
