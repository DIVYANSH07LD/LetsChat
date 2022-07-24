import 'package:flutter/material.dart';
import '../colors.dart';

class BottomTextWidget extends StatefulWidget {
  const BottomTextWidget({Key? key}) : super(key: key);

  @override
  State<BottomTextWidget> createState() => _BottomTextWidgetState();
}

class _BottomTextWidgetState extends State<BottomTextWidget> {
  bool isShowSendButton = false;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            onChanged: (val){
              if(val.isEmpty){
                setState((){
                  isShowSendButton = false;
                });
              }
              else{
                setState((){
                  isShowSendButton = true;
                });
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: mobileChatBoxColor,
              prefixIcon: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.emoji_emotions, color: Colors.grey,)),
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.gif, color: Colors.grey,)),
                  ],
                ),
              ),
              suffixIcon: SizedBox(
                width: 100,
                // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    IconButton(
                        onPressed: null,
                        icon: Icon(Icons.camera_alt, color: Colors.grey,)),
                    IconButton(
                        onPressed: null,
                        icon: Icon(Icons.attach_file, color: Colors.grey,)),
                  ],
                ),
              ),
              hintText: 'Type a message!',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        CircleAvatar(
          backgroundColor:deepblue,
          radius: 25,
          child: isShowSendButton==false?Icon(Icons.mic,color: whiteColor,):Icon(Icons.send,color: whiteColor,),
        ),
      ],
    );
  }
}
