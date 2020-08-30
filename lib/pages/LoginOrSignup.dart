// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/button_view.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:meme/model/UserLoginData.dart';
// import 'package:meme/providers/AccountsProvider.dart';
// import 'package:meme/utils.dart';
// import 'package:meme/widgets/StaggeredMemeList.dart';
// import 'package:provider/provider.dart';
//
// class LoginOrSignup extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return LoginPageState();
//   }
// }
//
// class LoginPageState extends State<LoginOrSignup> {
//   TextEditingController _emailController;
//   TextEditingController _userNameController;
//   TextEditingController _passwordController;
//
//   bool isEditable = false;
//
//   @override
//   void initState() {
//     _emailController = TextEditingController();
//     _userNameController = TextEditingController();
//     _passwordController = TextEditingController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           child:
//           FutureBuilder(builder:(BuildContext context,AsyncSnapshot<UserLoginData> snapshot){
//
//
//             if(snapshot.hasData)
//               {
//                 //
//                return Center(
//
//                  child:Row(
//                    children: [
//                      Stack(children: [
//                        Align(alignment: Alignment.center,child: CircleAvatar(child:
//                        CachedNetworkImage(imageUrl: "https://lh4.googleusercontent.com/-QBXQZfDdlcc/AAAAAAAAAAI/AAAAAAAAAAA/avH5wkKeovw/W96-H96/photo.jpg",),),),
//                        Align(alignment: Alignment.bottomLeft,child:Icon(Icons.edit),)
//                      ],),
//
//                      Card(
//                        child: Column(
//                          children: <Widget>[
//                            Padding(
//                              padding: const EdgeInsets.all(12.0),
//                              child: Text(
//                                "Welcome",
//                                style: GoogleFonts.nunito(),
//                                textScaleFactor: 3,
//                              ),
//                            ),
//                            Container(
//                              child: Card(
//                                child: Column(
//                                  children: <Widget>[
//
//                                    Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: TextField(
//                                        focusNode: AlwaysDisabledFocusNode(isEditable),
//                                          controller: _userNameController,
//                                          decoration: InputDecoration(
//                                            border: OutlineInputBorder(),
//                                            labelText: 'User Id',
//                                            errorText:
//                                            Provider.of<AccountsProvider>(context)
//                                                .isUseNameValidated
//                                                ? "enter distinctive userId"
//                                                : null,
//                                          )),
//                                    ),
//                                    Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: TextField(
//                                          focusNode: AlwaysDisabledFocusNode(isEditable),
//                                          controller: _emailController,
//                                          decoration: InputDecoration(
//                                            border: OutlineInputBorder(),
//                                            labelText: 'Email Id',
//                                            errorText:
//                                            Provider.of<AccountsProvider>(context)
//                                                .isPasswrordValidated
//                                                ? "enter proper Email"
//                                                : null,
//                                          )),
//                                    ),
//
//                                    Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child:  FlatButton(child: Text("Continue"),onPressed: (){
//                                          Navigator.pushNamed(context, "/");
//                                        },)
//                                      ),
//
//                                  ],
//                                ),
//                              ),
//                            )
//                          ],
//                        ),
//                      ),
//
//
//
//
//                    ],
//                  )
//
//                );
//               }else
//                 {
//                   return  Center(
//                     child:
//
//                     Card(
//                       child: Column(
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Text(
//                               "Sign In",
//                               style: GoogleFonts.nunito(),
//                               textScaleFactor: 3,
//                             ),
//                           ),
//                           Container(
//                             child: Card(
//                               child: Column(
//                                 children: <Widget>[
//
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: TextField(
//                                         controller: _userNameController,
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(),
//                                           labelText: 'User Id',
//                                           errorText:
//                                           Provider.of<AccountsProvider>(context)
//                                               .isUseNameValidated
//                                               ? "enter distinctive userId"
//                                               : null,
//                                         )),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: TextField(
//                                         controller: _emailController,
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(),
//                                           labelText: 'Email Id',
//                                           errorText:
//                                           Provider.of<AccountsProvider>(context)
//                                               .isPasswrordValidated
//                                               ? "enter proper Email"
//                                               : null,
//                                         )),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: TextField(
//                                         obscureText: true,
//                                         controller: _passwordController,
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(),
//                                           labelText: 'Password',
//                                           errorText:
//                                           Provider.of<AccountsProvider>(context)
//                                               .isPasswrordValidated
//                                               ? "enter proper password"
//                                               : null,
//                                         )),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: MaterialButton(
//                                       elevation: 8,
//                                       animationDuration: Duration(seconds: 1),
//                                       onPressed: () {
//                                         if (_emailController.text.isNotEmpty) {
//                                           if (_passwordController.text.length > 5) {
//                                             if(_userNameController.text.isNotEmpty)
//                                             Provider.of<AccountsProvider>(context,
//                                                 listen: false)
//                                                 .loginWith(_emailController.text,
//                                                 _passwordController.text,_userNameController.text);
//                                           } else {
//                                             Provider.of<AccountsProvider>(context,
//                                                 listen: false)
//                                                 .showPasswordValidator();
//                                           }
//                                         } else {
//                                           Provider.of<AccountsProvider>(context,
//                                               listen: false)
//                                               .showEmailValidator();
//                                         }
//                                       },
//                                       child: Text("Signup"
//                                           ""
//                                           ""),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: SignInButton(
//                                       Buttons.Google,
//                                       onPressed: () {
//
//                                       },
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//           } ,
//
//
//           ),
//
//
//
//
//
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _userNameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }
//
// class AlwaysDisabledFocusNode extends FocusNode {
//   bool state;
//
//   AlwaysDisabledFocusNode(this.state);
//
//   @override
//   bool get hasFocus => this.state;
// }
