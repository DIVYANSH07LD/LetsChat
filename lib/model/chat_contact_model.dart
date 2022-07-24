class ChatContactModel{
    final String name;
    final String profilePic;
    final DateTime lastTime;
    final String lastMessage;
    final String contactId;

  ChatContactModel(
      {
        required this.name ,
        required this.profilePic,
        required this.lastTime,
        required this.lastMessage,
        required this.contactId
      });

  Map<String,dynamic> toMap(){
        return {
          'name':name,
          'profilePic':profilePic,
          'timeSent':lastTime,
          'lastMessage':lastMessage,
          'contactId':contactId
        };
  }

  factory ChatContactModel.fromMap(Map<String,dynamic>map){
    return ChatContactModel(
        name: map['name']??'',
        profilePic: map['profilePic']??'',
        lastTime: map['lastTime']??'',
        lastMessage:map['lastMessage']??'',
        contactId: map['contactId']??''
    );
  }

}