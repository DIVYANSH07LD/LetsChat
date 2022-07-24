import '../constant/enums.dart';

class MessageModel{
    final String senderId;
    final String recieverId;
    final String text;
    final MessageEnum type;
    final bool isSeen;
    final DateTime timeSent;
    final String messageId;

  MessageModel(
      {
        required  this.senderId,
        required this.recieverId,
        required this.text,
        required this.type,
        required this.isSeen,
        required  this.timeSent,
        required this.messageId
      });

    Map<String,dynamic> toMap(){
      return {
        'senderId':senderId,
        'recieverId':recieverId,
        'text':text,
        'type':type.type,
        'timeSent':timeSent,
        "messageId":messageId,
        'isSeen':isSeen
      };
    }

    factory MessageModel.fromMap(Map<String,dynamic>map){
      return MessageModel(
          senderId:map[ 'senderId']??'',
          recieverId: map['recieverId']??'',
          text: map['text']??"",
          type: (map['type']).toEnum(),
          isSeen: map['isSeen']??'',
          timeSent: map['timeSent']??'',
          messageId: map['messageId']??''
      );
    }
}