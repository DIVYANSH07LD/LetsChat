import 'package:flutter/material.dart';
import 'package:whatsapp_ui/screens/loginscreen.dart';
import 'package:whatsapp_ui/screens/mobile_layout_screen.dart';
import 'package:whatsapp_ui/screens/otpscreen.dart';
import 'package:whatsapp_ui/screens/select_contact_screen.dart';
import 'package:whatsapp_ui/screens/user_screen.dart';
import 'common/widgets/errorwidget.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {

  switch(routeSettings.name){
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context)=>const LoginScreen()
      );
      case OtpScreen.routeName:
        final verificationId = routeSettings.arguments;
      return MaterialPageRoute(builder: (context)=> OtpScreen(
        verificationId: verificationId.toString(),
      ));
      case UserScreen.routeName:
      return MaterialPageRoute(builder: (context)=> UserScreen());
      case MobileLayoutScreen.routeName:
      return MaterialPageRoute(builder: (context)=> MobileLayoutScreen());
      case SelectContact.routeName:
      return MaterialPageRoute(builder: (context)=> SelectContact());
    default:
      return MaterialPageRoute(builder: (context)=> Scaffold(
        body: ErrorScreenWidget(error:"This page doesn\'t work"),
      ));
  }
}