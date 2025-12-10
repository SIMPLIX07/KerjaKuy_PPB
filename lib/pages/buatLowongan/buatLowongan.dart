// ===================  VERSION RESPONSIVE ===================

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
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController periodeAwalController = TextEditingController();
  final TextEditingController periodeAkhirController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController posisiController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController syaratController = TextEditingController();
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
      controller.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  bool validasiForm() {
    return kategoriController.text.isNotEmpty &&
        posisiController.text.isNotEmpty &&
        lokasiController.text.isNotEmpty && 
        deskripsiController.text.isNotEmpty &&
        syaratController.text.isNotEmpty &&
        periodeAwalController.text.isNotEmpty &&
        periodeAkhirController.text.isNotEmpty &&
        gajiDipilih != null &&
        tipeDipilih != null;
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
                "Lowongan kamu sudah tayang dan siap dilamar oleh kandidat.",
                textAlign: TextAlign.center,
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
                  ),
                  child: Text(
                    "Kembali ke Beranda",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void resetController() {
    kategoriController.clear();
    posisiController.clear();
    deskripsiController.clear();
    syaratController.clear();
    periodeAwalController.clear();
    periodeAkhirController.clear();
    gajiDipilih = null;
    tipeDipilih = null;
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, size: 30, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF28AE9D), width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ================================ INPUT FIELD ================================
                      fieldText(
                        "Kategori",
                        kategoriController,
                        "Programming, Bisnis, Teknik",
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: fieldText(
                              "Posisi",
                              posisiController,
                              "Data Analyst, Manager, CMO",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: fieldText(
                              "Lokasi",
                              lokasiController,
                              "Jakarta, Bandung, Remote",
                            ),
                          ),
                        ],
                      ),

                      fieldTextBig(
                        "Deskripsi",
                        deskripsiController,
                        "Deskripsi pekerjaan",
                      ),
                      fieldTextBig(
                        "Syarat",
                        syaratController,
                        "Gunakan enter untuk setiap syarat",
                      ),

                      SizedBox(height: 10),

                      // ================================ ROW Gaji & Periode ================================
                      Row(
                        children: [
                          Expanded(
                            child: columnDropdown(
                              title: "Gaji",
                              value: gajiDipilih,
                              list: listGaji,
                              onChanged: (v) => setState(() => gajiDipilih = v),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: columnCalendar(
                              title: "Periode Awal",
                              controller: periodeAwalController,
                              onTap: () => pilihTanggal(periodeAwalController),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: columnDropdown(
                              title: "Tipe",
                              value: tipeDipilih,
                              list: tipeKerja,
                              onChanged: (v) => setState(() => tipeDipilih = v),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: columnCalendar(
                              title: "Periode Akhir",
                              controller: periodeAkhirController,
                              onTap: () => pilihTanggal(periodeAkhirController),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 35),

                      // ================================ BUTTON SUBMIT ================================
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (!validasiForm()) {
                              showAlert(
                                "Semua field wajib diisi sebelum melanjutkan.",
                              );
                              return;
                            }

                            await DBHelper.insertLowongan(
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
                              lokasi: lokasiController.text,

                            );

                            resetController();
                            berhasilInsert();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF28AE9D),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
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

  // ==================== COMPONENTS ====================

  Widget fieldText(
    String title,
    TextEditingController controller,
    String hint,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          inputBox(
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fieldTextBig(
    String title,
    TextEditingController controller,
    String hint,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          inputBox(
            TextField(
              controller: controller,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
            height: 120,
          ),
        ],
      ),
    );
  }

  Widget columnDropdown({
    required String title,
    required String? value,
    required List<String> list,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        inputBox(
          DropdownButtonFormField<String>(
            value: value,
            onChanged: onChanged,
            decoration: InputDecoration(border: InputBorder.none),
            hint: Text("Pilih"),
            items: list
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget columnCalendar({
    required String title,
    required TextEditingController controller,
    required Function() onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        inputBox(
          TextField(
            controller: controller,
            readOnly: true,
            onTap: onTap,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "DD/MM/YYYY",
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
      ],
    );
  }

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
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
