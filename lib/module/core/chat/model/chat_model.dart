class ChatModel {
  final String text;
  final bool isSender;
  final DateTime time;
  final String? senderName;
  final String? senderImage;
  final String? filePath;

  ChatModel({
    required this.text,
    required this.isSender,
    required this.time,
    this.senderName,
    this.senderImage,
    this.filePath,
  });
}