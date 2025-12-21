import 'package:flutter/material.dart';
import '../../database/db_helper.dart';

class ChatRoomPage extends StatefulWidget {
  final int roomId;
  final int userId;
  final int perusahaanId;
  final String namaPerusahaan;
  final bool isUser;

  const ChatRoomPage({
    super.key,
    required this.roomId,
    required this.userId,
    required this.perusahaanId,
    required this.namaPerusahaan,
    required this.isUser,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final db = await DBHelper.getDBPublic();
    final result = await db.query(
      'chat_message',
      where: 'room_id = ?',
      whereArgs: [widget.roomId],
      orderBy: 'created_at ASC',
    );

    setState(() {
      messages = result;
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    await DBHelper.insertChatMessage(
      roomId: widget.roomId,
      senderType: widget.isUser ? 'user' : 'perusahaan',
      message: text,
    );

    _messageController.clear();
    _loadMessages();
  }

  Widget _chatBubble(Map<String, dynamic> msg) {
    final senderType = msg['sender_type'];

    final isMe =
        (senderType == 'user' && widget.isUser) ||
        (senderType == 'perusahaan' && !widget.isUser);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF28AE9D) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          msg['message'],
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// HEADER
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.namaPerusahaan,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      /// BODY
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _chatBubble(messages[index]);
              },
            ),
          ),

          /// INPUT BAR
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Tulis pesan...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Color(0xFF28AE9D),
                    size: 28,
                  ),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
