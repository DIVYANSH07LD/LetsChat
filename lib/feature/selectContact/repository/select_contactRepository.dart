import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/utils/snackbar.dart';

final selectContactRepositoryProvider  = Provider((ref) => SelectContactRepository(firebaseFirestore: FirebaseFirestore.instance));

class SelectContactRepository{
    final FirebaseFirestore firebaseFirestore;

    SelectContactRepository({
      required this.firebaseFirestore
});

  Future<List<Contact>> getContacts(BuildContext context)async{
    List<Contact> contact = [];
        try{
            if(await FlutterContacts.requestPermission()){
           contact = await  FlutterContacts.getContacts(
                            withProperties: true
              );
            }
        }
            catch(e){
          showSnackBar(context: context, content: e.toString());
            }

            return contact;
  }
}