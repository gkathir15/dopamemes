import 'package:admob_flutter/admob_flutter.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/PagesExport.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:dopamemes/providers/AccountsProvider.dart';
import 'package:dopamemes/providers/PostViewProvider.dart';
import 'package:dopamemes/pages/NewPostBottomSheet.dart';
import 'package:dopamemes/widgets/PostsList.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
    return FutureBuilder(
      future: Provider.of<PostProvider>(context).getFilteredList(Provider.of<CategoriesProvider>(context).mainCategory),
      builder: (BuildContext context, AsyncSnapshot<List<Posts>> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text(
                "Dopamemes",
                style: GoogleFonts.bangers(
                    fontSize: 50,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w300),
              ),
              actions: [
                InkWell(
                  child: CircleAvatar(
                    child: Icon(LineAwesomeIcons.user),
                  ),
                  onTap: () {
                    // Navigator.pushNamed(context, 'login');

                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return GoogleSigninPage();
                        },
                        isDismissible: true,
                        isScrollControlled: false);
                  },
                )
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(8), right: Radius.circular(8))),
              centerTitle: true,
              elevation: 0,
            ),
            bottomNavigationBar: BottomBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return NewPostBottomSheet();
                    },
                    isDismissible: true,
                    isScrollControlled: true);
              },
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            body: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Builder(
                    builder: (bContext) {
                      if (Provider.of<NewPostProvider>(bContext).status() ==
                          UploadStatus.UPDATED) {
                        Provider.of<PostProvider>(context, listen: false)
                            .addNewUploadedPost(Provider.of<NewPostProvider>(
                                    bContext,
                                    listen: false)
                                .pollQueue());
                      }

                      if (Provider.of<NewPostProvider>(bContext).status() ==
                          UploadStatus.UPLOADING) {
                        return SafeArea(child: LinearProgressIndicator());
                      } else
                        return Container(
                          height: 0,
                        );
                    },
                  ),
                  Expanded(child: PostsList()),
                ],
              ),
            ),
            drawer: DopeDrawer(),
          );
        } else {
          return Splash();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDep");
    if (!isReqSent) {
      isReqSent = true;
      //  Provider.of<AccountsProvider>(context).getCheckIfLoggedIn();
      Firebase.initializeApp();
      
      Provider.of<PostProvider>(context).fetchPosts();
      Provider.of<CategoriesProvider>(context).fetchCategories();
      Provider.of<AccountsProvider>(context).loggedResponse();
      Admob.initialize("ca-app-pub-6011809596899441~9949339806");
    }
  }
}


