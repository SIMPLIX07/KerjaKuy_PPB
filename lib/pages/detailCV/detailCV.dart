import 'package:flutter/material.dart';
import '../../database/db_helper.dart';

class DetailCVPelamarPage extends StatefulWidget {
  final int cvId;

  const DetailCVPelamarPage({super.key, required this.cvId});

  @override
  State<DetailCVPelamarPage> createState() => _DetailCVPelamarPageState();
}

class _DetailCVPelamarPageState extends State<DetailCVPelamarPage> {
  Map<String, dynamic>? cv;
  List<Map<String, dynamic>> skills = [];
  List<Map<String, dynamic>> pengalaman = [];
  Map<String, dynamic>? kontak;
  String namaPelamar = "";

  @override
  void initState() {
    super.initState();
    _loadCV();
  }

  Future<void> _loadCV() async {
    final db = await DBHelper.getDBPublic();

    // Ambil data CV
    final cvData = await db.query(
      "cv",
      where: "id = ?",
      whereArgs: [widget.cvId],
    );

    if (cvData.isEmpty) return;

    final cvRow = cvData.first;

    // Ambil nama user berdasarkan user_id dari tabel users
    final userData = await db.query(
      "users",
      where: "id = ?",
      whereArgs: [cvRow["user_id"]],
      limit: 1,
    );

    // Ambil skill
    final skillData = await db.query(
      "skillCV",
      where: "cv_id = ?",
      whereArgs: [widget.cvId],
    );

    // Ambil pengalaman
    final pengalamanData = await db.query(
      "pengalaman",
      where: "cv_id = ?",
      whereArgs: [widget.cvId],
    );

    // Ambil kontak
    final kontakData = await db.query(
      "kontak",
      where: "cv_id = ?",
      whereArgs: [widget.cvId],
    );

    setState(() {
      cv = cvRow;
      skills = skillData;
      pengalaman = pengalamanData;
      kontak = kontakData.isNotEmpty ? kontakData.first : null;

      namaPelamar = userData.isNotEmpty
          ? userData.first["fullname"].toString()
          : "Nama Tidak Ada";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (cv == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),

            // HEADER + FOTO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // <<< PAKAI NAMA DARI USERS
                      Text(
                        namaPelamar,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Pendidikan: ${cv!["jurusan"]}",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // SCROLL BODY
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ====================== RESUME CONTAINER ======================
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Resume",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Tentang Saya
                          const Text(
                            "Tentang Saya",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(cv!["tentang_saya"] ?? "-"),
                          const SizedBox(height: 20),

                          // Pendidikan
                          const Text(
                            "Pendidikan",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Universitas : ${cv!["universitas"]}"),
                          Text("Jurusan : ${cv!["jurusan"]}"),
                          const SizedBox(height: 20),

                          // Skill
                          const Text(
                            "Skill",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),

                          ...skills.map((s) {
                            double kemampuan = (s["kemampuan"] ?? 0).toDouble();
                            double percent = kemampuan / 100;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text("• ${s["skill"]}"),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: SizedBox(
                                      height:
                                          8, 
                                      child: LinearProgressIndicator(
                                        value: percent,
                                        color: Colors.teal,
                                        backgroundColor: Colors.teal.shade100,
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ), 
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text("${kemampuan.toInt()}%"),
                                ],
                              ),
                            );
                          }),

                          const SizedBox(height: 20),

                          // Pengalaman
                          const Text(
                            "Pengalaman",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),

                          ...pengalaman.map((p) {
                            return Text(
                              "${p["pengalaman"]} : ${p["durasi"]}",
                              style: const TextStyle(fontSize: 14),
                            );
                          }),

                          const SizedBox(height: 20),

                          // Kontak
                          const Text(
                            "Kontak",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("Email : ${kontak?["email"] ?? '-'}"),
                          Text("No. Telp : ${kontak?["no_telepon"] ?? '-'}"),
                          Text("LinkedIn : ${kontak?["linkedIn"] ?? '-'}"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // ====================== BUTTON BAWAH ======================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print("DITOLAK CV ${widget.cvId}");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Tolak"),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print("DITERIMA CV ${widget.cvId}");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Terima"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
