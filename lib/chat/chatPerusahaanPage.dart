import 'dart:io';
import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'chatRoomPage.dart';

class ChatListPerusahaanPage extends StatefulWidget {
  final int perusahaanId;

  const ChatListPerusahaanPage({super.key, required this.perusahaanId});

  @override
  State<ChatListPerusahaanPage> createState() => _ChatListPerusahaanPageState();
}

class _ChatListPerusahaanPageState extends State<ChatListPerusahaanPage> {
  List<Map<String, dynamic>> chats = [];

  @override
  void initState() {
    super.initState();
    _loadChat();
  }

  Future<void> _loadChat() async {
    final data = await DBHelper.getChatListByPerusahaan(widget.perusahaanId);
    setState(() => chats = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF28AE9D),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Pesan", style: TextStyle(color: Colors.white)),
      ),

      body: chats.isEmpty
          ? const Center(child: Text("Belum ada pesan"))
          : ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, i) {
                final chat = chats[i];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage:
                        chat['photo_path'] != null &&
                            chat['photo_path'].toString().isNotEmpty
                        ? FileImage(File(chat['photo_path']))
                        : null,
                    child: chat['photo_path'] == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  title: Text(chat['fullname']),
                  subtitle: Text(
                    chat['last_message'].isEmpty
                        ? "Mulai percakapan"
                        : chat['last_message'],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatRoomPage(
                          roomId: chat['room_id'],
                          perusahaanId: widget.perusahaanId,
                          userId: chat['user_id'],
                          namaPerusahaan: chat['fullname'],
                          isUser: false,
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
