import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/PagesExport.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:dopamemes/pages/NewPostBottomSheet.dart';
import 'package:dopamemes/providers/PostViewProvider.dart';
import 'package:dopamemes/widgets/PostsList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';



class MainFeedList extends StatelessWidget {
  

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


}


