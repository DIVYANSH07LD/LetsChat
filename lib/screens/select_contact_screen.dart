import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/feature/selectContact/controller/selectContactController.dart';
import 'package:whatsapp_ui/widgets/contacts_list.dart';

import '../common/widgets/errorwidget.dart';
import '../common/widgets/loader.dart';

class SelectContact extends ConsumerWidget {
  static const routeName = '/select-contact';
  const SelectContact({Key? key}) : super(key: key);

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
              itemCount: 5,
              itemBuilder: (context,index){
            // final contacts = contact[index];
            return ListTile(
              // title: Text(contactList.),
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
