import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
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
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: const [
            Center(
              child: Text(
                "Page 1",
                style: TextStyle(
                  fontSize: 24)
                  )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Test Safe Area",
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Page 2",
                      style: TextStyle(
                        fontSize: 24)
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                "Page 3",
                style: TextStyle(
                  fontSize: 24
                  )
              )
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Page 1"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Page 2"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Page 3"),
        ],
      ),
    );
  }
}
