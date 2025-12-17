import 'package:flutter/material.dart';

// WIDGET UNTUK PAGE 3
class LamaranCard extends StatelessWidget {
  final String companyName;
  final String status; // Process | Diterima | Ditolak
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
    String message;

    switch (status) {
      case "Process":
        statusColor = Colors.amber;
        message = "Lamaran anda sedang diproses";
        break;

      case "Diterima":
        statusColor = Colors.green;
        message = "Selamat! Lamaran anda diterima";
        break;

      case "Ditolak":
        statusColor = Colors.red;
        message = "Mohon maaf, lamaran anda belum diterima";
        break;

      default:
        statusColor = Colors.grey;
        message = "Status lamaran tidak diketahui";
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
            // STRIP STATUS
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
                  // ICON
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.business,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 10),

                  // TEXT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: const TextStyle(fontSize: 13),
                      ),
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
