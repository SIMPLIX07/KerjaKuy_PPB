import 'package:flutter/material.dart';
import '../../database/db_helper.dart';

class BuatCV extends StatefulWidget {
  final int userId;
  const BuatCV({super.key, required this.userId});

  @override
  State<BuatCV> createState() => _BuatCVState();
}

class _BuatCVState extends State<BuatCV> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController tentangController = TextEditingController();
  final TextEditingController universitasController = TextEditingController();
  final TextEditingController jurusanController = TextEditingController();

  final List<TextEditingController> skillController =
      List.generate(3, (_) => TextEditingController());
  final List<TextEditingController> skillLevelController =
      List.generate(3, (_) => TextEditingController());

  final List<TextEditingController> pengalamanController =
      List.generate(3, (_) => TextEditingController());
  final List<TextEditingController> durasiController =
      List.generate(3, (_) => TextEditingController());

  // kontak
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();

  // validasi
  bool validasiForm() {
    if (titleController.text.isEmpty ||
        subtitleController.text.isEmpty ||
        tentangController.text.isEmpty ||
        universitasController.text.isEmpty ||
        jurusanController.text.isEmpty ||
        emailController.text.isEmpty ||
        telpController.text.isEmpty ||
        linkedinController.text.isEmpty) {
      return false;
    }

    // minimal 1 skill dan 1 pengalaman
    if (skillController.every((c) => c.text.isEmpty)) return false;
    if (pengalamanController.every((c) => c.text.isEmpty)) return false;

    return true;
  }

  // alert
  void showAlert(String pesan) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Peringatan"),
        content: Text(pesan),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  // dialog sukses
  void suksesDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          titlePadding: EdgeInsets.only(top: 25),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          title: Column(
            children: [
              Icon(Icons.check_circle_rounded,
                  size: 60, color: Color(0xFF28AE9D)),
              SizedBox(height: 10),
              Text("CV Berhasil Dibuat!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "CV kamu siap digunakan untuk melamar pekerjaan.",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF28AE9D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    "Kembali",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // reset 
  void resetAll() {
    titleController.clear();
    subtitleController.clear();
    tentangController.clear();
    universitasController.clear();
    jurusanController.clear();
    emailController.clear();
    telpController.clear();
    linkedinController.clear();

    for (var c in skillController) c.clear();
    for (var c in skillLevelController) c.clear();
    for (var c in pengalamanController) c.clear();
    for (var c in durasiController) c.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, size: 28),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // form utama
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF28AE9D), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      inputField("Title", titleController),
                      inputField("Subtitle", subtitleController),
                      inputFieldBig("Tentang Saya", tentangController),

                      SizedBox(height: 15),
                      Text("Pendidikan",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      inputField("Universitas", universitasController),
                      inputField("Jurusan", jurusanController),

                      SizedBox(height: 15),
                      Text("Skill (maksimal 3)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      for (int i = 0; i < 3; i++) skillRow(i),

                      SizedBox(height: 15),
                      Text("Pengalaman (maksimal 3)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      for (int i = 0; i < 3; i++) pengalamanRow(i),

                      SizedBox(height: 15),
                      Text("Kontak",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      inputField("Email", emailController),
                      inputField("No. Telepon", telpController),
                      inputField("LinkedIn", linkedinController),

                      SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (!validasiForm()) {
                              showAlert(
                                  "Lengkapi semua field dan minimal 1 skill & pengalaman.");
                              return;
                            }

                            // insert ke table cv
                            int cvId = await DBHelper.insertCV(
                              userId: widget.userId,
                              pendidikan: "N/A",
                              umur: 0,
                              tentangSaya: tentangController.text,
                              universitas: universitasController.text,
                              jurusan: jurusanController.text,
                              kontak: emailController.text,
                              title: titleController.text,
                              subtitle: subtitleController.text,
                            );

                            // insert skill
                            for (int i = 0; i < 3; i++) {
                              if (skillController[i].text.isNotEmpty) {
                                await DBHelper.insertSkillCV(
                                  cvId: cvId,
                                  skill: skillController[i].text,
                                  kemampuan: int.tryParse(
                                          skillLevelController[i].text) ??
                                      0,
                                );
                              }
                            }

                            // insert pengalaman
                            for (int i = 0; i < 3; i++) {
                              if (pengalamanController[i].text.isNotEmpty) {
                                await DBHelper.insertPengalaman(
                                  cvId: cvId,
                                  pengalaman: pengalamanController[i].text,
                                  durasi: durasiController[i].text,
                                );
                              }
                            }

                            // insert kontak lengkap
                            await DBHelper.insertKontak(
                              cvId: cvId,
                              email: emailController.text,
                              noTelepon: telpController.text,
                              linkedIn: linkedinController.text,
                            );

                            resetAll();
                            suksesDialog();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF28AE9D),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          child: Text("Simpan CV",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // component input text normal
  Widget inputField(String title, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 6),
          inputBox(
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                hintText: "Masukkan $title",
              ),
            ),
          )
        ],
      ),
    );
  }

  // component input text besar
  Widget inputFieldBig(String title, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 6),
          inputBox(
            TextField(
              controller: controller,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                hintText: "Tulis $title...",
              ),
            ),
            height: 120,
          )
        ],
      ),
    );
  }

  // component row skill
  Widget skillRow(int i) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: inputBox(
              TextField(
                controller: skillController[i],
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Skill ${i + 1}"),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: inputBox(
              TextField(
                controller: skillLevelController[i],
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: "1–10"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // component row pengalaman
  Widget pengalamanRow(int i) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: inputBox(
              TextField(
                controller: pengalamanController[i],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Pengalaman ${i + 1}"),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: inputBox(
              TextField(
                controller: durasiController[i],
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: "Durasi"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // component box input
  Widget inputBox(Widget child, {double height = 45}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 2))
        ],
      ),
      child: child,
    );
  }
}
