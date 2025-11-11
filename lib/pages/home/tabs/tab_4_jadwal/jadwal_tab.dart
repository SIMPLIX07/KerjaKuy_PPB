import 'package:flutter/material.dart';
import '../../../../widget/wawancara_card.dart';

class JadwalTab extends StatelessWidget {
  final TabController tabController;

  const JadwalTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            controller: tabController,
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
            controller: tabController,
            children: [
              // TAB 1: Akan Datang
              ListView(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                children: [
                  SizedBox(height: 16.0),
                  WawancaraCard(
                    date: "20-06-2025",
                    time: "16.00 PM",
                    company: "PT. APRL",
                  ),
                  WawancaraCard(
                    date: "22-06-2025",
                    time: "15.00 PM",
                    company: "PT. ASTRA",
                  ),
                  WawancaraCard(
                    date: "02-07-2025",
                    time: "10.00 AM",
                    company: "PT. COCACQUA",
                  ),
                ],
              ),

              // TAB 2: Riwayat
              ListView(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                children: [
                  SizedBox(height: 16.0), 
                  WawancaraCard(
                    date: "15-06-2025",
                    time: "14.00 PM",
                    company: "PT. Google Indonesia",
                    isCompleted: true,
                  ),
                  WawancaraCard(
                    date: "10-06-2025",
                    time: "09.00 AM",
                    company: "PT. Microsoft Asia",
                    isCompleted: true,
                  ),
                  WawancaraCard(
                    date: "05-06-2025",
                    time: "13.30 PM",
                    company: "PT. Amazon Web Services",
                    isCompleted: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}