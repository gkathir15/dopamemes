import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/jam_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

class ShareLike extends StatelessWidget {
  ShareLike({
    Key key,
    @required Posts document,
  }) : _document = document, super(key: key);

  ValueNotifier<bool> isLiked;
  final Posts _document;

  @override
  Widget build(BuildContext context) {
    isLiked = ValueNotifier(_document.is_liked);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                isLiked.value = !isLiked.value;
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ValueListenableBuilder<bool>(
                  builder: (_, bool, __) {
                    return bool ? Icon(
                      JamIcons.arrow_circle_up_f,
                      color: Colors.redAccent,
                      size: 30,
                    ) : Icon(
                      JamIcons.arrow_circle_up,
                      size: 30,
                    );
                  },
                  valueListenable: isLiked,
                ),
              ),
            ),
            Text("${_document.likes_count} Up Votes")
          ],

        ),
        Padding(
          padding: EdgeInsets.only(
              left: 10, right: 10),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Share.share(
                      "Check out this post form Dopamemes www.Dopamemes.live/${_document
                          .sId}", subject: "Share Via");
                },
                child: Icon(
                  JamIcons.share,
                  size: 30,
                ),
              ),
              Text("Share", style: GoogleFonts.roboto(),)
            ],
          ),
        ),
      ],
    );
  }
}