import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class GooleSigninPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4,60, 4, 8),
              child: Center(child: Text("Dopamemes",textScaleFactor: 4,)),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text("Fresh Dopamine to you brain"),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 60, 8, 8),
              child: SignInButton(
                Buttons.Google,
                text: "Continue with Google",
                onPressed: () {

                },
              ),
            )
          ],
        ),
      ),
    );
  }

}