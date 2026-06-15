class ChatModel {
  final String text;
  final bool isSender;
  final DateTime time;
  final String? senderName;
  final String? senderImage;

  ChatModel({
    required this.text,
    required this.isSender,
    required this.time,
    this.senderName,
    this.senderImage,
  });
}