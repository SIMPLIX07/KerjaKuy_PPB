import 'package:flutter/material.dart';
import '../../database/db_helper.dart';

class Buatlowongan extends StatefulWidget {
  final int perusahaanId;
  final String namaPerusahaan;
  const Buatlowongan({
    super.key,
    required this.perusahaanId,
    required this.namaPerusahaan,
  });

  @override
  State<Buatlowongan> createState() => _BuatlowonganState();
}

class _BuatlowonganState extends State<Buatlowongan> {
  final TextEditingController periodeAwalController = TextEditingController();
  final TextEditingController periodeAkhirController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController posisiController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController syaratController = TextEditingController();
  final TextEditingController gajiController = TextEditingController();
  final TextEditingController tipeController = TextEditingController();
  String? gajiDipilih;
  String? tipeDipilih;

  List<String> listGaji = [
    "1 - 3 juta",
    "3 - 5 juta",
    "5 - 8 juta",
    "> 8 juta",
  ];

  List<String> tipeKerja = ["Penuh Waktu", "Paruh Waktu"];

  Future<void> pilihTanggal(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String isoDate =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      controller.text = isoDate;
    }
  }

  bool validasiForm() {
    if (kategoriController.text.isEmpty ||
        posisiController.text.isEmpty ||
        deskripsiController.text.isEmpty ||
        syaratController.text.isEmpty ||
        gajiDipilih == null ||
        tipeDipilih == null ||
        periodeAwalController.text.isEmpty ||
        periodeAkhirController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void showAlert(String pesan) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Peringatan"),
          content: Text(pesan),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void berhasilInsert() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          titlePadding: EdgeInsets.only(top: 25),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          title: Column(
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF28AE9D),
                size: 60,
              ),
              SizedBox(height: 12),
              Text(
                "Lowongan Berhasil Dibuat!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Lowongan kamu sudah tayang dan siap dilamar oleh kandidat. "
                "Pantau pelamar yang masuk di halaman beranda ya!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
              SizedBox(height: 22),

              
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Kembali ke Beranda",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        );
      },
    );
  }

  void resetController() {
    periodeAwalController.text = "";
    periodeAkhirController.text = "";
    kategoriController.text = "";
    posisiController.text = "";
    deskripsiController.text = "";
    syaratController.text = "";
    gajiController.text = "";
    tipeController.text = "";
    gajiDipilih = null;
    tipeDipilih = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Tombol Back
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, size: 30, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            Center(
              child: Container(
                height: 800,
                width: 500,
                padding: const EdgeInsets.only(top: 35, left: 35, right: 35),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF28AE9D), width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kategori",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 420,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: kategoriController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Programming, Bisnis, Teknik",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 80,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Posisi",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 420,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: posisiController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Data Analyst, Manager, CMO",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 170,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deskripsi",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 420,
                              height: 130,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: deskripsiController,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  border: InputBorder.none,
                                  hintText:
                                      "Deskripsi mengenai pekerjaan yang akan anda buka",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 170,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Syarat",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 420,
                              height: 130,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: syaratController,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  border: InputBorder.none,
                                  hintText:
                                      "Jika syarat lebih dari 1 maka buat line baru untuk setiap syarat",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 80,
                                width: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Gaji",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 170,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 6,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        value: gajiDipilih,
                                        onChanged: (value) {
                                          setState(() {
                                            gajiDipilih = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        hint: Text("Pilih Rentang Gaji"),
                                        items: listGaji.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 70,
                                width: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Periode Awal",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 170,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 6,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        controller: periodeAwalController,
                                        readOnly: true,
                                        onTap: () {
                                          pilihTanggal(periodeAwalController);
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                          border: InputBorder.none,
                                          hintText: "DD/MM/YYYY",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Container(
                                height: 80,
                                width: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tipe",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 150,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 6,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        value: tipeDipilih,
                                        onChanged: (value) {
                                          setState(() {
                                            tipeDipilih = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        hint: Text("Pilih Tipe kerja"),
                                        items: tipeKerja.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 70,
                                width: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Periode Akhir",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 150,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 6,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        controller: periodeAkhirController,
                                        readOnly: true,
                                        onTap: () {
                                          pilihTanggal(periodeAkhirController);
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                          border: InputBorder.none,
                                          hintText: "DD/MM/YYYY",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30),

                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (!validasiForm()) {
                              showAlert(
                                "Semua field wajib diisi sebelum melanjutkan.",
                              );
                              return;
                            }

                            int id = await DBHelper.insertLowongan(
                              nama_perusahaan: widget.namaPerusahaan,
                              perusahaanId: widget.perusahaanId,
                              kategori: kategoriController.text,
                              posisi: posisiController.text,
                              deskripsi: deskripsiController.text,
                              syarat: syaratController.text,
                              gaji: gajiDipilih!,
                              tipe: tipeDipilih!,
                              periodeAwal: periodeAwalController.text,
                              periodeAkhir: periodeAkhirController.text,
                            );

                            print("=== DATA LOWONGAN ===");
                            print(
                              "Nama Perusahaan       : ${widget.namaPerusahaan}",
                            );
                            print(
                              "Id Perusahaan       : ${widget.perusahaanId}",
                            );
                            print(
                              "Kategori       : ${kategoriController.text}",
                            );
                            print("Posisi         : ${posisiController.text}");
                            print(
                              "Deskripsi      : ${deskripsiController.text}",
                            );
                            print("Syarat         : ${syaratController.text}");
                            print("Gaji           : ${gajiDipilih}");
                            print("Tipe           : ${tipeDipilih}");
                            print(
                              "Periode Awal   : ${periodeAwalController.text}",
                            );
                            print(
                              "Periode Akhir  : ${periodeAkhirController.text}",
                            );
                            print("=====================");
                            resetController();
                            berhasilInsert();
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF28AE9D),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Selesai",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
