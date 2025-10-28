import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

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
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(12),
                                ),
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
                          borderRadius: BorderRadius.circular(12)
                        ), 
                      ),
                    ),
                    ),
                    //section lamaran
                    Container(
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Text("Lamaran Anda", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Container(  // Pembungkus Hitam
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 200, 
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 36, 33, 33),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Container( //Garuda Indonesia
                                  width: 300 * 0.9,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row( // isi dari garuda
                                    children: [
                                      SizedBox(width: 5,),
                                      Container(
                                        height: 40,
                                        width: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(90)
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Icon(Icons.pedal_bike_rounded, size: 40,),
                                      SizedBox(width: 5,),
                                      Container(
                                        width: 200,
                                        height: 40,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Selamat anda diterima di perusahaan", style: TextStyle(fontSize: 12),),
                                            Text("PT Garuda Indonesia", style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container( //Garuda Indonesia
                                  width: 300 * 0.9,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row( // isi dari garuda
                                    children: [
                                      SizedBox(width: 5,),
                                      Container(
                                        height: 40,
                                        width: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(90)
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Icon(Icons.pedal_bike_rounded, size: 40,),
                                      SizedBox(width: 5,),
                                      Container(
                                        width: 200,
                                        height: 40,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Mohon Maaf anda belum diterima", style: TextStyle(fontSize: 12),),
                                            Text("PT Garuda Indonesia", style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  width: 300 * 0.9,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 50,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row( // diterima
                                              children: [
                                                Container(
                                                  height: 5,
                                                  width: 5,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(255, 0, 255, 81),
                                                    borderRadius: BorderRadius.circular(50)
                                                  ),
                                                ),
                                                SizedBox(width: 3,),
                                                Text("Diterima", style: TextStyle(color: Colors.white),)
                                              ],
                                            ),
                                            Row( // diterima
                                              children: [
                                                Container(
                                                  height: 5,
                                                  width: 5,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(255, 255, 0, 0),
                                                    borderRadius: BorderRadius.circular(50)
                                                  ),
                                                ),
                                                SizedBox(width: 3,),
                                                Text("Ditolak" ,style: TextStyle(color: Colors.white),)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 30,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.lightGreen,
                                          borderRadius: BorderRadius.circular(30)
                                        ),
                                        child: Text("Lihat Lainnya", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                    //Section rekomendasi
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
            Center(child: Text("Page 3", style: TextStyle(fontSize: 24))),
            Center(child: Text("Page 3", style: TextStyle(fontSize: 24))),
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
