import 'package:flutter/material.dart';
import '../../database/db_helper.dart';

class DetailCVPelamarPage extends StatefulWidget {
  final int lowonganId;
  final int perusahaanId;
  final int userId;
  final int cvId;

  const DetailCVPelamarPage({
    super.key,
    required this.cvId,
    required this.lowonganId,
    required this.perusahaanId,
    required this.userId,
  });

  @override
  State<DetailCVPelamarPage> createState() => _DetailCVPelamarPageState();
}

class _DetailCVPelamarPageState extends State<DetailCVPelamarPage> {
  Map<String, dynamic>? cv;
  List<Map<String, dynamic>> skills = [];
  List<Map<String, dynamic>> pengalaman = [];
  Map<String, dynamic>? kontak;
  String namaPelamar = "";

  void _showTolakDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Tolak Pelamar",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text("Apakah Anda yakin ingin menolak pelamar ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                // 🔴 PANGGIL FUNCTION TOLAK
                await DBHelper.tolakPelamar(
                  userId: widget.userId,
                  lowonganId: widget.lowonganId,
                  perusahaanId: widget.perusahaanId,
                );

                Navigator.pop(context); // tutup dialog
                Navigator.pop(context, true); // kembali ke list pelamar

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pelamar berhasil ditolak")),
                );
              },
              child: const Text("Ya, Tolak"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Berhasil",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text("Jadwal wawancara berhasil disubmit."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

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

  void _showWawancaraDialog() {
    DateTime? selectedDate;
    TimeOfDay? jamMulai;
    TimeOfDay? jamSelesai;

    final linkController = TextEditingController();
    final pesanController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                "Jadwalkan Wawancara",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TANGGAL
                    const Text("Tanggal"),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2035),
                        );
                        if (picked != null) {
                          setState(() => selectedDate = picked);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          selectedDate == null
                              ? "Pilih tanggal"
                              : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // JAM MULAI
                    const Text("Jam Mulai"),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          setState(() => jamMulai = picked);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          jamMulai == null
                              ? "Pilih jam mulai"
                              : "${jamMulai!.hour.toString().padLeft(2, '0')}:${jamMulai!.minute.toString().padLeft(2, '0')}",
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // JAM SELESAI
                    const Text("Jam Selesai"),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          setState(() => jamSelesai = picked);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          jamSelesai == null
                              ? "Pilih jam selesai"
                              : "${jamSelesai!.hour.toString().padLeft(2, '0')}:${jamSelesai!.minute.toString().padLeft(2, '0')}",
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // LINK MEET
                    const Text("Link Meet"),
                    TextField(
                      controller: linkController,
                      decoration: const InputDecoration(
                        hintText: "https://meet.google.com/xxxx",
                      ),
                    ),

                    const SizedBox(height: 15),

                    // PESAN
                    const Text("Pesan untuk pelamar"),
                    TextField(
                      controller: pesanController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: "Pesan singkat...",
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedDate == null ||
                        jamMulai == null ||
                        jamSelesai == null ||
                        linkController.text.isEmpty ||
                        pesanController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Semua field wajib diisi"),
                        ),
                      );
                      return;
                    }

                    final tanggal =
                        "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}";
                    final mulai =
                        "${jamMulai!.hour.toString().padLeft(2, '0')}:${jamMulai!.minute.toString().padLeft(2, '0')}";
                    final selesai =
                        "${jamSelesai!.hour.toString().padLeft(2, '0')}:${jamSelesai!.minute.toString().padLeft(2, '0')}";

                    await DBHelper.buatWawancara(
                      userId: widget.userId,
                      perusahaanId: widget.perusahaanId,
                      lowonganId: widget.lowonganId,
                      jamMulai: mulai,
                      jamSelesai: selesai,
                      tanggal: tanggal,
                      linkMeet: linkController.text,
                      pesan: pesanController.text,
                    );

                    print("=== WAWANCARA DIBUAT ===");
                    print("User ID: ${widget.userId}");
                    print("Perusahaan ID: ${widget.perusahaanId}");
                    print("Lowongan ID: ${widget.lowonganId}");
                    print("Tanggal: $tanggal");
                    print("Mulai: $mulai");
                    print("Selesai: $selesai");
                    print("Link Meet: ${linkController.text}");
                    print("Pesan: ${pesanController.text}");
                    print("===========================");

                    Navigator.pop(context);
                    _showSuccessDialog();
                  },
                  child: const Text("Kirim"),
                ),
              ],
            );
          },
        );
      },
    );
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
                                      height: 8,
                                      child: LinearProgressIndicator(
                                        value: percent,
                                        color: Colors.teal,
                                        backgroundColor: Colors.teal.shade100,
                                        borderRadius: BorderRadius.circular(10),
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
                      onPressed: _showTolakDialog,
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
                        print("Wawancara CV ${widget.cvId}");
                        _showWawancaraDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 126, 118, 4),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Wawancara"),
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
