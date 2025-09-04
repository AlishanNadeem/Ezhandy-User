class ChatModel {
  final String text;
  final bool isSender;
  final DateTime time;

  ChatModel({
    required this.text,
    required this.isSender,
    required this.time,
  });
}