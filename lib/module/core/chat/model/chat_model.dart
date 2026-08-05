class ChatModel {
  final String text;
  final bool isSender;
  final DateTime time;
  final String messageType;
  final String? senderName;
  final String? senderImage;
  final String? filePath;

  ChatModel({
    required this.text,
    required this.isSender,
    required this.time,
    this.messageType = 'text',
    this.senderName,
    this.senderImage,
    this.filePath,
  });
}