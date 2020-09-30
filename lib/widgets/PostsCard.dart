import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class PostsCard extends StatefulWidget {
  Posts _document;
  Widget _widget;

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
      padding: const EdgeInsets.only(left: 6, right: 6, top: 3),
      child: InkWell(
        child: Card(
          shadowColor: Theme.of(context).cardTheme.shadowColor,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Card(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CachedNetworkImage(
                          imageUrl: _document.ownerDetails.imageUrl != null
                              ? _document.ownerDetails.imageUrl
                              : "https://via.placeholder.com/150"),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  Text(_document.ownerDetails.displayName)
                ],
              ),
              Text(_document.categoryDetails.displayName),
              _widget,
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: Text(
                  _document.caption,
                  style: GoogleFonts.nunito(),
                  textScaleFactor: 1.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: Text(
                  timeAgo.format(DateTime.fromMillisecondsSinceEpoch(
                      (_document.createdAt * 1000).toInt())),
                  style: GoogleFonts.nunito(),
                  textScaleFactor: 0.6,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    child: Card(
                      shape: cardRadius,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8, left: 8, top: 2, bottom: 2),
                        child: Icon(LineAwesomeIcons.send_o),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
