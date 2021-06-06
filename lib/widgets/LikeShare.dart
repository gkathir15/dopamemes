import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/PagesExport.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/jam_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ShareLike extends StatefulWidget {
  ShareLike({
    Key key,
    @required Posts document,
  })  : _document = document,
        super(key: key);

  final Posts _document;

  @override
  _ShareLikeState createState() => _ShareLikeState();
}

class _ShareLikeState extends State<ShareLike> {
  ValueNotifier<bool> isLiked;

  @override
  Widget build(BuildContext context) {
    isLiked = ValueNotifier(widget._document.is_liked);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                if (Provider.of<AccountsProvider>(context, listen: false)
                    .getUserExtras()
                    .isLoggedIn)
                  isLiked.value = !isLiked.value;
                else {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return GoogleSigninPage();
                      },
                      isDismissible: true,
                      isScrollControlled: false);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ValueListenableBuilder<bool>(
                  builder: (_, bool, __) {
                    return bool
                        ? Icon(
                            JamIcons.arrow_circle_up_f,
                            color: Colors.redAccent,
                            size: 30,
                          )
                        : Icon(
                            JamIcons.arrow_circle_up,
                            size: 30,
                          );
                  },
                  valueListenable: isLiked,
                ),
              ),
            ),
            Text("${widget._document.likes_count} Up Votes")
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Share.share(
                      "Check out this post form Dopamemes www.Dopamemes.live/${widget._document.sId}",
                      subject: "Share Via");
                },
                child: Icon(
                  JamIcons.share,
                  size: 30,
                ),
              ),
              Text(
                "Share",
                style: GoogleFonts.roboto(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
