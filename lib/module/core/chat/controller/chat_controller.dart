import 'dart:async';

import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/chat/model/chat_history_message_model.dart';
import 'package:ezhandy_user/module/core/chat/model/chat_model.dart';
import 'package:ezhandy_user/services/live_chat_socket_service.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  ChatController({
    required this.chatId,
    this.otherUserId,
    this.otherUserName,
    this.otherUserImage,
  });

  final String chatId;
  final String? otherUserId;
  final String? otherUserName;
  final String? otherUserImage;

  final RxList<ChatModel> messages = <ChatModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isOtherUserTyping = false.obs;

  final Set<int> _messageIds = <int>{};
  void Function(dynamic)? _messageReceivedHandler;
  void Function(dynamic)? _userTypingHandler;
  String? _resolvedOtherUserId;
  Timer? _typingTimer;
  Timer? _otherUserTypingTimer;
  bool _isTypingEmitted = false;

  String? get currentUserId =>
      AuthController.i.appUser.value.data?.userModel?.sub?.trim();

  String? get receiverId {
    final fromArgs = otherUserId?.trim();
    if (fromArgs != null && fromArgs.isNotEmpty) return fromArgs;
    return _resolvedOtherUserId;
  }

  String get title =>
      otherUserName?.trim().isNotEmpty == true ? otherUserName!.trim() : 'Chat';

  @override
  void onInit() {
    super.onInit();
    if (chatId.trim().isNotEmpty) {
      markChatAsRead();
      fetchChatHistory();
      _initSocket();
    }
  }

  @override
  void onClose() {
    _stopTyping();
    _otherUserTypingTimer?.cancel();
    if (_messageReceivedHandler != null) {
      LiveChatSocketService.instance
          .off('messageReceived', _messageReceivedHandler);
    }
    if (_userTypingHandler != null) {
      LiveChatSocketService.instance.off('userTyping', _userTypingHandler);
    }
    super.onClose();
  }

  Future<void> _initSocket() async {
    try {
      await LiveChatSocketService.instance.connect();
      LiveChatSocketService.instance.joinChatWhenConnected(chatId.trim());
      _messageReceivedHandler = _onMessageReceived;
      LiveChatSocketService.instance
          .on('messageReceived', _messageReceivedHandler!);
      _userTypingHandler = _onUserTyping;
      LiveChatSocketService.instance.on('userTyping', _userTypingHandler!);
    } catch (e, st) {
      LiveChatSocketService.log('chat init failed: $e\n$st');
    }
  }

  void _onMessageReceived(dynamic data) {
    LiveChatSocketService.log('messageReceived (chat): $data');
    final payload = _parseMessagePayload(data);
    if (payload == null) return;

    final item = ChatHistoryMessage.fromJson(payload);
    if (item.chatId.trim() != chatId.trim()) return;

    final userId = currentUserId ?? '';
    if (userId.isNotEmpty && item.senderId == userId) return;

    if (item.id > 0 && _messageIds.contains(item.id)) return;

    if (item.id > 0) {
      _messageIds.add(item.id);
    }

    isOtherUserTyping.value = false;
    _otherUserTypingTimer?.cancel();

    messages.add(
      ChatModel(
        text: item.content,
        isSender: userId.isEmpty || item.senderId != userId,
        time: item.createdAt ?? DateTime.now(),
        senderName: item.senderName,
        senderImage: item.senderImage,
        filePath: item.filePath,
      ),
    );
    markChatAsRead();
  }

  Map<String, dynamic>? _parseMessagePayload(dynamic data) {
    if (data is! Map) return null;

    final nested = data['data'];
    if (nested is Map) {
      return Map<String, dynamic>.from(nested);
    }
    return Map<String, dynamic>.from(data);
  }

  void _onUserTyping(dynamic data) {
    LiveChatSocketService.log('userTyping (chat): $data');
    final payload = _parseMessagePayload(data);
    if (payload == null) return;

    final userId = payload['userId']?.toString().trim() ?? '';
    final isTyping = payload['isTyping'] == true;
    final current = currentUserId ?? '';

    if (userId.isEmpty || userId == current) return;

    final other = receiverId ?? '';
    if (other.isNotEmpty && userId != other) return;

    isOtherUserTyping.value = isTyping;
    _otherUserTypingTimer?.cancel();

    if (isTyping) {
      _otherUserTypingTimer = Timer(const Duration(seconds: 3), () {
        isOtherUserTyping.value = false;
      });
    }
  }

  Future<void> markChatAsRead() async {
    final id = chatId.trim();
    if (id.isEmpty) return;

    final response = await DioClient().patchRequest(
      endPoint: NetworkStrings.chatRead(id),
      isHeaderRequire: true,
      isLoader: false,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (_) {},
        onFailureCallback: (_) {},
      ),
    );
  }

  Future<void> fetchChatHistory() async {
    if (chatId.trim().isEmpty) return;

    isLoading.value = true;
    try {
      final response = await DioClient().getRequest(
        endPoint: NetworkStrings.chatHistory(chatId.trim()),
        isHeaderRequire: true,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (res) {
            final raw = res is Map ? res['data'] : null;
            if (raw is! List) {
              messages.clear();
              return;
            }

            final history = raw
                .whereType<Map>()
                .map(
                  (e) => ChatHistoryMessage.fromJson(
                    Map<String, dynamic>.from(e),
                  ),
                )
                .toList()
              ..sort((a, b) => a.id.compareTo(b.id));

            final userId = currentUserId ?? '';
            _resolveOtherUserId(history, userId);
            _messageIds
              ..clear()
              ..addAll(history.map((item) => item.id).where((id) => id > 0));
            messages.assignAll(
              history.map(
                (item) => ChatModel(
                  text: item.content,
                  isSender: userId.isEmpty || item.senderId != userId,
                  time: item.createdAt ?? DateTime.now(),
                  senderName: item.senderName,
                  senderImage: item.senderImage,
                  filePath: item.filePath,
                ),
              ),
            );
          },
          onFailureCallback: (_) => messages.clear(),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _resolveOtherUserId(List<ChatHistoryMessage> history, String userId) {
    if (receiverId != null) return;
    for (final item in history) {
      if (item.senderId.isNotEmpty && item.senderId != userId) {
        _resolvedOtherUserId = item.senderId;
        return;
      }
    }
  }

  void onTypingChanged(String text) {
    final id = chatId.trim();
    if (id.isEmpty) return;

    if (text.trim().isEmpty) {
      _stopTyping();
      return;
    }

    if (!_isTypingEmitted) {
      LiveChatSocketService.instance.emitTyping(chatId: id, isTyping: true);
      _isTypingEmitted = true;
    }

    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), _stopTyping);
  }

  void _stopTyping() {
    _typingTimer?.cancel();
    _typingTimer = null;
    if (!_isTypingEmitted) return;

    final id = chatId.trim();
    if (id.isEmpty) return;

    LiveChatSocketService.instance.emitTyping(chatId: id, isTyping: false);
    _isTypingEmitted = false;
  }

  void sendMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    _stopTyping();

    final senderId = currentUserId ?? '';
    final toUserId = receiverId ?? '';
    final id = chatId.trim();

    if (senderId.isEmpty || toUserId.isEmpty || id.isEmpty) {
      LiveChatSocketService.log(
        'sendMessage skipped: senderId=$senderId receiverId=$toUserId chatId=$id',
      );
      return;
    }

    LiveChatSocketService.instance.sendMessage(
      senderId: senderId,
      receiverId: toUserId,
      chatId: id,
      content: trimmed,
    );

    messages.add(
      ChatModel(
        text: trimmed,
        isSender: false,
        time: DateTime.now(),
        senderName: AuthController.i.appUser.value.data?.userModel?.fullName,
        senderImage:
            AuthController.i.appUser.value.data?.userModel?.profileImage,
      ),
    );
  }
}
