import 'package:flutter/material.dart';
import '../../../database/db_helper.dart';

class KaryawanPerusahaanTab extends StatefulWidget {
  final int perusahaanId;
  const KaryawanPerusahaanTab({super.key, required this.perusahaanId});

  @override
  State<KaryawanPerusahaanTab> createState() => _KaryawanPerusahaanTabState();
}

class _KaryawanPerusahaanTabState extends State<KaryawanPerusahaanTab> {
  List<Map<String, dynamic>> categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoading = true);
    final data = await DBHelper.getKategoriKaryawan(widget.perusahaanId);
    setState(() {
      categories = data;
      _isLoading = false;
    });
  }

  void _showAcceptedApplicants(String kategori) async {
    final listKaryawan = await DBHelper.getDaftarKaryawanDiterima(
      widget.perusahaanId,
      kategori,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          "Karyawan $kategori",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: listKaryawan.isEmpty
              ? const Text("Belum ada pelamar yang diterima.")
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: listKaryawan.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFF28AE9D),
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        listKaryawan[index]['nama'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(listKaryawan[index]['posisi']),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Variabel warna card
    final colors = [
      const Color.fromARGB(255, 253, 233, 227),
      const Color(0xFFE8F5E9),
      const Color(0xFFFFF3E0),
      const Color(0xFFFFEBEE),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF28AE9D),
        elevation: 0,
        title: const Text(
          "Karyawan",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadCategories,
          color: const Color(0xFF28AE9D),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : categories.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(height: 200),
                    Center(child: Text("Belum ada kategori lowongan.")),
                  ],
                )
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final item = categories[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: colors[index % colors.length],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          item["kategori"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: const Text(
                          "Klik 'Lihat' untuk daftar karyawan diterima",
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              40,
                              174,
                              82,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () =>
                              _showAcceptedApplicants(item["kategori"]),
                          child: const Text(
                            "Lihat",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// class KaryawanPerusahaanTab extends StatelessWidget {
//   const KaryawanPerusahaanTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> dataKaryawan = [
//       {
//         "role": "UI/UX Designer",
//         "anggota": 4,
//         "color": Color(0xFFE3F2FD), 
//       },
//       {
//         "role": "Frontend Developer",
//         "anggota": 5,
//         "color": Color(0xFFE8F5E9), 
//       },
//       {
//         "role": "Backend Developer",
//         "anggota": 3,
//         "color": Color(0xFFFFF3E0), 
//       },
//       {
//         "role": "Mobile Developer",
//         "anggota": 2,
//         "color": Color(0xFFFFEBEE), 
//       },
//       {
//         "role": "HRD",
//         "anggota": 1,
//         "color": Color(0xFFF3E5F5), 
//       },
//     ];

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           "Karyawan",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: dataKaryawan.length,
//         itemBuilder: (context, index) {
//           final item = dataKaryawan[index];

//           return Card(
//             color: item["color"], 
//             elevation: 4,
//             margin: const EdgeInsets.only(bottom: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(18),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Bagian Role + Jumlah Anggota
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         item["role"],
//                         style: const TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "${item["anggota"]} anggota",
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.black54,
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Tombol Lihat Detail
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (_) {
//                           return AlertDialog(
//                             title: Text(item["role"]),
//                             content: const Text("Semua anggota"),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: const Text("Tutup"),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     child: const Text(
//                       "Lihat",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
