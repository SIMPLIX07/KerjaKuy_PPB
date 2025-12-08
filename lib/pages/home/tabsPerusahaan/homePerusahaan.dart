import 'package:flutter/material.dart';

class HomePerusahaan extends StatelessWidget {
  final String namaPerusahaan;

  const HomePerusahaan({super.key, required this.namaPerusahaan});

  @override
  Widget build(BuildContext context) {
    // Dummy data lowongan
    final List<Map<String, dynamic>> lowongan = [
      {
        'judul': 'Marketing',
        'pelamar': 8,
        'mulai': '02-01-2025',
        'akhir': '25-01-2025',
      },
      {
        'judul': 'Software Engineering',
        'pelamar': 5,
        'mulai': '12-03-2025',
        'akhir': '30-03-2025',
      },
      {
        'judul': 'UI UX',
        'pelamar': 5,
        'mulai': '12-03-2025',
        'akhir': '30-03-2025',
      },
    ];

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
                        namaPerusahaan,
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

            // JUDUL SECTION
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Lowongan Anda",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            // CARD HITAM BERISI LOWONGAN
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 45, 45, 45),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // LIST LOWONGAN
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
                          // Teks Lowongan + Periode
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job['judul'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Periode: ${job['mulai']} - ${job['akhir']}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          // Badges pelamar
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

                  // TOMBOL PANAH
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        print("Menuju daftar lamaran untuk semua lowongan");
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
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    print("Tombol Buat Lowongan ditekan");
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
