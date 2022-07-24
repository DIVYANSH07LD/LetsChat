import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/utils/snackbar.dart';
import 'package:whatsapp_ui/feature/chat/screens/mobile_chat_screen.dart';

import '../../../model/usermodel.dart';

final selectContactRepositoryProvider  = Provider((ref) => SelectContactRepository(firebaseFirestore: FirebaseFirestore.instance));

class SelectContactRepository{
    final FirebaseFirestore firebaseFirestore;

    SelectContactRepository({
      required this.firebaseFirestore
});

  Future<List<Contact>> getContacts()async{
    List<Contact> contact = [];
        try{
            if(await FlutterContacts.requestPermission()){
           contact = await  FlutterContacts.getContacts(
                            withProperties: true
              );
            }
        }
            catch(e){
         debugPrint(e.toString());
            }

            return contact;
  }

  void selectContats(Contact selectedContact,BuildContext context)async{
    try{
      var userCollection = await firebaseFirestore.collection('users').get();
      bool isFound = false;
      for(var document in userCollection.docs){
          var userData = UserModel.fromMap(document.data());
          String selectedPhoneNumber = selectedContact.phones[0].number.replaceAll(' ', '');
          String result = selectedPhoneNumber.replaceAll(RegExp('\\s+'), '');
                  if(result==userData.userPhone){
                    isFound = true;
                    Navigator.pushNamed(context, MobileChatScreen.routeName,arguments:{
                      'name':userData.username,
                      'uid':userData.uid
                    } );
                  }
          print(result+userData.userPhone);
      }
      if(!isFound){
          showSnackBar(context: context, content: "This number does not exist on this app");
      }
    }
        catch(e){
      showSnackBar(context: context, content: e.toString());
        }
  }
}