import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_ui/common/utils/snackbar.dart';
import 'package:whatsapp_ui/constant/enums.dart';
import 'package:whatsapp_ui/model/chat_contact_model.dart';
import 'package:whatsapp_ui/model/message_model.dart';
import 'package:whatsapp_ui/model/usermodel.dart';

class ChatRepository{
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.auth,required this.firestore});

  ///save data to contact subcollection
 void _saveDataToContactSubCollection(
    UserModel sendUserData,
    UserModel recieverUserData,
    String text,
    DateTime time,
    String reciverId
)async{
   /// users ---> reciever User Id ---> CHAT ---> current User Id ---> set Data
   var recieverChatContact = ChatContactModel(
       name: sendUserData.username,
       profilePic: sendUserData.proficPic,
       lastTime: time,
       lastMessage:text,
       contactId: sendUserData.uid);
   
   await firestore.collection('users').doc(reciverId).collection('chats').doc(sendUserData.uid).set(recieverUserData.toMap());
   /// users ---> current User Id ---> CHAT ---> reciever User Id  ---> set Data
   ///
   var senderChatContact= ChatContactModel(
       name: recieverUserData.username,
       profilePic: recieverUserData.proficPic,
       lastTime: time,
       lastMessage:text,
       contactId: recieverUserData.uid
   );

   await firestore.collection('users').doc(sendUserData.uid).collection('chats').doc(reciverId).set(senderChatContact.toMap());
  }


  void _saveMessagetoMessageSubCollection(
  {
    required String receieverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String userName,
    required String receiverUserName,
    required MessageEnum messageType
  })async{
        final message = MessageModel(
            senderId: auth.currentUser!.uid,
            recieverId: receieverUserId,
            text: text,
            type: messageType,
            isSeen: false,
            timeSent: timeSent,
            messageId: messageId
        );
}

  /// this is used to send message to the reciever using RecieverID
  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverId,
    required UserModel sendUser
  })async{
              /// users ---> senderId ---> recieverId ---> message ---> messageId ---> store message
    try{
      var timeSent = DateTime.now();
      UserModel reciverUserData;
      var userDataMap = await firestore.collection('users').doc(recieverId).get();
      reciverUserData = UserModel.fromMap(userDataMap.data()!);
      var messageId = const Uuid().v1();
      _saveDataToContactSubCollection(
        sendUser,
        reciverUserData,
        text,
        timeSent,
        recieverId
      );

      ///users ---> recieverUserId ------> setData
      _saveMessagetoMessageSubCollection(
        messageId:messageId,
        //////issue
        messageType:MessageEnum.text,
        receieverUserId:recieverId,
        receiverUserName: reciverUserData.username,
        text: text,
        timeSent: timeSent,
        userName: sendUser.username
      );
    }
    catch(e){
        showSnackBar(context: context, content: e.toString());
    }

  }
}