import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


void showSnackBar({required BuildContext context,required String content}){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:Text(content),
          ),
      );
}

Future<File?> pickImageFromGaller(BuildContext context)async{
  File? file;
  try{
          final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
          if(pickedImage!=null){
              file = File(pickedImage.path);
          }
  }
      catch(e){
    showSnackBar(context: context, content: e.toString());
      }
      return file;
}