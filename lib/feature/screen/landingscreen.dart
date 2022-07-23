import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:whatsapp_ui/colors.dart';
import '../../common/widgets/custombutton.dart';
import '../../screens/loginscreen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  void navigateToLoginScreen(BuildContext context){
      Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                const SizedBox(
                  height: 50,
                ),
              Text("Welcome to LetsChat !",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,),),
              SizedBox(
                height: MediaQuery.of(context).size.height/9,
              ),
              Lottie.asset('assets/anim/landinganimation.json',repeat: true,height: 250),
              SizedBox(
                height: MediaQuery.of(context).size.height/9,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Read our Privacy Policy Tap "Agree to continue" to accept terms and service',style:const TextStyle(color:greyColor),textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10 ,
              ),
             SizedBox(
            width: MediaQuery.of(context).size.width*0.75,
               child: CustomButton(
                 text: "Agree and Continue",
                 onPresses: ()=>
                   navigateToLoginScreen(context),
               ),
             ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height/14,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
