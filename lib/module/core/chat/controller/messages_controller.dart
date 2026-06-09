import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/chat/model/my_chat_model.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class MessagesController extends GetxController {
  final RxList<MyChatItem> chats = <MyChatItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  List<MyChatItem> get filteredChats {
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isEmpty) return chats;
    return chats.where((chat) {
      return chat.displayName.toLowerCase().contains(q) ||
          chat.lastMessagePreview.toLowerCase().contains(q) ||
          (chat.otherUser.phoneNumber ?? '').contains(q);
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyChats();
  }

  Future<void> fetchMyChats() async {
    isLoading.value = true;
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
      isLoading.value = false;
    }
  }

  void updateSearch(String value) => searchQuery.value = value;
}
