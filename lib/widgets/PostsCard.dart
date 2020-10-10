import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class PostsCard extends StatefulWidget {
  final Posts _document;
  final Widget _widget;

  PostsCard(this._document, this._widget);

  @override
  State<StatefulWidget> createState() {
    return PostsCardState(_document, _widget);
  }
}

class PostsCardState extends State<PostsCard> {
  Posts _document;
  Widget _widget;

  var cardRadius =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0));

  PostsCardState(this._document, this._widget);
  @override
  Widget build(BuildContext context) {
    if (_document.fileUrl == null) _widget = Container();

    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Card(
            child: InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _widget, //The content widget..

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      _document.caption,
                      style: GoogleFonts.roboto(fontSize:20,fontWeight: FontWeight.bold),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 2.0, bottom: 4.0),
                                child: Text(_document.categoryDetails.displayName,
                                    style: GoogleFonts.roboto()),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  timeAgo.format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          (_document.createdAt * 1000).toInt())),
                                  style: GoogleFonts.roboto(),
                                  textScaleFactor: 0.6,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 2, left: 2, top: 2, bottom: 2),
                          child: Icon(LineAwesomeIcons.share,size: 20,),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
