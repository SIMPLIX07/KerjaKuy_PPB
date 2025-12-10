import 'package:flutter/material.dart';

class DetailPekerjaan extends StatelessWidget {
  DetailPekerjaan({super.key});

  final List<String> deskripsiPekerjaan = [
    "Melakukan analisis kebutuhan dan menyusun rencana kerja.",
    "Mengembangkan fitur aplikasi sesuai standar pengembangan.",
    "Melakukan testing manual dan otomatis terhadap fitur yang dibuat.",
    "Berkoordinasi dengan tim desain untuk implementasi UI/UX.",
    "Menyelesaikan bug dan meningkatkan performa aplikasi.",
    "Mendokumentasikan alur kerja dan perubahan pada aplikasi.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 140,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/header_bg.jpg"),
              fit: BoxFit.cover,
              alignment: Alignment.center
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: ListTile(
          title: Text("Icons +", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20)),
          subtitle: Text(
            "UI UX Designer",
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ),

      body: Expanded(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [Text('Rp. 29.000.000')]),
              SizedBox(height: 8),
              Row(children: [Text('Penuh Waktu')]),
              SizedBox(height: 8),
              Row(children: [Text('Jakarta Pusat, Jakarta Raya')]),

              SizedBox(height: 16),

              Text("Deskripsi Pekerjaan", textAlign: TextAlign.start),

              SizedBox(height: 12),

              ListView.builder(
                shrinkWrap: true, // penting agar tidak overflow
                physics:
                    NeverScrollableScrollPhysics(), // biar scroll ikut parent
                itemCount: deskripsiPekerjaan.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• "), // bullet
                        Expanded(child: Text(deskripsiPekerjaan[index])),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
