import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/utils/snackbar.dart';
import 'package:whatsapp_ui/feature/auth/controller/auth_controller.dart';

class UserScreen extends ConsumerStatefulWidget {
  static const routeName = 'user_name';
  const UserScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  File? image;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }
  void selectImage()async{
          image  = await pickImageFromGaller(context);
          setState((){

          });
  }

  void storeUserDate()async{
    String name = nameController.text.trim();
    if(name.isNotEmpty){
      ref.read(authControllerProvider).saveUserToDatabase(
        context: context,
        name: name,
        profilePic:image
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    var size =  MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Stack(
                // alignment: Alignment.bottomRight,
                children: [
                   image==null?
                  const  CircleAvatar(
                     radius: 64,
                      backgroundColor: Colors.deepPurple,
                      backgroundImage:
                      NetworkImage("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"),
                    ):CircleAvatar(
                     radius: 64,
                      backgroundColor: Colors.deepPurple,
                      backgroundImage: FileImage(image!)
                    ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(onPressed: (){
                        selectImage();
                        }, icon:const Icon(Icons.add_a_photo)),
                  )
                ],
              ),
            Row(
              children: [
                  Container(
                    width: size.width*0.8,
                    padding: const EdgeInsets.all(20),
                    child:  TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "Enter your name"
                      ),
                    ),
                  ),
                IconButton(onPressed: storeUserDate, icon:Icon(Icons.done))
              ],
            )
          ],
        ),
      ),
    );
  }
}
