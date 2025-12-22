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

  void _showKonfirmasiDialog(Map<String, dynamic> w, String status) {
    bool isAccept = status == 'accepted';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isAccept ? "Terima Pelamar" : "Tolak Pelamar"),
        content: Text(
          "Apakah anda yakin ingin ${isAccept ? 'menerimanya' : 'menolaknya'}?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isAccept ? Colors.green : Colors.red,
            ),
            onPressed: () async {
              await DBHelper.updateStatusPelamar(
                w['id'],
                w['user_id'],
                w['lowongan_id'],
                status,
              );

              if (status == 'accepted') {
                await DBHelper.acceptPelamarDanTolakYangLain(
                  userId: w['user_id'],
                  perusahaanIdDiterima: widget.perusahaanId,
                  lowonganIdDiterima: w['lowongan_id'],
                );
              }

              Navigator.pop(context);
              _loadWawancara();
            },

            child: const Text(
              "Ya, Yakin",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> list, bool isHistory) {
    if (list.isEmpty) {
      return const Center(child: Text("Belum ada data."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (_, index) {
        final w = list[index];
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 5,
                    decoration: BoxDecoration(
                      color: isHistory ? Colors.teal : Colors.amber,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text("Tanggal: ${w['tanggal']}"),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Jam: ${w['jam_mulai']} - ${w['jam_selesai']}",
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Wawancara dengan ${w['nama_user']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!isHistory)
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 28,
                          ),
                          onPressed: () => _showKonfirmasiDialog(w, 'accepted'),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 28,
                          ),
                          onPressed: () => _showKonfirmasiDialog(w, 'rejected'),
                        ),
                      ],
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        w['status'] == 'accepted'
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: w['status'] == 'accepted'
                            ? Colors.green
                            : Colors.red,
                        size: 28,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF28AE9D),
          elevation: 0,
          title: const Text(
            "Jadwal Wawancara",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              color: Colors.white,
              child: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xFF28AE9D), width: 3),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "Akan Datang"),
                  Tab(text: "Riwayat"),
                ],
              ),
            ),
          ),
        ),

        body: TabBarView(
          children: [_buildList(upcoming, false), _buildList(history, true)],
        ),
      ),
    );
  }
}

// class JadwalWawancaraPerusahaan extends StatefulWidget {
//   final int perusahaanId;

//   const JadwalWawancaraPerusahaan({super.key, required this.perusahaanId});

//   @override
//   State<JadwalWawancaraPerusahaan> createState() =>
//       _JadwalWawancaraPerusahaanState();
// }

// class _JadwalWawancaraPerusahaanState extends State<JadwalWawancaraPerusahaan> {
//   List<Map<String, dynamic>> upcoming = [];
//   List<Map<String, dynamic>> history = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadWawancara();
//   }

//   Future<void> _loadWawancara() async {
//     final data = await DBHelper.getWawancaraByPerusahaanId(widget.perusahaanId);

//     List<Map<String, dynamic>> listUpcoming = [];
//     List<Map<String, dynamic>> listHistory = [];

//     for (var row in data) {
//       final item = Map<String, dynamic>.from(row);

//       item["posisi"] = await DBHelper.getPosisiByLowonganId(
//         item["lowongan_id"],
//       );

//       item["nama_user"] = await DBHelper.getNamaUserById(item["user_id"]);

//       if (item["status"] == "process") {
//         listUpcoming.add(item);
//       } else {
//         listHistory.add(item);
//       }
//     }

//     setState(() {
//       upcoming = listUpcoming;
//       history = listHistory;
//     });
//   }

//   void _showDetailDialog(Map<String, dynamic> wawancara) async {
//     final perusahaanName = await DBHelper.getNamaPerusahaan(
//       wawancara["perusahaan_id"],
//     );
//     final posisi = await DBHelper.getPosisiByLowonganId(
//       wawancara["lowongan_id"],
//     );
//     final namaPelamar = await DBHelper.getNamaUserById(wawancara["user_id"]);

//     showDialog(
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           title: Text("Detail Wawancara"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Pelamar: $namaPelamar"),
//               Text("Posisi: $posisi"),
//               Text("Tanggal: ${wawancara['tanggal']}"),
//               Text(
//                 "Jam: ${wawancara['jam_mulai']} - ${wawancara['jam_selesai']}",
//               ),
//               Text("Link Meet: ${wawancara['link_meet']}"),
//               Text("Pesan: ${wawancara['pesan']}"),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: Text("Tutup"),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildList(List<Map<String, dynamic>> list) {
//     if (list.isEmpty) {
//       return Center(
//         child: Padding(
//           padding: EdgeInsets.only(top: 20),
//           child: Text("Belum ada wawancara."),
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: list.length,
//       itemBuilder: (_, index) {
//         final w = list[index];

//         return GestureDetector(
//           onTap: () => _showDetailDialog(w),
//           child: WawancaraCard(
//             date: w["tanggal"],
//             time: "${w['jam_mulai']} - ${w['jam_selesai']}",
//             namaUser: w["nama_user"],
//             userId: w["user_id"],
//             lowonganId: w["lowongan_id"],
//             perusahaanId: widget.perusahaanId,
//             isCompleted: w["status"] != "process",
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(color: Color(0xFF28AE9D)),
//           child: SafeArea(
//             bottom: false,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Jadwal Wawancara Perusahaan",
//                   style: TextStyle(
//                     fontSize: 22,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),

//         // TAB
//         DefaultTabController(
//           length: 2,
//           child: Expanded(
//             child: Column(
//               children: [
//                 TabBar(
//                   indicatorColor: Color(0xFF28AE9D),
//                   labelColor: Colors.black,
//                   unselectedLabelColor: Colors.grey,
//                   tabs: const [
//                     Tab(text: "Akan Datang"),
//                     Tab(text: "Riwayat"),
//                   ],
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     children: [_buildList(upcoming), _buildList(history)],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
