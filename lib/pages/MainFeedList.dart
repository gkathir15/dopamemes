import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:dopamemes/model/UserLoginData.dart';
import 'package:dopamemes/providers/AccountsProvider.dart';
import 'package:dopamemes/providers/AppwriteClientProvider.dart';
import 'package:dopamemes/providers/PostRespViewProvider.dart';
import 'package:dopamemes/pages/NewPostBottomSheet.dart';
import 'package:dopamemes/widgets/PostsList.dart';
import 'package:provider/provider.dart';

class MainFeedList extends StatefulWidget {
  MainFeedList({Key key}) : super(key: key);

  @override
  _MainFeedListState createState() {
    return _MainFeedListState();
  }
}

class _MainFeedListState extends State<MainFeedList> {
  bool isReqSent = false;

  @override
  Widget build(BuildContext context) {

   return  FutureBuilder(future:Provider.of<AccountsProvider>(context).isLoggedResponse,builder: (BuildContext context,AsyncSnapshot<UserLoginData> snapshot){

      if(snapshot.connectionState==ConnectionState.none) {
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text("Dopamemes"),
              actions: [
                InkWell(child: CircleAvatar(child: Icon(LineAwesomeIcons.user),),onTap: (){
                  Navigator.pushNamed(context, 'login');
                },)
              ],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(8),right: Radius.circular(8))),
              centerTitle: true,

              elevation: 0,

            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {

                showModalBottomSheet<void>(context: context,builder: (BuildContext context) {
                  return NewPostBottomSheet();
                },);
              },
              child: Icon(Icons.add),
            ),
            body: Container(
              child: PostsList(),
            ),
        drawer: Drawer(elevation: 8,
        //   child: ListView.builder(itemBuilder: (BuildContext context, int index)
        // {
        //   return ListTile(leading: CachedNetworkImage(),
        //   title: Text("t"),);
        // })
            child: Container()

          ,),);
      }
      else{

        return Scaffold(
//          body :  Stack(
//              children:[
//
//              Align(
//                alignment: Alignment.center,
//                child: Container(child: StaggeredMemeList(),
//                  height: MediaQuery.of(context).size.height,
//                width:MediaQuery.of(context).size.width,
//                ),
//              ),
//
//              ]
//            ),
        body: Container(
          height: MediaQuery.of(context).size.height,
                width:MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              "Dopamemes",
              style: GoogleFonts.aclonica(),
              textScaleFactor:1,
            ),
          ),

        ),
            
          
        );

      }

    },);


  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("didChangeDep");
    if (!isReqSent) {
      isReqSent = true;
    //  Provider.of<AccountsProvider>(context).getCheckIfLoggedIn();
      Provider.of<PostRespViewProvider>(context).getPostsReq();
    }
  }


}