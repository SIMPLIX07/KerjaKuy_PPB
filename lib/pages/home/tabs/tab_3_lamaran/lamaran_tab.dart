import 'package:flutter/material.dart';
import '../../../../database/db_helper.dart';
import '../../../detail/pesan_perusahaan_page.dart';
import '../../../../widget/lamaran_card.dart';

class LamaranTab extends StatefulWidget {
  final TabController tabController;
  final int userId;

  const LamaranTab({
    super.key,
    required this.tabController,
    required this.userId,
  });

  @override
  State<LamaranTab> createState() => _LamaranTabState();
}

class _LamaranTabState extends State<LamaranTab> {
  List<Map<String, dynamic>> diproses = [];
  List<Map<String, dynamic>> diterima = [];
  List<Map<String, dynamic>> ditolak = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLamaran();
  }

  Future<void> _loadLamaran() async {
    final data = await DBHelper.getLamaranByUserId(widget.userId);

    List<Map<String, dynamic>> p = [];
    List<Map<String, dynamic>> a = [];
    List<Map<String, dynamic>> r = [];

    for (var item in data) {
      if (item["status"] == "Process") {
        p.add(item);
      } else if (item["status"] == "Diterima") {
        a.add(item);
      } else if (item["status"] == "Ditolak") {
        r.add(item);
      }
    }

    setState(() {
      diproses = p;
      diterima = a;
      ditolak = r;
      isLoading = false;
    });
  }

  Widget _buildList(List<Map<String, dynamic>> list,
      {bool clickable = false}) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (list.isEmpty) {
      return const Center(child: Text("Belum ada lamaran."));
    }

    return RefreshIndicator(
      onRefresh: _loadLamaran,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        itemCount: list.length,
        itemBuilder: (_, index) {
          final item = list[index];

          return LamaranCard(
            companyName: item["namaPerusahaan"],
            status: item["status"],
            onTap: clickable
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PesanPerusahaanPage(
                          companyName: item["namaPerusahaan"],
                          date: "-",
                          time: "-",
                          message:
                              "Selamat! Anda diterima untuk posisi ${item["posisi"]}.",
                        ),
                      ),
                    );
                  }
                : null,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // HEADER
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: Color(0xFF28AE9D)),
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
            controller: widget.tabController,
            indicatorColor: const Color(0xFF28AE9D),
            indicatorWeight: 3,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
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
            controller: widget.tabController,
            children: [
              _buildList(diproses),
              _buildList(diterima, clickable: true),
              _buildList(ditolak),
            ],
          ),
        ),
      ],
    );
  }
}
