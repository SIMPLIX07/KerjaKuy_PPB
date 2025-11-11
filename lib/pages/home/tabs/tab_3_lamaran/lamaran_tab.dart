import 'package:flutter/material.dart';
import '../../../detail/pesan_perusahaan_page.dart';
import '../../../../widget/lamaran_card.dart';

class LamaranTab extends StatelessWidget {
  final TabController tabController;

  const LamaranTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              Tab(text: "Diproses"),
              Tab(text: "Diterima"),
              Tab(text: "Ditolak"),
            ],
          ),
        ),

        // TAB CONTENT
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              // TAB 1: Diproses
              ListView(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                children: [
                  SizedBox(height: 16.0), 
                  LamaranCard(
                    companyName: "PT Garuda Indonesia",
                    status: "Diproses",
                  ),
                  LamaranCard(
                    companyName: "PT Coca-Cola",
                    status: "Diproses",
                  ),
                ],
              ),

              // TAB 2: Diterima
              ListView(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                children: [
                  SizedBox(height: 16.0), 
                  LamaranCard(
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
                            message: "Yth. Gilang Pradana\n"
                                "\n"
                                "Kami dari PT Garuda Indonesia ingin mengucapkan selamat "
                                "atas keberhasilan Anda melewati seluruh tahapan seleksi "
                                "untuk posisi Marketing Staf.",
                          ),
                        ),
                      );
                    },
                  ),
                  LamaranCard(
                    companyName: "Telkomsel",
                    status: "Diterima",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PesanPerusahaanPage(
                            companyName: "Telkomsel",
                            date: "20 Februari 2022",
                            time: "21:00 PM",
                            message: "Yth. Gilang Pradana\n"
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

              // TAB 3: Ditolak
              ListView(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                children: [
                  SizedBox(height: 16.0), 
                  LamaranCard(
                    companyName: "PT Unilever",
                    status: "Ditolak",
                  ),
                  LamaranCard(
                    companyName: "PT Tokopedia",
                    status: "Ditolak",
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