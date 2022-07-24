import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/feature/selectContact/controller/selectContactController.dart';
import '../common/widgets/errorwidget.dart';
import '../common/widgets/loader.dart';

class SelectContact extends ConsumerWidget {
  static const routeName = '/select-contact';
  const SelectContact({Key? key}) : super(key: key);

  void selectContacts(WidgetRef ref,Contact contact,BuildContext context){
  ref.read(selectContactControllerProvider).selectContact(contact, context );

  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(),
          title: Text("Select Conatcts"),
        actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.search)),
            IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: ref.watch(getContactProvider).when(
          data: (contactList)=>ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context,index){
            final contacts = contactList[index];
            return ListTile(
              onTap: (){
                selectContacts(
                  ref,contacts,context
                );
              },
              title: Text(contacts.displayName.toString()),
              leading: contacts.photo==null?null:
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.deepPurple,
                backgroundImage: MemoryImage(contacts.photo!),
              ),
            );
          }),
          error: (error,trace){
            return ErrorScreenWidget(
              error: error.toString(),
            );
          },
          loading: (){
            return Loader();
          }
            ),
    );
  }
}
