import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/feature/auth/controller/auth_controller.dart';
import '../colors.dart';


class OtpScreen extends ConsumerWidget {
  static const routeName = '/otpscreen';
  final String verificationId;
  const OtpScreen({Key? key,required this.verificationId});

  void verifyOtp(WidgetRef ref,BuildContext context,String Otp){
    print("_____${verificationId}");
        ref.read(authControllerProvider).verifyOtp(context, verificationId, Otp);
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        title:Text("Verify your phone number"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              const SizedBox(
                height: 20,
              ),
            const Text("We have sent a SMS with a code",style: TextStyle(),textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.only(left: 100.0,right:100.0),
              child: SizedBox(
                width: size.width*0.4,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (val){
                    if(val.length==6){
                              verifyOtp(ref, context, val.trim());
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "- - - - - -",
                    hintStyle: TextStyle(
                      fontSize: 30
                    )
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
