import 'package:flutter/material.dart';
import 'package:whatsapp_ui/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPresses;
  const CustomButton({Key? key,required this.text,this.onPresses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPresses, child: Text(text.toString(),style: TextStyle(
      color: whiteColor,fontSize: 18,
    ),),
    style: ElevatedButton.styleFrom(
      primary: deepblue,
      padding: EdgeInsets.all(10),
      minimumSize: const Size(double.infinity,50)
    ),
    );
  }
}
