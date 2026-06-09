class MyChatUser {
  final String id;
  final String fullName;
  final String? profileImage;
  final String? phoneNumber;
  final bool isOnline;

  MyChatUser({
    required this.id,
    required this.fullName,
    this.profileImage,
    this.phoneNumber,
    this.isOnline = false,
  });

  factory MyChatUser.fromJson(Map<String, dynamic> json) {
    return MyChatUser(
      id: json['id']?.toString() ?? '',
      fullName: _nonEmpty(json['fullName']) ?? _nonEmpty(json['name']) ?? '',
      profileImage: _nonEmpty(json['profileImage']),
      phoneNumber: _nonEmpty(json['phoneNumber']),
      isOnline: json['isOnline'] == true,
    );
  }

  static String? _nonEmpty(dynamic value) {
    final s = value?.toString().trim() ?? '';
    return s.isEmpty ? null : s;
  }
}

class MyChatLastMessage {
  final String content;
  final DateTime? createdAt;

  MyChatLastMessage({
    required this.content,
    this.createdAt,
  });

  factory MyChatLastMessage.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return MyChatLastMessage(content: '');
    }
    return MyChatLastMessage(
      content: json['content']?.toString() ?? '',
      createdAt: MyChatItem.parseDateTime(json['createdAt']),
    );
  }
}

class MyChatItem {
  final String chatId;
  final String chatType;
  final int unreadCount;
  final MyChatUser otherUser;
  final MyChatLastMessage? lastMessage;
  final DateTime? lastMessageTime;

  MyChatItem({
    required this.chatId,
    required this.chatType,
    required this.unreadCount,
    required this.otherUser,
    this.lastMessage,
    this.lastMessageTime,
  });

  factory MyChatItem.fromJson(Map<String, dynamic> json) {
    final otherRaw = json['otherUser'];
    final otherMap = otherRaw is Map
        ? Map<String, dynamic>.from(otherRaw)
        : <String, dynamic>{};

    final lastRaw = json['lastMessage'];
    final lastMap = lastRaw is Map
        ? Map<String, dynamic>.from(lastRaw)
        : null;

    return MyChatItem(
      chatId: json['chatId']?.toString() ?? '',
      chatType: json['chatType']?.toString() ?? '',
      unreadCount: _int(json['unreadCount']),
      otherUser: MyChatUser.fromJson(otherMap),
      lastMessage: lastMap != null ? MyChatLastMessage.fromJson(lastMap) : null,
      lastMessageTime: parseDateTime(json['lastMessageTime']) ??
          (lastMap != null ? parseDateTime(lastMap['createdAt']) : null),
    );
  }

  String get displayName =>
      otherUser.fullName.isNotEmpty ? otherUser.fullName : 'Unknown';

  String get lastMessagePreview => lastMessage?.content ?? '';

  DateTime? get displayTime => lastMessageTime ?? lastMessage?.createdAt;

  static int _int(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static DateTime? parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is Map) {
      if (value.isEmpty) return null;
      for (final key in ['date', 'iso', 'value', '\$date']) {
        final nested = parseDateTime(value[key]);
        if (nested != null) return nested;
      }
      return null;
    }
    final s = value.toString().trim();
    if (s.isEmpty || s == '{}') return null;
    return DateTime.tryParse(s);
  }
}
