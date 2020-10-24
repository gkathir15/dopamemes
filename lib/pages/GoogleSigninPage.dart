import 'package:cached_network_image/cached_network_image.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:provider/provider.dart';

class GoogleSigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<DopeUser> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data.toJson().toString());

          return Center(
              child: ListView(
            children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: CachedNetworkImage(
                imageUrl: snapshot.data.imageUrl,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(snapshot.data.displayName),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(snapshot.data.email),
          ),
             
            ],
          ));
        } else {
          return Center(
            child: SizedBox(
              height: 50,
              width: 200,
                            child: SignInButton(
                Buttons.Google,
                text: "Continue with Google",
                onPressed: () {
                  Provider.of<AccountsProvider>(context, listen: false)
                      .doGogleAuth();
                },
              ),
            ),
          );
        }
      },
      future: Provider.of<AccountsProvider>(context).getUserFuture(),
    ));
  }
}
