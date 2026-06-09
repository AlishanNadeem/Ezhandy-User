// import 'dart:developer';
// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
// import 'package:ezhandy_user/module/core/chat/controller/chat_controller.dart';
// import 'package:ezhandy_user/module/core/chat/model/chat_messages_model.dart';
// import 'package:ezhandy_user/module/core/chat/model/online_user_model.dart';
// import 'package:ezhandy_user/module/core/chat/model/order_chat_model.dart';
// import 'package:ezhandy_user/module/core/chat/model/user_chat_model.dart';
// import 'package:ezhandy_user/module/core/home/controller/home_controller.dart';
// import 'package:ezhandy_user/module/core/user/single_user/group_activity/model/group_chat_model.dart';
// import 'package:ezhandy_user/services/firebase_messaging_service.dart';
// import 'package:ezhandy_user/utils/app_dialogs.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/constant.dart';
// import 'package:ezhandy_user/utils/enums.dart';
// import 'package:ezhandy_user/utils/network_strings.dart';
// import 'package:ezhandy_user/utils/routes/app_navigation.dart';
// import 'package:ezhandy_user/widgets/loader/loader.dart';

// class SocketService {
//   static Socket? _socket;

//   SocketService._();

//   static SocketService? _instance;

//   static SocketService? get instance {
//     if (_instance == null) {
//       _instance = SocketService._();
//     }
//     return _instance;
//   }

//   Socket? get socket => _socket;
//   Future<void> initializeSocket() async {
//     final fcmToken = await FirebaseMessagingService().getToken();
//     final accessToken = AuthController.i.loginUser.value.data?.accessToken;

//     log("$accessToken access token");

//     _socket = io(
//       NetworkStrings.SOCKET_URL,
//       OptionBuilder()
//           // .set({'token': fcmToken})
//           .setExtraHeaders({'Authorization': accessToken, "token": fcmToken})
//           .enableForceNewConnection()
//           .setTransports(['websocket'])
//           .disableAutoConnect()
//           .build(),
//     );
//   }

//   void connectSocket(context) {
//     // _socket = io(NetworkStrings.SOCKET_API_BASE_URL, <String, dynamic>{
//     //   'autoConnect': false,
//     //   'transports': ['websocket'],
//     // });

//     _socket?.connect();

//     _socket?.on("connect", (data) {
//       log('Connected socket ');
//       // socketResponseMethod(context);
//       // checkSocketConnection(true);
//     });

//     _socket?.on("disconnect", (data) {
//       stopLoader();
//       log('Disconnected ' + data.toString());
//     });

//     _socket?.on("connect_error", (data) {
//       stopLoader();
//       log('Connect Error ' + data.toString());
//     });

//     _socket?.on("error", (data) {
//       stopLoader();
//       log('Error ' + data.toString());
//       // Get.snackbar("Alert", data['message'].toString());

//       // SocketNavigationClass.instance
//       //     ?.socketErrorMethod(errorResponseData: data);
//     });

//     onlineUsersListener();
//     //log("Socket Connect:${socket?.connected}");
//   }

//   void socketEmitMethod({required String eventName, required dynamic eventParamaters}) {
//     try {
//       log(eventParamaters.toString());
//       _socket?.emit(
//         eventName,
//         eventParamaters,
//       );
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//   // SingleChatProvider? singleChatProvider;

//   // void socketResponseMethod(context) {
//   //   _socket?.on("response", (data) {
//   //     stopLoader();
//   //     log("socket!.on function chal rha hai");
//   //     log(data.toString());

//   //     if (data["type"] == "joined_order_chat_success") {
//   //       log(data.toString());
//   //     } else if (data["type"] == "inbox") {
//   //       // var obj = InboxModel.fromJson(data);
//   //       // ChatController.i.inboxList.value = obj.data!;
//   //       // var single_chat =Data.fromJson(data['data']) ;
//   //       //       ChatController.i.chatList.value.add(single_chat);
//   //       //       ChatController.i.chatList.refresh();
//   //       //             ChatController.i.scrollDown(100);
//   //     } else if (data["type"] == "get_messages") {
//   //       log("get_messages");
//   //       // var obj = ChatModel.fromJson(data);
//   //       // ChatController.i.chatList.value = obj.data!;
//   //       // ChatController.i.scrollDown(2200);
//   //     } else if (data["type"] == "get_message") {
//   //       // var single_chat = ChatModelData.fromJson(data['data']);
//   //       // ChatController.i.chatList.insert(0, single_chat);
//   //       // ChatController.i.scrollDown();
//   //       //       ChatController.i.chatList.refresh();
//   //       //             ChatController.i.scrollDown(100);
//   //     } else if (data["type"] == "call_started") {
//   //       // AgoraCallNavigation.acceptCallNavigation(
//   //       //     isContractor: true, response: data);
//   //       // var obj = AgoraCallModel.fromJson(data);
//   //       // ChatController.i.agoraCallData.value = obj.data!;
//   //       //  Get.toNamed(Paths.CALL_SCREEN_ROUTE);
//   //       // ChatController.i.scrollDown(2200);
//   //     } else if (data["type"] == "call_rejected") {
//   //       // AgoraCallNavigation.rejectCallNavigation(
//   //       //     response: data, isContractor: true);

//   //       //   var obj = ChatListModel.fromJson(data);
//   //       // ChatController.i.chatList.value=obj.data!;
//   //       // ChatController.i.scrollDown(2200);
//   //     } else if (data["type"] == "call_ended") {
//   //       // AgoraCallNavigation.endCallNavigation(
//   //       //     response: data, isContractor: true);
//   //       //   var obj = ChatListModel.fromJson(data);
//   //       // ChatController.i.chatList.value=obj.data!;
//   //       // ChatController.i.scrollDown(2200);
//   //     } else if (data["type"] == "call_accepted") {
//   //       log("thsakkdmdklfkdlfkdfjdkf");
//   //       // AgoraCallNavigation.acceptCallNavigation(
//   //       //     isContractor: true, response: data);

//   //       // var obj = AgoraCallModel.fromJson(data);
//   //       // ChatController.i.agoraCallData.value = obj.data!;
//   //     }
//   //     //
//   //     // else if (data["object_type"] == "get_message") {
//   //     //   log("SEND MESSAGE");
//   //     //   singleChatProvider!.appendSingleChat(singleData: data["data"]);
//   //     // }
//   //   });

//   //   //log("response data ha:$data");
//   //   // SocketNavigationClass.instance?.socketResponseMethod(responseData: data);

//   //   _socket?.on("joined_order_chat_success", (data) {
//   //     stopLoader();
//   //     log("socket!.on function chal rha hai");
//   //     log(data.toString());

//   //     if (data["type"] == "joined_order_chat_success") {
//   //       log(data.toString());
//   //     } else if (data["type"] == "inbox") {
//   //       // var obj = InboxModel.fromJson(data);
//   //       // ChatController.i.inboxList.value = obj.data!;
//   //       // var single_chat =Data.fromJson(data['data']) ;
//   //       //       ChatController.i.chatList.value.add(single_chat);
//   //       //       ChatController.i.chatList.refresh();
//   //       //             ChatController.i.scrollDown(100);
//   //     } else if (data["type"] == "get_messages") {
//   //       log("get_messages");
//   //       // var obj = ChatModel.fromJson(data);
//   //       // ChatController.i.chatList.value = obj.data!;
//   //       // ChatController.i.scrollDown(2200);
//   //     } else if (data["type"] == "get_message") {
//   //       // var single_chat = ChatModelData.fromJson(data['data']);
//   //       // ChatController.i.chatList.insert(0, single_chat);
//   //       // ChatController.i.scrollDown();
//   //       //       ChatController.i.chatList.refresh();
//   //       //             ChatController.i.scrollDown(100);
//   //     } else if (data["type"] == "call_started") {
//   //       // AgoraCallNavigation.acceptCallNavigation(
//   //       //     isContractor: true, response: data);
//   //       // var obj = AgoraCallModel.fromJson(data);
//   //       // ChatController.i.agoraCallData.value = obj.data!;
//   //       //  Get.toNamed(Paths.CALL_SCREEN_ROUTE);
//   //       // ChatController.i.scrollDown(2200);
//   //     } else if (data["type"] == "call_rejected") {
//   //       // AgoraCallNavigation.rejectCallNavigation(
//   //       //     response: data, isContractor: true);

//   //       //   var obj = ChatListModel.fromJson(data);
//   //       // ChatController.i.chatList.value=obj.data!;
//   //       // ChatController.i.scrollDown(2200);
//   //     } else if (data["type"] == "call_ended") {
//   //       // AgoraCallNavigation.endCallNavigation(
//   //       //     response: data, isContractor: true);
//   //       //   var obj = ChatListModel.fromJson(data);
//   //       // ChatController.i.chatList.value=obj.data!;
//   //       // ChatController.i.scrollDown(2200);
//   //     } else if (data["type"] == "call_accepted") {
//   //       log("thsakkdmdklfkdlfkdfjdkf");
//   //       // AgoraCallNavigation.acceptCallNavigation(
//   //       //     isContractor: true, response: data);

//   //       // var obj = AgoraCallModel.fromJson(data);
//   //       // ChatController.i.agoraCallData.value = obj.data!;
//   //     }
//   //     //
//   //     // else if (data["object_type"] == "get_message") {
//   //     //   log("SEND MESSAGE");
//   //     //   singleChatProvider!.appendSingleChat(singleData: data["data"]);
//   //     // }
//   //   });
//   // }

//   void onlineUsersListener() {
//     _socket?.on("onlineUsers", (data) {
//       log(data.toString());
//       log(data.toString());
//       ChatController.i.OnlineUserList.clear();
//       ChatController.i.OnlineUserList.refresh();
//       print(data.toString());
//       log(data.toString());
//       var obj = OnlineUserModel.fromJson(data);
//       ChatController.i.OnlineUserList.value = obj.data!;
//       ChatController.i.OnlineUserList.refresh();
//       // ChatController.i.orderChatWithDropshipper.value.messages?.insert(0, OrderChatModelMessages.fromJson(data));
//       // ChatController.i.scrollDown();
//     });
//   }

//   // ----------------------------dropshipper and user product chat-----------------------
//   void getChatMessagesSocket({orderId, sellerId}) {
//     _socket?.emit("all_private_chats_order");
//     HomeController.i.loaderApi.value = true;
//     _socket?.on("all-chats_order", (data) {
//       HomeController.i.loaderApi.value = false;
//       // if (data is Map) {}
//       ChatController.i.chatMessagesDropshipperList.clear();
//       ChatController.i.chatMessagesDropshipperList.refresh();
//       print(data.toString());
//       log(data.toString());
//       var obj = ChatMessagesModel.fromJson(data);
//       ChatController.i.chatMessagesDropshipperList.value = obj.data!;
//       ChatController.i.chatMessagesDropshipperList.refresh();
//     });
//   }

//   void getOrderChatSocket({orderId, sellerId}) {
//     log(orderId.toString() + "  " + sellerId.toString());
//     _socket?.emit("join_private_chat_order", {
//       "orderId": orderId,
//       "recipientId": sellerId,
//     });
//     _socket?.on("joined_order_chat_success", (data) {
//       log(data.toString());
//       log(data.toString());
//       // if (data is Map) {}

//       ChatController.i.chatId.value = data['chatId'];

//       ChatController.i.orderChatWithDropshipper.value = OrderChatModelData();

//       ChatController.i.getAllOrderChatMessages(chatId: data['chatId'], loader: false, limit: 20);
//     });
//   }

//   void sentOrderChatSocket({chatId, sellerId, message, orderId}) {
//     _socket?.emit("send_private_msg_order", {
//       "orderId": orderId,
//       "chatId": chatId,
//       "recipientId": sellerId,
//       "message": message,
//     });
//   }

//   void senderListener() {
//     _socket?.on("newMessage_order", (data) {
//       log(data.toString());
//       log(data.toString());
//       ChatController.i.orderChatWithDropshipper.value.messages?.insert(0, OrderChatModelDataMessages.fromJson(data));
//       ChatController.i.orderChatWithDropshipper.refresh();
//       ChatController.i.scrollDown();
//     });
//   }

//   // void checkSpecificListeners() {
//   //   log('=== Socket Listener Status ===');
//   //   final events = [
//   //     'connect',
//   //     'privateMsg_order',
//   //     'connect_error',
//   //     'error',
//   //     'disconnect',
//   //     'privateMessage',
//   //     'joined_private_chat_success',
//   //     // "single-job-$jobId"
//   //   ];
//   //   log('=== Listener Status ===');
//   //   for (var event in events) {
//   //     log('$event: ${_socket?.hasListeners(event) ?? false}');
//   //   }
//   // }

//   void listenOrderChatMessage() {
//     _socket?.on("privateMsg_order", (data) {
//       log(data.toString());
//       ChatController.i.orderChatWithDropshipper.value.messages?.insert(0, OrderChatModelDataMessages.fromJson(data));
//       ChatController.i.orderChatWithDropshipper.refresh();
//       ChatController.i.scrollDown();

//       //  HomeController.i.orderChatWithDropshipper.value.messages?.add(value)
//     });
//   }

//   void leaveOrderChatMessage({chatId}) {
//     log(chatId.toString());
//     _socket?.emit("leave_private_chat_order", {
//       "chatId": chatId,
//     });
//   }

//   void disposeOrderChat() {
//     _socket?.off("joined_order_chat_success");
//     _socket?.off("privateMsg_order");
//     _socket?.off("newMessage_order");
//     // _socket?.off("all-chats_order");
//   }

//   void disposeOrderMessages() {
//     _socket?.off("all-chats_order");
//   }

//   // ----------------------------dropshipper and user product chat-----------------------
//   // ----------------------------Connection Chat-----------------------
//   void getConnectionChatSocket({recipientId, chatId}) {
//     log(recipientId.toString());
//     log(chatId.toString());
//     ChatController.i.userChatList.value.messages?.clear();

//     _socket?.emit("join_private_chat", {
//       "recipientId": recipientId,
//       "chatId": chatId,
//       // "token": await FirebaseMessagingService().getToken(),
//     });
//     // HomeController.i.loaderApi.value = true;
//     _socket?.on("joined_private_chat_success", (data) {
//       // HomeController.i.loaderApi.value = false;
//       // // if (data is Map) {}
//       // ChatController.i.userChatList.clear();
//       // ChatCvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvffffffffffffffffffffffffffontroller.i.chatMessagesDropshipperList.refresh();
//       print(data.toString());
//       log(data.toString());
//       ChatController.i.chatId.value = data['chatId'];
//       senderConnectionChatListener();
//       receiverConnectionChatListener();
//       senderWouldYouRatherListener();
//       receiverWouldYouRatherListener();
//       ChatController.i.getAllPrivateChatMessages(chatId: chatId, loader: false, limit: 20);
//     });
//   }

//   void disposeConnectionChatsListener() {
//     _socket?.off("newMessage");
//     _socket?.off("privateMsg");
//     _socket?.off("select_newMessage");
//     _socket?.off("select_privateMsg");
//     // _socket?.off("leaveUserChat");
//     _socket?.off("joined_private_chat_success");
//   }

//   void senderConnectionChatListener() {
//     print("pppp");
//     _socket?.on("newMessage", (data) {
//       print("ghk");
//       print(data.toString());
//       log(data.toString());
//       ChatController.i.userChatList.value.messages?.insert(0, UserChatModelDataMessages.fromJson(data['data']));
//       ChatController.i.userChatList.refresh();
//       ChatController.i.scrollDown();

//       if (data['data']['messageType'] == MessageType.COMMITEMENT.name) {
//         AppDialogs.showSuccessfulDialog(
//           Constants.navigatorKey.currentContext!,
//           title: AppStrings.requestSent,
//           description: AppStrings.yourRequestHasBeenSent,
//           onSubmit: () {
//             AppNavigation.navigatorPop(Constants.navigatorKey.currentContext!);
//           },
//         );
//       }
//     });
//   }

//   void receiverConnectionChatListener() {
//     _socket?.on("privateMsg", (data) {
//       print(data.toString());
//       log(data.toString());
//       ChatController.i.userChatList.value.messages?.insert(0, UserChatModelDataMessages.fromJson(data['data']));
//       ChatController.i.userChatList.refresh();
//       ChatController.i.scrollDown();
//     });
//   }

//   void senderWouldYouRatherListener() {
//     print("pppp");
//     _socket?.on("select_newMessage", (data) {
//       print("ghk");
//       print(data.toString());
//       log(data.toString());
//       for (var obj in ChatController.i.userChatList.value.messages!) {
//         if (obj?.id == data['data']['id']) {
//           obj?.selectedOption = data['data']['option'];
//           break;
//         }
//       }
//       ChatController.i.userChatList.refresh();
//       // ChatController.i.userChatList
//       // ChatController.i.userChatList.insert(0, UserChatModelMessages.fromJson(data['data']));
//       // ChatController.i.scrollDown();
//     });
//   }

//   void receiverWouldYouRatherListener() {
//     _socket?.on("select_privateMsg", (data) {
//       print("ghk");
//       print(data.toString());
//       log(data.toString());
//       for (var obj in ChatController.i.userChatList.value.messages!) {
//         if (obj?.id == data['data']['id']) {
//           obj?.selectedOption = data['data']['option'];
//           break;
//         }
//       }
//       ChatController.i.userChatList.refresh();

//       // ChatController.i.userChatList.insert(0, UserChatModelMessages.fromJson(data['data']));
//       // ChatController.i.userChatList.refresh();
//       // ChatController.i.scrollDown();
//     });
//   }

//   void sentUserChatSocket({chatId, recipientId, message, messageType, optionOne, optionTwo}) {
//     log(recipientId.toString());
//     log(recipientId.toString());

//     Map<String, dynamic> rawData = {
//       "chatId": chatId,
//       "recipientId": recipientId,
//       "message": message,
//       "messageType": messageType,
//       // "option": option,
//       "optionOne": optionOne,
//       "optionTwo": optionTwo,
//     };
//     // print(rawData.toString());
//     // print(rawData.toString());
//     rawData.removeWhere((key, value) => value == null || value.toString().trim().isEmpty);
//     print(rawData.toString());
//     print(rawData.toString());

//     _socket?.emit("send_private_msg", rawData);
//     // senderConnectionChatListener();
//   }

//   void singleUserMessagesChatCountSocket() {
//     // _socket?.emit("join_private_chat");
//     // // HomeController.i.loaderApi.value = true;
//     _socket?.on("all-chats", (data) {
//       //   // HomeController.i.loaderApi.value = false;
//       //   // // if (data is Map) {}
//       //   // ChatController.i.chatMessagesDropshipperList.clear();
//       //   // ChatController.i.chatMessagesDropshipperList.refresh();
//       print(data.toString());
//       log(data.toString());
//       for (var obj in HomeController.i.allFriendsConnectionList) {
//         if (obj?.id == data['data']) {
//           // Optional: Update the unread count
//           obj!.unreadCount!.Message = (obj.unreadCount!.Message! + 1);

//           // Move to 0 index
//           HomeController.i.allFriendsConnectionList.remove(obj);
//           log(HomeController.i.allFriendsConnectionList.toString());
//           log(obj.toString());
//           HomeController.i.allFriendsConnectionList.insert(0, obj);
//           log(HomeController.i.allFriendsConnectionList.toString());
//           log(obj.toString());

//           break; // Stop loop after moving
//         }
//       }

//       HomeController.i.allFriendsConnectionList.refresh();
//       //   // var obj = ChatMessagesModel.fromJson(data);
//       //   // ChatController.i.chatMessagesDropshipperList.value = obj.data!;
//       // ChatController.i.chatMessagesDropshipperList.refresh();
//     });
//   }

//   void leaveUserChat({chatId}) {
//     _socket?.emit("leave_private_chat", {
//       "chatId": chatId,
//       // "token": await FirebaseMessagingService().getToken(),
//     });
//   }

//   Future<void> wouldYouRatherChatSocket({chatId, recipientId, option, messageId}) async {
//     log(recipientId.toString());
//     log(recipientId.toString());

//     Map<String, dynamic> rawData = {
//       "chatId": chatId,
//       "recipientId": recipientId,
//       "messageId": messageId,
//       "option": option,
//     };
//     // print(rawData.toString());
//     // print(rawData.toString());
//     rawData.removeWhere((key, value) => value == null || value.toString().trim().isEmpty);
//     print(rawData.toString());
//     print(rawData.toString());

//     _socket?.emit("select_option", rawData);
//     // senderConnectionChatListener();
//   }

//   // ----------------------------Connection Chat-----------------------

// // ----------------------------Group Single Chat-----------------------
//   void getGroupSingleChatSocket({groupId}) {
//     log(groupId.toString());
//     // log(chatId.toString());
//     ChatController.i.groupChatMessagesList.value.messages?.clear();

//     _socket?.emit("join_group_chat", {
//       "id": groupId,
//     });
//     // HomeController.i.loaderApi.value = true;
//     _socket?.on("joined_group_chat_success", (data) {
//       // HomeController.i.loaderApi.value = false;
//       // // if (data is Map) {}
//       // ChatController.i.userChatList.clear();
//       // ChatCvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvffffffffffffffffffffffffffontroller.i.chatMessagesDropshipperList.refresh();
//       print(data.toString());
//       log(data.toString());
//       ChatController.i.chatId.value = data['groupId'];
//       senderGroupSingleChatListener();
//       receiverGroupSingleChatListener();

//       ChatController.i.getAllGroupChatMessages(groupId: groupId, loader: false, limit: 20);
//     });
//   }

//   void sentGroupSingleChatSocket({groupId, message}) {
//     log(groupId.toString());

//     Map<String, dynamic> rawData = {
//       "id": groupId,
//       "message": message,
//     };
//     // print(rawData.toString());
//     // print(rawData.toString());
//     rawData.removeWhere((key, value) => value == null || value.toString().trim().isEmpty);
//     print(rawData.toString());
//     print(rawData.toString());

//     _socket?.emit("send_group_msg", rawData);
//     // senderConnectionChatListener();
//   }

//   void disposeGroupSingleChatsListener() {
//     // _socket?.off("privateMsg");
//     // _socket?.off("select_newMessage");
//     _socket?.off("newGroupMessage");
//     _socket?.off("groupMessage");
//     _socket?.off("joined_group_chat_success");
//     // _socket?.off("joined_private_chat_success");
//   }

//   void leaveGroupSingleChat({groupId}) {
//     _socket?.emit("leave_group_chat", {
//       "id": groupId,
//     });
//   }

//   void senderGroupSingleChatListener() {
//     print("pppp");
//     _socket?.on("newGroupMessage", (data) {
//       print("ghk");
//       print(data.toString());
//       log(data.toString());
//       ChatController.i.groupChatMessagesList.value.messages?.insert(0, GroupChatMessagesModelDataMessages.fromJson(data['data']));
//       ChatController.i.groupChatMessagesList.refresh();
//       ChatController.i.scrollDown();
//     });
//   }

//   void receiverGroupSingleChatListener() {
//     _socket?.on("groupMessage", (data) {
//       print(data.toString());
//       log(data.toString());
//       ChatController.i.groupChatMessagesList.value.messages?.insert(0, GroupChatMessagesModelDataMessages.fromJson(data['data']));
//       ChatController.i.groupChatMessagesList.refresh();
//       ChatController.i.scrollDown();
//     });
//   }

//   void singleGroupMessagesChatCountSocket() {
//     // _socket?.emit("join_private_chat");
//     // // HomeController.i.loaderApi.value = true;
//     _socket?.on("all-group-chats", (data) {
//       //   // HomeController.i.loaderApi.value = false;
//       //   // // if (data is Map) {}
//       //   // ChatController.i.chatMessagesDropshipperList.clear();
//       //   // ChatController.i.chatMessagesDropshipperList.refresh();
//       print(data.toString());
//       log(data.toString());
//       for (var obj in ChatController.i.groupChatList) {
//         if (obj?.id == data['groupId']) {
//           // Optional: Update the unread count
//           obj!.unreadCount = ((obj.unreadCount ?? 0) + 1);

//           // Move to 0 index
//           ChatController.i.groupChatList.remove(obj);
//           log(ChatController.i.groupChatList.toString());
//           log(obj.toString());
//           ChatController.i.groupChatList.insert(0, obj);
//           log(ChatController.i.groupChatList.toString());
//           log(obj.toString());

//           break; // Stop loop after moving
//         }
//       }

//       HomeController.i.allFriendsConnectionList.refresh();
//       //   // var obj = ChatMessagesModel.fromJson(data);
//       //   // ChatController.i.chatMessagesDropshipperList.value = obj.data!;
//       // ChatController.i.chatMessagesDropshipperList.refresh();
//     });
//   }

//   void dispose() {
// // hello
//     _socket?.off("onlineUsers");
//     _socket?.off("all-chats");
//     _socket?.off("all-group-chats");
//     _socket?.disconnect();
//     _socket?.dispose();
//     // ChatController.i.chatList.value.clear();
//   }
// }
