import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/PagesExport.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:dopamemes/jam_icons_icons.dart';
import 'package:dopamemes/pages/NewPostBottomSheet.dart';
import 'package:dopamemes/providers/PostViewProvider.dart';
import 'package:dopamemes/widgets/PostsList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:dopamemes/utils.dart';

class MainFeedList extends StatefulWidget {
  @override
  _MainFeedListState createState() => _MainFeedListState();
}

class _MainFeedListState extends State<MainFeedList> {
  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = GlobalKey<ScaffoldState>();
    return FutureBuilder(
      future: Provider.of<PostProvider>(context).getList(),
      builder: (BuildContext context, AsyncSnapshot<List<Posts>> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
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
                    fontSize: 40,
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
            drawer: DopeDrawer(),
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
                FloatingActionButtonLocation.centerDocked,
            body: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ValueListenableBuilder<UploadStatus>(builder: (_context,bool,_){
                    return bool == UploadStatus.UPLOADING?LinearProgressIndicator():Container(height: 0,);
                  },
                  valueListenable: Provider.of<NewPostProvider>(context).pollQueue(),),
                  Expanded(child: PostsList()),
                ],
              ),
            ),
          );
        } else {
          return Splash();
        }
      },
    );
  }

  @override
  void initState() {
    setOrientationPortrait();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
