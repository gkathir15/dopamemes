import 'package:flutter/material.dart';
import 'package:dopamemes/exports/modelExports.dart';
import 'package:google_fonts/google_fonts.dart';

class FullScreenCard extends StatelessWidget {
  final Widget postWidget;
  final Posts posts;

  FullScreenCard({Key key, this.postWidget, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        postWidget,
        Padding(
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Text(
              posts.caption,
              style: GoogleFonts.roboto(fontSize: 5.0),
            )),
        Padding(
          padding: EdgeInsets.only(left: 4, right: 4),
          child: Text(
            posts.categoryDetails.displayName,
            style: GoogleFonts.roboto(fontSize: 3.0),
          ),
        )
      ],
    );
  }
}
