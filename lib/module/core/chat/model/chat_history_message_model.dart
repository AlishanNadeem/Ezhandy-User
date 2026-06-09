import 'package:ezhandy_user/module/core/chat/model/my_chat_model.dart';

class ChatHistoryMessage {
  final int id;
  final String content;
  final String messageType;
  final bool isRead;
  final String senderId;
  final String chatId;
  final String? senderName;
  final DateTime? createdAt;

  ChatHistoryMessage({
    required this.id,
    required this.content,
    required this.messageType,
    required this.isRead,
    required this.senderId,
    required this.chatId,
    this.senderName,
    this.createdAt,
  });

  factory ChatHistoryMessage.fromJson(Map<String, dynamic> json) {
    final sender = json['sender'];
    String? name;
    if (sender is Map) {
      name = sender['fullName']?.toString().trim();
      if (name != null && name.isEmpty) name = null;
    }

    return ChatHistoryMessage(
      id: _int(json['id']),
      content: json['content']?.toString() ?? '',
      messageType: json['messageType']?.toString() ?? 'text',
      isRead: json['isRead'] == true,
      senderId: json['senderId']?.toString() ?? '',
      chatId: json['chatId']?.toString() ?? '',
      senderName: name,
      createdAt: MyChatItem.parseDateTime(json['createdAt']),
    );
  }

  static int _int(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
