import 'package:cached_network_image/cached_network_image.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:provider/provider.dart';

class GooleSigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<DopeUser> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data.toJson().toString());

          return Container(
              child: Center(
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
                padding: const EdgeInsets.all(8.0),
                child: Text(snapshot.data.displayName),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(snapshot.data.email),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ClipOval(
                  child: Material(
                    borderRadius: BorderRadius.circular(4),
                    elevation: 22,
                    shadowColor: Colors.grey,
                    child: InkWell(
                      child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                ),
              )
            ],
          )));
        } else {
          return Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 50, 0, 8),
                child: Center(
                    child: Text(
                  "Dopamemes",
                  textScaleFactor: 4,
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text("Fresh Dopamine to you brain"),
              ),
              Padding(
                padding: const EdgeInsets.all(9),
                child: SignInButton(
                  Buttons.Google,
                  text: "Continue with Google",
                  onPressed: () {
                    Provider.of<AccountsProvider>(context, listen: false)
                        .doGogleAuth();
                  },
                ),
              ),
            ],
          ));
        }
      },
      future: Provider.of<AccountsProvider>(context).dopeuserResponse,
    ));
  }
}
