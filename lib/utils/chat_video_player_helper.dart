import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/services/live_chat_socket_service.dart';
import 'package:ezhandy_user/utils/media_url_helper.dart';
import 'package:ezhandy_user/utils/shared_preference.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class ChatVideoPlayerHelper {
  static Map<String, String> authHeaders() {
    final token = SharedPreference().getBearerToken() ??
        AuthController.i.appUser.value.data?.accessToken;
    return {
      'Accept': '*/*',
      if (token != null && token.trim().isNotEmpty)
        'Authorization': 'Bearer ${token.trim()}',
    };
  }

  static Future<VideoPlayerController> createController({
    required String sourcePath,
    required bool isLocal,
  }) async {
    if (isLocal) {
      final controller = VideoPlayerController.file(File(sourcePath));
      await controller.initialize();
      return controller;
    }

    final headers = authHeaders();
    final candidates = resolveChatMediaUrlCandidates(sourcePath);
    Object? lastError;

    for (final url in candidates) {
      try {
        LiveChatSocketService.log('video play try stream url=$url');
        final controller = VideoPlayerController.networkUrl(
          Uri.parse(url),
          httpHeaders: headers,
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );
        await controller.initialize();
        return controller;
      } catch (e) {
        lastError = e;
        LiveChatSocketService.log('video stream failed url=$url error=$e');
      }
    }

    for (final url in candidates) {
      try {
        LiveChatSocketService.log('video play try download url=$url');
        final file = await _downloadToCache(url, headers);
        final controller = VideoPlayerController.file(file);
        await controller.initialize();
        return controller;
      } catch (e) {
        lastError = e;
        LiveChatSocketService.log('video download failed url=$url error=$e');
      }
    }

    throw lastError ?? Exception('Unable to play video');
  }

  static Future<File> _downloadToCache(
    String url,
    Map<String, String> headers,
  ) async {
    final dir = await getTemporaryDirectory();
    final uri = Uri.parse(url);
    final segment = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
    final safeName = segment.isNotEmpty ? segment : 'chat_video.mp4';
    final file = File('${dir.path}/chat_$safeName');

    await Dio().download(
      url,
      file.path,
      options: Options(
        headers: headers,
        followRedirects: true,
        validateStatus: (status) => status != null && status < 500,
        responseType: ResponseType.bytes,
      ),
    );

    if (!await file.exists() || await file.length() == 0) {
      throw Exception('Downloaded video file is empty');
    }

    return file;
  }
}
