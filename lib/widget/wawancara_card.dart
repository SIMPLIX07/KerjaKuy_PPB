import 'package:flutter/material.dart';

//WIDGET UNTUK PAGE 4
class WawancaraCard extends StatelessWidget {
  final String date;
  final String time;
  final String company;
  final bool isCompleted;

  const WawancaraCard({
    super.key,
    required this.date,
    required this.time,
    required this.company,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;

    if (isCompleted) {
      statusColor = Colors.green;
    } else {
      statusColor = Colors.amber;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Garis indikator di sebelah kiri
          Container(
            width: 4,
            height: 100,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
          ),
          SizedBox(width: 12),
          // Konten utama
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Baris pertama: Tanggal dengan ikon
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "Tanggal: $date",
                        style: TextStyle(
                          fontSize: 14,
                          color: isCompleted ? Colors.grey : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  // Baris kedua: Jam dengan ikon
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "Jam: $time",
                        style: TextStyle(
                          fontSize: 14,
                          color: isCompleted ? Colors.grey : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Wawancara dengan $company",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? Colors.grey : Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}