import 'package:flutter/material.dart';
import '../database/db_helper.dart';

//WIDGET UNTUK PAGE 4
class WawancaraCard extends StatelessWidget {
  final String date;
  final String time;
  final String namaUser;
  final bool isCompleted;
  final int userId;
  final int lowonganId;
  final int perusahaanId;

  const WawancaraCard({
    super.key,
    required this.date,
    required this.time,
    required this.namaUser,
    this.isCompleted = false,
    required this.userId,
    required this.lowonganId,
    required this.perusahaanId,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = isCompleted ? Colors.green : Colors.amber;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Garis indikator
          Container(
            width: 4,
            height: 100,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Konten utama
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text("Tanggal: $date"),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text("Jam: $time"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Wawancara dengan $namaUser",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 22,
                  ),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    print("DITERIMA: $namaUser");
                  },
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red, size: 22),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text("Konfirmasi"),
                          content: Text(
                            "Apakah anda yakin ingin menghapus pelamar $namaUser?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text("Batal"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () async {
                                await DBHelper.tolakPelamar(
                                  userId: userId,
                                  lowonganId: lowonganId,
                                  perusahaanId: perusahaanId,
                                );

                                Navigator.pop(ctx);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Pelamar berhasil ditolak"),
                                  ),
                                );
                              },
                              child: const Text("Ya, Tolak"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
