import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_ui/feature/auth/repositry/auth_repository.dart';
import 'package:whatsapp_ui/info.dart';
import 'package:whatsapp_ui/model/usermodel.dart';
import 'package:whatsapp_ui/widgets/chat_list.dart';

import '../../../widgets/bottom_widget_textfield.dart';

class MobileChatScreen extends ConsumerWidget {

  static const routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  const MobileChatScreen({Key? key,required this.uid,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
          stream: ref.read(authControllerProvider).userDataById(uid),
          builder: (context,snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting)
              {
                return Loader();
              }
            else{
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name.toString(),style: TextStyle(color: whiteColor),),
                  Row(
                    children: [
                      CircleAvatar(radius: 4 ,backgroundColor:snapshot.data!.isOnline?Colors.green:Colors.grey),
                      SizedBox(
                        width: 5,
                      ),
                      Text(snapshot.data!.isOnline?'online':'offline',style: TextStyle(color: whiteColor,fontSize: 15)),
                    ],
                  ),
                ],
              );
            }

          }
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: ChatList(),
          ),
            BottomTextWidget(),
        ],
      ),
    );
  }


}