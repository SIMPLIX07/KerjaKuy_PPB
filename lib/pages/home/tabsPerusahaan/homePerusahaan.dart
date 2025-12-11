import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/db_helper.dart';
import '../../buatLowongan/buatLowongan.dart';

class HomePerusahaan extends StatefulWidget {
  final String namaPerusahaan;
  final int perusahaanId;

  const HomePerusahaan({
    super.key,
    required this.namaPerusahaan,
    required this.perusahaanId,
  });

  @override
  State<HomePerusahaan> createState() => _HomePerusahaanState();
}

class _HomePerusahaanState extends State<HomePerusahaan> {
  List<Map<String, dynamic>> lowongan = [];

  @override
  void initState() {
    super.initState();
    _loadLowongan();
  }

  Future<void> _loadLowongan() async {
    final loadedLowongan =
        await DBHelper.getLowonganByPerusahaanId(widget.perusahaanId);

    setState(() {
      lowongan = loadedLowongan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),

            // HEADER PROFIL
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.business, size: 35),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.namaPerusahaan,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Pemilik Perusahaan",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Lowongan Anda",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 45, 45, 45),
                borderRadius: BorderRadius.circular(12),
              ),
              child: lowongan.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Text(
                          "Belum ada lowongan, ayo buat lowongan sekarang",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        for (var job in lowongan) ...[
                          Container(
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Container(
                                  height: 40,
                                  width: 5,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF28AE9D),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                const SizedBox(width: 15),

                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        job['judul'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        "Periode: ${job['mulai']} - ${job['akhir']}",
                                        style:
                                            const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    job['pelamar'].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 15),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],

                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              print("Menuju daftar lamaran");
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: const Color(0xFF28AE9D),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),

            const Spacer(),

            // BUTTON BUAT LOWONGAN
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {
                    final newLowongan = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Buatlowongan(
                          perusahaanId: widget.perusahaanId,
                          namaPerusahaan: widget.namaPerusahaan,
                        ),
                      ),
                    );

                    _loadLowongan();

                    if (newLowongan != null) {
                      setState(() {
                        lowongan.add({
                          "judul": newLowongan["posisi"],
                          "mulai": newLowongan["periode_awal"],
                          "akhir": newLowongan["periode_akhir"],
                          "pelamar": 0,
                        });
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF28AE9D),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Buat Lowongan"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
