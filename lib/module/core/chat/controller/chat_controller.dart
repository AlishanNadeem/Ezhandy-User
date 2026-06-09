import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/chat/model/chat_history_message_model.dart';
import 'package:ezhandy_user/module/core/chat/model/chat_model.dart';
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

  String? get currentUserId =>
      AuthController.i.appUser.value.data?.userModel?.sub?.trim();

  String get title =>
      otherUserName?.trim().isNotEmpty == true ? otherUserName!.trim() : 'Chat';

  @override
  void onInit() {
    super.onInit();
    if (chatId.trim().isNotEmpty) {
      fetchChatHistory();
    }
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
            messages.assignAll(
              history.map(
                (item) => ChatModel(
                  text: item.content,
                  isSender: userId.isEmpty || item.senderId != userId,
                  time: item.createdAt ?? DateTime.now(),
                  senderName: item.senderName,
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
      ),
    );
  }
}
