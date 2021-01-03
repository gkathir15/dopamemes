import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/PagesExport.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:dopamemes/jam_icons_icons.dart';
import 'package:dopamemes/pages/NewPostBottomSheet.dart';
import 'package:dopamemes/providers/PostProvider.dart';
import 'package:dopamemes/widgets/PostsList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dopamemes/utils.dart';

class MainFeedList extends StatefulWidget {
  @override
  _MainFeedListState createState() => _MainFeedListState();
}

class _MainFeedListState extends State<MainFeedList> {
  List<Widget> bottomSheetWidgets = [
    MainListWithNewPostLoader(),
    VideoHorizontalScroller()
  ];
  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(_scaffoldKey, context),
      bottomNavigationBar: BottomBar(),
      drawer: DopeDrawer(),
      floatingActionButton: buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: WillPopScope(
        child: bottomSheetWidgets[
            Provider.of<PostProvider>(context).selectedBottomSheet],
        onWillPop: _onBackPressed,
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return Provider.of<PostProvider>(context, listen: false)
                .selectedBottomSheet ==
            0
        ? FloatingActionButton(
            onPressed: () {
              if(Provider.of<AccountsProvider>(context, listen: false).getUserExtras().isLoggedIn) {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return NewPostBottomSheet();
                    },
                    isDismissible: true,
                    isScrollControlled: true);
              }else{
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return GoogleSigninPage();
                    },
                    isDismissible: true,
                    isScrollControlled: false);
              }
            },
            child: Icon(Icons.add),
          )
        : null;
  }

  PreferredSizeWidget buildAppBar(
      GlobalKey<ScaffoldState> _scaffoldKey, BuildContext context) {
    return Provider.of<PostProvider>(context, listen: false)
                .selectedBottomSheet ==
            0
        ? AppBar(
            leading: InkWell(
              child: Icon(
                JamIcons.menu,
                size: 35,
              ),
              onTap: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            title: Text(
              "Dopamemes",
              style: GoogleFonts.bangers(
                  fontSize: 40, letterSpacing: 3, fontWeight: FontWeight.w300),
            ),
            actions: [
              InkWell(
                child: CircleAvatar(
                  child: Icon(JamIcons.user_circle),
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
          )
        : PreferredSize(
            preferredSize: Size(
              0,
              0,
            ),
            child: Container(),
          );
  }

  @override
  void initState() {
    setOrientationPortrait();
    super.initState();
  }

  Future<bool> _onBackPressed() async {
    if (Provider.of<PostProvider>(context, listen: false).selectedBottomSheet == 1) {
      Provider.of<PostProvider>(context, listen: false).selectedBottomSheet = 0;
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
