import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/chat/model/my_chat_model.dart';
import 'package:ezhandy_user/services/live_chat_socket_service.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';
class MessagesController extends GetxController {
  MessagesController({this.chatType = 'private'});

  final String chatType;

  final RxList<MyChatItem> chats = <MyChatItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  void Function(dynamic)? _messageReceivedHandler;

  List<MyChatItem> get filteredChats {
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isEmpty) return chats;
    return chats.where((chat) {
      return chat.displayName.toLowerCase().contains(q) ||
          chat.lastMessagePreview.toLowerCase().contains(q) ||
          (chat.otherUser.phoneNumber ?? '').contains(q);
    }).toList();
  }

  bool _matchesChatType(String itemChatType) {
    return itemChatType.trim().toLowerCase() == chatType.trim().toLowerCase();
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyChats();
    _initSocket();
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
      _messageReceivedHandler = (data) {
        LiveChatSocketService.log('messageReceived (messages list): $data');
        fetchMyChats(showLoader: false);
      };
      LiveChatSocketService.instance
          .on('messageReceived', _messageReceivedHandler!);
    } catch (e, st) {
      LiveChatSocketService.log('messages init failed: $e\n$st');
    }
  }

  Future<void> fetchMyChats({bool showLoader = true}) async {
    if (showLoader) {
      isLoading.value = true;
    }
    try {
      final response = await DioClient().getRequest(
        endPoint: NetworkStrings.myChatsEndpoint,
        isHeaderRequire: true,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (res) {
            final raw = res is Map ? res['data'] : null;
            if (raw is List) {
              chats.assignAll(
                raw
                    .whereType<Map>()
                    .map(
                      (e) => MyChatItem.fromJson(
                        Map<String, dynamic>.from(e),
                      ),
                    )
                    .where((c) => c.chatId.isNotEmpty)
                    .where((c) => _matchesChatType(c.chatType))
                    .toList(),
              );
            } else {
              chats.clear();
            }
          },
          onFailureCallback: (_) => chats.clear(),
        ),
      );
    } finally {
      if (showLoader) {
        isLoading.value = false;
      }
    }
  }

  void updateSearch(String value) => searchQuery.value = value;
}
