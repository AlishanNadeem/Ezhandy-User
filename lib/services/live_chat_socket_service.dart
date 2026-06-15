import 'dart:math';

import 'dart:developer' as developer;

import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/shared_preference.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class LiveChatSocketService {
  LiveChatSocketService._();

  static final LiveChatSocketService instance = LiveChatSocketService._();

  io.Socket? _socket;
  bool _initialized = false;
  bool _userOnlineRegistered = false;
  final List<String> _pendingChatJoins = <String>[];

  bool get isConnected => _socket?.connected == true;

  String? get _currentUserId =>
      AuthController.i.appUser.value.data?.userModel?.sub?.trim();

  /// Logs to terminal, Android Logcat (`I/flutter`), and Android Studio Debug Console.
  static void log(String message) {
    final line = '[LiveChatSocket] $message';
    print(line);
    developer.log(message, name: 'LiveChatSocket');
  }

  Future<void> connect() async {
    if (isConnected) {
      log('already connected');
      _ensureUserOnline();
      return;
    }

    if (_initialized && _socket != null) {
      log('reconnecting existing socket');
      _socket!.connect();
      return;
    }

    await SharedPreference().sharedPreference;

    final token = SharedPreference().getBearerToken() ??
        AuthController.i.appUser.value.data?.accessToken;

    log('connecting to ${NetworkStrings.SOCKET_BASE_URL}');
    log('auth token present: ${token != null && token.isNotEmpty}');

    _socket = io.io(
      NetworkStrings.SOCKET_BASE_URL,
      io.OptionBuilder()
          .setAuth({'token': token ?? ''})
          .setTransports(['websocket', 'polling'])
          .disableAutoConnect()
          .build(),
    );

    _socket!.onConnect((_) => _onSocketConnect());
    _socket!.onDisconnect((data) {
      _userOnlineRegistered = false;
      log('disconnected: $data');
    });
    _socket!.onConnectError((data) => log('connect error: $data'));
    _socket!.onError((data) => log('error: $data'));
    _socket!.onAny((event, data) => log('event [$event]: $data'));

    _socket!.connect();
    _initialized = true;
    log('connect() called');
  }

  void _onSocketConnect() {
    log('connected');
    _userOnlineRegistered = false;
    _emitUserOnline();
  }

  void _ensureUserOnline() {
    if (!_userOnlineRegistered) {
      _emitUserOnline();
    }
  }

  void _emitUserOnline() {
    final userId = _currentUserId;
    if (userId == null || userId.isEmpty) {
      log('userOnline skipped: no userId');
      return;
    }

    log('emit userOnline userId=$userId connected=$isConnected');
    _socket?.emit('userOnline', {'userId': userId});
    _userOnlineRegistered = true;
    _flushPendingChatJoins();
  }

  void _flushPendingChatJoins() {
    if (!_userOnlineRegistered || !isConnected || _pendingChatJoins.isEmpty) {
      return;
    }

    final pending = List<String>.from(_pendingChatJoins);
    _pendingChatJoins.clear();
    for (final chatId in pending) {
      joinChat(chatId);
    }
  }

  void joinChat(String chatId) {
    final id = chatId.trim();
    if (id.isEmpty) return;

    if (!_userOnlineRegistered) {
      if (!_pendingChatJoins.contains(id)) {
        _pendingChatJoins.add(id);
        log('queued joinChat chatId=$id until userOnline');
      }
      _ensureUserOnline();
      return;
    }

    log('emit joinChat chatId=$id connected=$isConnected');
    _socket?.emit('joinChat', {'chatId': id});
  }

  void sendMessage({
    required String senderId,
    required String receiverId,
    required String chatId,
    required String content,
    String messageType = 'text',
  }) {
    final payload = {
      'senderId': senderId,
      'receiverId': receiverId,
      'chatId': chatId,
      'clientMsgId': _generateClientMsgId(),
      'content': content,
      'messageType': messageType,
    };
    log('emit sendMessage: $payload');
    _socket?.emit('sendMessage', payload);
  }

  void emitTyping({required String chatId, required bool isTyping}) {
    final id = chatId.trim();
    if (id.isEmpty) return;

    final payload = {'chatId': id, 'isTyping': isTyping};
    log('emit typing: $payload');
    _socket?.emit('typing', payload);
  }

  String _generateClientMsgId() {
    return 'temp-${DateTime.now().millisecondsSinceEpoch}-${Random().nextDouble()}';
  }

  void joinChatWhenConnected(String chatId) {
    final id = chatId.trim();
    if (id.isEmpty) return;

    if (isConnected) {
      joinChat(id);
      return;
    }

    log('waiting for connect before joinChat chatId=$id');
    _socket?.once('connect', (_) => joinChat(id));
  }

  void on(String event, void Function(dynamic data) handler) {
    log('listener registered for $event');
    _socket?.on(event, handler);
  }

  void off(String event, [void Function(dynamic data)? handler]) {
    if (handler != null) {
      _socket?.off(event, handler);
    } else {
      _socket?.off(event);
    }
  }
}
