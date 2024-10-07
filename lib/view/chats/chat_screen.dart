import 'dart:io';

import 'package:ar_chat/constants/app_styles.dart';
import 'package:ar_chat/model/chat.dart';
import 'package:ar_chat/model/messages.dart';
import 'package:ar_chat/model/user_profile.dart';
import 'package:ar_chat/services/auth_service.dart';
import 'package:ar_chat/services/database_service.dart';
import 'package:ar_chat/services/media_service.dart';
import 'package:ar_chat/services/storage_service.dart';
import 'package:ar_chat/theme/app_colors.dart';
import 'package:ar_chat/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_config/responsive_config.dart';

class ChatScreen extends StatefulWidget {
  final UserProfile chatUser;

  const ChatScreen({super.key, required this.chatUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late AuthService _authService;
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;
  late MediaService _mediaService;
  late StorageService _storageService;
  ChatUser? currentUser, otherUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authService = _getIt.get<AuthService>();
    currentUser = ChatUser(
        id: _authService.user!.uid, firstName: _authService.user!.displayName);
    otherUser = ChatUser(
      id: widget.chatUser.uid!,
      firstName: widget.chatUser.name,
      profileImage: widget.chatUser.pfpURL,
    );
    _databaseService = _getIt.get<DatabaseService>();
    _mediaService = _getIt.get<MediaService>();
    _storageService = _getIt.get<StorageService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.chatUser.name!,
          style: AppStyles.w400f12poppins.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: getProportionateScreenWidth(16),
            ),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.chatUser.pfpURL!),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _databaseService.getChatData(currentUser!.id, otherUser!.id),
        builder: (context, snapshot) {
          Chat? chat = snapshot.data?.data();
          List<ChatMessage> messages = [];
          if (chat != null && chat.messages != null) {
            messages = _generateChatMessages(chat.messages!);
          }
          return DashChat(
            messageOptions: const MessageOptions(
              showOtherUsersAvatar: true,
              showTime: true,
            ),
            inputOptions: InputOptions(
              alwaysShowSend: true,
              leading: [
                _mediaMessageButton(),
              ],
            ),
            currentUser: currentUser!,
            onSend: _sendMessage,
            messages: messages,
          );
        },
      ),
    );
  }

  Future<void> _sendMessage(ChatMessage chatMessage) async {
    if (chatMessage.medias?.isNotEmpty ?? false) {
      if (chatMessage.medias!.first.type == MediaType.image) {
        Message message = Message(
          senderID: chatMessage.user.id,
          content: chatMessage.medias!.first.url,
          messageType: MessageType.Image,
          sentAt: Timestamp.fromDate(chatMessage.createdAt),
        );
        await _databaseService.sendChatMessage(
          currentUser!.id,
          otherUser!.id,
          message,
        );
      }
    } else {
      Message message = Message(
        senderID: currentUser!.id,
        content: chatMessage.text,
        messageType: MessageType.Text,
        sentAt: Timestamp.fromDate(chatMessage.createdAt),
      );
      await _databaseService.sendChatMessage(
        currentUser!.id,
        otherUser!.id,
        message,
      );
    }
  }

  List<ChatMessage> _generateChatMessages(List<Message> messages) {
    List<ChatMessage> chatMessages = messages.map((m) {
      if(m.messageType == MessageType.Image){
        return ChatMessage(
          user: m.senderID == currentUser!.id ? currentUser! : otherUser!,
          createdAt: m.sentAt!.toDate(),
          medias: [
            ChatMedia(
              url: m.content!,
              fileName: '',
              type: MediaType.image,
            )
          ],
        );
      } else {
        return ChatMessage(
          text: m.content!,
          user: m.senderID == currentUser!.id ? currentUser! : otherUser!,
          createdAt: m.sentAt!.toDate(),
        );
      }

    }).toList();
    chatMessages.sort((a, b) {
      return b.createdAt.compareTo(a.createdAt);
    });
    return chatMessages;
  }

  Widget _mediaMessageButton() {
    return IconButton(
      onPressed: () async {
        File? file = await _mediaService.pickImage();
        if (file != null) {
          String chatID = generateChatID(
            uid1: currentUser!.id,
            uid2: otherUser!.id,
          );
          String? downloadUrl = await _storageService.uploadChatImage(
            file: file,
            chatID: chatID,
          );
          if (downloadUrl != null) {
            ChatMessage chatMessage = ChatMessage(
              user: currentUser!,
              createdAt: DateTime.now(),
              medias: [
                ChatMedia(
                  url: downloadUrl,
                  fileName: '',
                  type: MediaType.image,
                )
              ],
            );
            _sendMessage(chatMessage);
          }
        }
      },
      icon: Icon(
        Icons.image,
        color: kPrimaryColor,
      ),
    );
  }
}
