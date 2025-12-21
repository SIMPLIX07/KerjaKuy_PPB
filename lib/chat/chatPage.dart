import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat/chatRoomPage.dart';
import 'package:flutter_application_1/database/db_helper.dart';

class ChatListPage extends StatefulWidget {
  final int userId;
  const ChatListPage({super.key, required this.userId});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<Map<String, dynamic>> chats = [];

  @override
  void initState() {
    super.initState();
    _loadChat();
  }

  Future<void> _loadChat() async {
    final data = await DBHelper.getChatListByUser(widget.userId);
    setState(() => chats = data);
  }

  /// SIMULASI: perusahaan menerima pelamar
  Future<void> _simulateAccept() async {
    // contoh perusahaan id
    const perusahaanId = 1;

    await DBHelper.createOrGetChatRoom(
      userId: widget.userId,
      perusahaanId: perusahaanId,
    );

    _loadChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF28AE9D),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Pesan", style: TextStyle(color: Colors.white)),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _simulateAccept,
        backgroundColor: const Color(0xFF28AE9D),
        child: const Icon(Icons.add),
      ),

      body: chats.isEmpty
          ? const Center(child: Text("Belum ada pesan"))
          : ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, i) {
                final chat = chats[i];

                return ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage:
                        chat['photo_profile'] != null &&
                            chat['photo_profile'].toString().isNotEmpty &&
                            File(chat['photo_profile']).existsSync()
                        ? FileImage(File(chat['photo_profile']))
                        : null,
                    child:
                        (chat['photo_profile'] == null ||
                            chat['photo_profile'].toString().isEmpty)
                        ? const Icon(Icons.business, color: Colors.white)
                        : null,
                  ),

                  title: Text(chat['namaPerusahaan']),
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
                          userId: widget.userId,
                          perusahaanId: chat['perusahaan_id'],
                          namaPerusahaan: chat['namaPerusahaan'],
                          isUser: true,
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
