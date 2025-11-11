import 'package:flutter/material.dart';

//WIDGET UNTUK PAGE 3
class LamaranCard extends StatelessWidget {
  final String companyName;
  final String status;
  final VoidCallback? onTap;

  const LamaranCard({
    super.key,
    required this.companyName,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (status == 'Diproses') {
      statusColor = Colors.amber;
    } else if (status == 'Diterima') {
      statusColor = Colors.green;
    } else {
      statusColor = Colors.red;
    }

    // teks sesuai status(PAGE 3)
    String message;
    if (status == 'Diproses') {
      message = "Lamaran anda sedang diproses";
    } else if (status == 'Diterima') {
      message = "Selamat! Lamaran anda diterima";
    } else {
      message = "Mohon maaf, lamaran anda belum diterima";
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
            Container(
              width: 4,
              height: 70,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.business, color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(message, style: const TextStyle(fontSize: 13)),
                      Text(
                        "oleh $companyName",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
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