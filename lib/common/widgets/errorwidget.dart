import 'package:flutter/material.dart';


class ErrorScreenWidget extends StatelessWidget {
   String error;
   ErrorScreenWidget({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(this.error)),
    );
  }
}
