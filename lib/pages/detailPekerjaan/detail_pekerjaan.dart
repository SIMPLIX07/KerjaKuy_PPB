import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/db_helper.dart';

class DetailPekerjaan extends StatefulWidget {
  final int idLowongan;

  const DetailPekerjaan({super.key, required this.idLowongan});

  @override
  State<DetailPekerjaan> createState() => _DetailPekerjaanState();
}

class _DetailPekerjaanState extends State<DetailPekerjaan> {
  Map<String, dynamic>? lowongan;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadLowongan();
  }

  Future<void> loadLowongan() async {
    final row = await DBHelper.findLowonganById(widget.idLowongan);

    if (row != null) {
      setState(() {
        lowongan = Map<String, dynamic>.from(row);

        if (lowongan!['syarat'] != null &&
            lowongan!['syarat'].toString().isNotEmpty) {
          lowongan!['syarat'] = List<String>.from(
            jsonDecode(lowongan!['syarat']),
          );
        } else {
          lowongan!['syarat'] = [];
        }

        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                offset: Offset(2, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(12), 
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 12,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  shadowColor: Colors.black.withOpacity(0.5),
                  backgroundColor: Colors.white,
                  elevation: 4,
                ),
                child: Icon(
                  Icons.bookmark_border,
                  color: Colors.black,
                  size: 16,
                ),
              ),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  backgroundColor: const Color.fromARGB(255, 59, 208, 200),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  spacing: 6,
                  children: [
                    Text(
                      "Lamar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Icon(Icons.send, color: Colors.white, size: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 140,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/header_bg.jpg"),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: ListTile(
          title: Text(
            lowongan!['nama_perusahaan'] ?? '',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            lowongan!['posisi'] ?? '',
            style: TextStyle(color: Colors.white70),
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.business, color: Colors.black),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    lowongan!['gaji'] ?? '-',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 8),

              Row(
                children: [
                  Text(
                    lowongan!['tipe'] ?? '-',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 8),

              Row(
                children: [
                  Text(
                    lowongan!['lokasi'] ?? '-',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),

              SizedBox(height: 16),

              Text(
                "Deskripsi Pekerjaan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.start,
              ),

              SizedBox(height: 8),

              Text(lowongan!['deskripsi'] ?? '-'),

              SizedBox(height: 16),

              Text(
                "Syarat",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.start,
              ),

              SizedBox(height: 12),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: (lowongan!['syarat'] as List).length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• "),
                        Expanded(child: Text(lowongan!['syarat'][index])),
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
