import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:dopamemes/providers/AccountsProvider.dart';
import 'package:dopamemes/providers/Conts.dart';
import 'package:dopamemes/providers/PostViewProvider.dart';
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

   return  FutureBuilder(future:Provider.of<PostProvider>(context).postsData,builder: (BuildContext context,AsyncSnapshot<List<Posts>> snapshot){

      if(snapshot.hasData) {
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
                },isDismissible: true,isScrollControlled: true);
              },
              child: Icon(Icons.add),
            ),
            body: Container(
              child: PostsList(),
            ),
        drawer: Drawer(elevation: 8,
          child: ListView.builder(itemBuilder: (BuildContext context, int index)
        {
          return ListTile(leading: CachedNetworkImage(imageUrl:Provider.of<CategoriesProvider>(context).allCategories()[index].displayIcon,width: 50,height: 40,fit: BoxFit.scaleDown,),
          title: Text(Provider.of<CategoriesProvider>(context).allCategories()[index].displayName),);
        },itemCount: Provider.of<CategoriesProvider>(context).allCategories().length,)

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
      Provider.of<PostProvider>(context).fetchPosts();
      Provider.of<CategoriesProvider>(context).fetchCategories();
      Provider.of<AccountsProvider>(context).loggedResponse();
      Admob.initialize("ca-app-pub-6011809596899441~9949339806"
      );
      Firebase.initializeApp();
      //FirebaseAdMob.instance.initialize(appId: "ca-app-pub-6011809596899441~9949339806");
    }
  }




}