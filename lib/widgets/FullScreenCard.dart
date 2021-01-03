import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/exports/modelExports.dart';
import 'package:google_fonts/google_fonts.dart';

class FullScreenCard extends StatelessWidget {
  final Widget postWidget;
  final Posts posts;

  FullScreenCard({Key key, this.postWidget, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          postWidget,
          returnButtonsOnPortrait(context, posts)
        ],

      ),
    );
  }
}

Widget returnButtonsOnPortrait(BuildContext context,Posts posts)
{
  if(MediaQuery.of(context).orientation==Orientation.portrait){
    return Column(children: [
      titleNcategory(posts: posts),
      ShareLike(document: posts,)
    ],);
  }else
    return Container();
}

class titleNcategory extends StatelessWidget {
  const titleNcategory({
    Key key,
    @required this.posts,
  }) : super(key: key);

  final Posts posts;

  @override
  Widget build(BuildContext context) {
    return Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Text(
    posts.caption,
    style: GoogleFonts.roboto(fontSize: 20),
              )),
          Padding(
            padding: EdgeInsets.only(left: 4, right: 4, top: 4),
            child: Text(
              posts.categoryDetails.displayName,
              style: GoogleFonts.roboto(fontSize: 12),
            ),
          ),
        ],
      );
  }
}
