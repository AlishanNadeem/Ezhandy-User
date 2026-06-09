class ChatModel {
  final String text;
  final bool isSender;
  final DateTime time;
  final String? senderName;

  ChatModel({
    required this.text,
    required this.isSender,
    required this.time,
    this.senderName,
  });
}