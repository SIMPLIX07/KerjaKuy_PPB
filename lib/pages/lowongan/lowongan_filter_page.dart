import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../widget/lowongan_card.dart';
import 'package:flutter_application_1/pages/detailLowongan/detail_lowongan.dart';
import 'package:flutter_application_1/detailPerusahaan/detailPerusahaan.dart';

import 'package:flutter_application_1/database/db_helper.dart';

class LowonganFilterPage extends StatefulWidget {
  final int userId;
  final String keyword;

  const LowonganFilterPage({
    super.key,
    required this.userId,
    required this.keyword,
  });

  @override
  State<LowonganFilterPage> createState() => _LowonganFilterPageState();
}

class _LowonganFilterPageState extends State<LowonganFilterPage> {
  List<Map<String, dynamic>> hasil = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _search();
  }

  Future<void> _search() async {
    final data = await DBHelper.searchLowongan(widget.keyword);
    setState(() {
      hasil = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hasil pencarian: \"${widget.keyword}\""),
        backgroundColor: const Color(0xFF28AE9D),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : hasil.isEmpty
          ? Center(
              child: Text(
                "Maaf, lowongan yang Anda cari tidak ditemukan",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: hasil.length,
              itemBuilder: (context, index) {
                final pk = hasil[index];

                return LowonganCard(
                  data: pk,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPerusahaanPage(
                          perusahaanId: pk['perusahaan_id'],
                        ),
                      ),
                    );
                  },
                  onLamar: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailLowonganPage(
                          userId: widget.userId,
                          perusahaanId: pk['perusahaan_id'],
                          posisi: pk['posisi'],
                          namaPerusahaan: pk['nama_perusahaan'],
                          gaji: pk['gaji'],
                          tipe: pk['tipe'],
                          lokasi: pk['lokasi'],
                          deskripsi: pk['deskripsi'],
                          syarat: pk['syarat'],
                          lowonganId: pk['id'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
