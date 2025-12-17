import 'package:flutter/material.dart';
import '../../../database/db_helper.dart';
import '../../../widget/wawancara_card_perusahaan.dart';

class JadwalWawancaraPerusahaan extends StatefulWidget {
  final int perusahaanId;

  const JadwalWawancaraPerusahaan({super.key, required this.perusahaanId});

  @override
  State<JadwalWawancaraPerusahaan> createState() =>
      _JadwalWawancaraPerusahaanState();
}

class _JadwalWawancaraPerusahaanState extends State<JadwalWawancaraPerusahaan> {
  List<Map<String, dynamic>> upcoming = [];
  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    _loadWawancara();
  }

  Future<void> _loadWawancara() async {
    final data = await DBHelper.getWawancaraByPerusahaanId(widget.perusahaanId);

    List<Map<String, dynamic>> listUpcoming = [];
    List<Map<String, dynamic>> listHistory = [];

    for (var row in data) {
      final item = Map<String, dynamic>.from(row);

      item["posisi"] = await DBHelper.getPosisiByLowonganId(
        item["lowongan_id"],
      );

      item["nama_user"] = await DBHelper.getNamaUserById(item["user_id"]);

      if (item["status"] == "process") {
        listUpcoming.add(item);
      } else {
        listHistory.add(item);
      }
    }

    setState(() {
      upcoming = listUpcoming;
      history = listHistory;
    });
  }

  void _showDetailDialog(Map<String, dynamic> wawancara) async {
    final perusahaanName = await DBHelper.getNamaPerusahaan(
      wawancara["perusahaan_id"],
    );
    final posisi = await DBHelper.getPosisiByLowonganId(
      wawancara["lowongan_id"],
    );
    final namaPelamar = await DBHelper.getNamaUserById(wawancara["user_id"]);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Detail Wawancara"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pelamar: $namaPelamar"),
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
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text("Belum ada wawancara."),
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
            namaUser: w["nama_user"],
            userId: w["user_id"],
            lowonganId: w["lowongan_id"],
            perusahaanId: widget.perusahaanId,
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
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Color(0xFF28AE9D)),
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jadwal Wawancara Perusahaan",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        // TAB
        DefaultTabController(
          length: 2,
          child: Expanded(
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Color(0xFF28AE9D),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: "Akan Datang"),
                    Tab(text: "Riwayat"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [_buildList(upcoming), _buildList(history)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
