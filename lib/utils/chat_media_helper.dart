import 'dart:io';

import 'package:ezhandy_user/utils/media_url_helper.dart';

enum ChatMessageMediaType { text, image, video }

class ResolvedChatMedia {
  final bool isLocal;
  final File? localFile;
  final String networkPath;

  const ResolvedChatMedia({
    this.isLocal = false,
    this.localFile,
    this.networkPath = '',
  });

  bool get hasMedia => isLocal || networkPath.isNotEmpty;
}

ChatMessageMediaType resolveChatMessageType({
  required String? messageType,
  String? filePath,
}) {
  final type = (messageType ?? 'text').trim().toLowerCase();
  if (type == 'image') return ChatMessageMediaType.image;
  if (type == 'video') return ChatMessageMediaType.video;

  final path = filePath?.trim() ?? '';
  if (path.isEmpty) return ChatMessageMediaType.text;
  return isVideoPath(path)
      ? ChatMessageMediaType.video
      : ChatMessageMediaType.image;
}

bool isVideoPath(String path) {
  final ext = path.split('.').last.toLowerCase();
  const videoExtensions = {
    'mp4',
    'mov',
    'avi',
    'mkv',
    'webm',
    'm4v',
    '3gp',
    '3gpp',
  };
  return videoExtensions.contains(ext);
}

ResolvedChatMedia resolveChatMedia(String? filePath) {
  final raw = filePath?.trim() ?? '';
  if (raw.isEmpty) {
    return const ResolvedChatMedia();
  }

  final isNetwork =
      raw.startsWith('http://') || raw.startsWith('https://');
  if (isNetwork) {
    return ResolvedChatMedia(networkPath: raw);
  }

  final localFile = File(raw);
  if (localFile.existsSync()) {
    return ResolvedChatMedia(isLocal: true, localFile: localFile);
  }

  final networkPath = resolveMediaUrl(raw);
  return ResolvedChatMedia(networkPath: networkPath);
}
