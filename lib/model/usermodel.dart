class UserModel{
    final String proficPic;
    final String username;
    final String uid;
    final bool isOnline;
    final String userPhone;
    final List<dynamic> groupId;

  UserModel(
      {required this.proficPic,
        required  this.username,
        required this.uid,
        required this.isOnline,
        required this.userPhone,
        required this.groupId});

  Map<String,dynamic> toMap(){
    return{
        'name':username,
        'uid':uid,
        'profilePic':proficPic,
        'isOnline':isOnline,
        'userPhone':userPhone,
        'groupId':groupId
    };
  }

  factory UserModel.fromMap(Map<String,dynamic>map){
        return UserModel(
          groupId:  map['groupId']??'',
          isOnline:  map['isOnline']??'',
         proficPic:   map['profilePic']??'',
          uid:  map['uid']??'',
       username:     map['username']??'',
         userPhone:   map['userPhone']??'',
        );
  }
}