import 'package:flutter/material.dart';
import '../../../../widget/wawancara_card.dart';
import '../../../../database/db_helper.dart';

class JadwalTab extends StatefulWidget {
  final int userId;
  final TabController tabController;

  const JadwalTab({
    super.key,
    required this.tabController,
    required this.userId,
  });

  @override
  State<JadwalTab> createState() => _JadwalTabState();
}

class _JadwalTabState extends State<JadwalTab> {
  List<Map<String, dynamic>> akanDatang = [];
  List<Map<String, dynamic>> riwayat = [];

  @override
  void initState() {
    super.initState();
    _loadWawancara();
  }

  Future<void> _loadWawancara() async {
    final data = await DBHelper.getWawancaraByUserId(widget.userId);

    List<Map<String, dynamic>> upcoming = [];
    List<Map<String, dynamic>> history = [];

    for (var item in data) {
      final mapItem = Map<String, dynamic>.from(item);
      final namaPerusahaan = await DBHelper.getNamaPerusahaan(
        mapItem["perusahaan_id"],
      );
      mapItem["nama_perusahaan"] = namaPerusahaan;
      if ((mapItem["status"] ?? "").toLowerCase() == "process") {
        upcoming.add(mapItem);
      } else {
        history.add(mapItem);
      }
    }

    setState(() {
      akanDatang = upcoming;
      riwayat = history;
    });
  }

  void _showDetailDialog(Map<String, dynamic> wawancara) async {
    final perusahaanName = await DBHelper.getNamaPerusahaan(
      wawancara["perusahaan_id"],
    );
    final posisi = await DBHelper.getPosisiByLowonganId(
      wawancara["lowongan_id"],
    );

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Detail Wawancara"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Perusahaan: $perusahaanName"),
              Text("Posisi: $posisi"),
              Text("Tanggal: ${wawancara['tanggal']}"),
              Text(
                "Jam: ${wawancara['jam_mulai']} - ${wawancara['jam_selesai']}",
              ),
              Text("Link Meet: ${wawancara['link_meet']}"),
              Text("Pesan: ${wawancara['pesan']}"),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Tutup"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Widget _buildList(List<Map<String, dynamic>> list) {
    if (list.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text("Belum ada jadwal wawancara."),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (_, index) {
        final w = list[index];

        return GestureDetector(
          onTap: () => _showDetailDialog(w),
          child: WawancaraCard(
            date: w["tanggal"],
            time: "${w['jam_mulai']} - ${w['jam_selesai']}",
            company: w["nama_perusahaan"] ?? "Perusahaan",
            isCompleted: w["status"] != "process",
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Color(0xFF28AE9D)),
          child: SafeArea(
            bottom: false,
            child: Text(
              "Jadwal Wawancara",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        TabBar(
          controller: widget.tabController,
          indicatorColor: const Color(0xFF28AE9D),
          indicatorWeight: 3,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "Akan Datang"),
            Tab(text: "Riwayat"),
          ],
        ),

        Expanded(
          child: TabBarView(
            controller: widget.tabController,
            children: [_buildList(akanDatang), _buildList(riwayat)],
          ),
        ),
      ],
    );
  }
}
