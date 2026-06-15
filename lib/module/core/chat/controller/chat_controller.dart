import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';import 'package:ezhandy_user/module/core/chat/model/chat_history_message_model.dart';
import 'package:ezhandy_user/module/core/chat/model/chat_model.dart';
import 'package:ezhandy_user/services/live_chat_socket_service.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  ChatController({
    required this.chatId,
    this.otherUserName,
    this.otherUserImage,
  });

  final String chatId;
  final String? otherUserName;
  final String? otherUserImage;

  final RxList<ChatModel> messages = <ChatModel>[].obs;
  final RxBool isLoading = false.obs;

  final Set<int> _messageIds = <int>{};
  void Function(dynamic)? _messageReceivedHandler;

  String? get currentUserId =>
      AuthController.i.appUser.value.data?.userModel?.sub?.trim();

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
    if (_messageReceivedHandler != null) {
      LiveChatSocketService.instance
          .off('messageReceived', _messageReceivedHandler);
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
    if (item.id > 0 && _messageIds.contains(item.id)) return;

    if (item.id > 0) {
      _messageIds.add(item.id);
    }

    final userId = currentUserId ?? '';
    messages.add(
      ChatModel(
        text: item.content,
        isSender: userId.isEmpty || item.senderId != userId,
        time: item.createdAt ?? DateTime.now(),
        senderName: item.senderName,
        senderImage: item.senderImage,
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

  void addLocalMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    messages.add(
      ChatModel(
        text: trimmed,
        isSender: false,
        time: DateTime.now(),
        senderName: AuthController.i.appUser.value.data?.userModel?.fullName,
        senderImage: AuthController.i.appUser.value.data?.userModel?.profileImage,
      ),
    );
  }
}
