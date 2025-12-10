import 'package:flutter/material.dart';
import 'tabs/tab_1_home/home_tab.dart';
import 'tabs/tab_2_lowongan/lowongan_tab.dart';
import 'tabs/tab_3_lamaran/lamaran_tab.dart';
import 'tabs/tab_4_jadwal/jadwal_tab.dart';

class HomePage extends StatefulWidget {
  final int userId;
  final String username;
  final String jobTitle;

  const HomePage({super.key,required this.userId,required this.username, required this.jobTitle});

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
    _pageController.dispose();
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
            // PAGE 1 - HOME
            HomeTab(
              userId:widget.userId,
              username: widget.username,
              jobTitle: widget.jobTitle,
              onLihatLainnyaPressed: () {
                _onItemTapped(2); //ke page 3
              },
            ),

            // PAGE 2 - LOWONGAN
            LowonganTab(),

            // PAGE 3 - LAMARAN
            LamaranTab(tabController: _tabControllerPage3),

            // PAGE 4 - JADWAL WAWANCARA
            JadwalTab(tabController: _tabControllerPage4),
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
