import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import 'buatCV.dart';

class CVPage extends StatefulWidget {
  final int userId;

  const CVPage({super.key, required this.userId});

  @override
  State<CVPage> createState() => _CVPageState();
}

class _CVPageState extends State<CVPage> {
  List<Map<String, dynamic>> cvList = [];

  @override
  void initState() {
    super.initState();
    _loadCV();
  }

  Future<void> _loadCV() async {
    final data = await DBHelper.getCVByUserId(widget.userId);
    setState(() {
      cvList = data;
    });
  }

  Future<void> deleteCV(int cvId) async {
    await DBHelper.deleteCV(cvId);
    await _loadCV();
  }

  void _showMaxDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Maksimal CV",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Maaf, maksimal CV yang bisa kamu buat adalah 3.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _onAddCV() async {
    if (cvList.length >= 3) {
      _showMaxDialog();
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BuatCV(userId: widget.userId)),
    );

    _loadCV();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CV Anda"),
        backgroundColor: const Color(0xFF28AE9D),
        foregroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF28AE9D),
        onPressed: _onAddCV,
        child: const Icon(Icons.add, size: 30),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: cvList.isEmpty
            ? _emptyView()
            : ListView.builder(
                itemCount: cvList.length,
                itemBuilder: (context, index) {
                  final cv = cvList[index];
                  return _cvCard(
                    title: cv["title"] ?? "Tanpa Judul",
                    desc: cv["subtitle"] ?? "",
                    cvId: cv["id"] as int,
                    userId: cv["user_id"] as int,
                  );
                },
              ),
      ),
    );
  }

  Widget _emptyView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.description, size: 90, color: Colors.grey),
          SizedBox(height: 15),
          Text(
            "Belum ada CV",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Yuk buat CV-mu sekarang!",
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _cvCard({
    required String title,
    required String desc,
    required int cvId,
    required int userId,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF28AE9D), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          const Icon(Icons.description, size: 40, color: Color(0xFF28AE9D)),
          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),

          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BuatCV(userId: userId, cvId: cvId),
                ),
              );

              if (result == true) {
                _loadCV(); 
              }
            },
          ),

          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Hapus CV'),
                    content: const Text(
                      'Apakah Anda Yakin Ingin Menghapus CV Ini ?',
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Batal'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Hapus'),
                        onPressed: () async {
                          await deleteCV(cvId);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              ),
            },
          ),
        ],
      ),
    );
  }
}
