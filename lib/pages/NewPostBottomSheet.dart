import 'package:dopamemes/PostType.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:dopamemes/exports/PagesExport.dart';

class NewPostBottomSheet extends StatefulWidget {
  @override
  State createState() {
    return NewPostBottomSheetState();
  }
}

class NewPostBottomSheetState extends State<NewPostBottomSheet> {
  TextEditingController dialogTextController;
  FocusNode focusNode;
  bool isYtClicked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 24),
              child: Text("Create a new Post with",style: GoogleFonts.roboto(),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    var resp = await FilePicker.platform.pickFiles(type: FileType.image,allowCompression: true,allowMultiple: false);
                    if (resp != null) {
                      Navigator.pop(context);
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              NewPostDialog.withPath(
                                  PostType.IMAGE, resp.files.single.path)));
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(LineAwesomeIcons.file_image_o),
                          Text("IMAGE", style: GoogleFonts.roboto())
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var resp = await FilePicker.platform.pickFiles(type: FileType.video,allowMultiple: false);
                    print(resp.files.single.path);

                    if (resp != null) {
                      Navigator.pop(context);
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              NewPostDialog.withPath(
                                  PostType.VIDEO, resp.files.single.path)));
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(LineAwesomeIcons.file_video_o),
                          Text(
                            "VIDEO",
                            style: GoogleFonts.roboto(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) =>
                            NewPostDialog(PostType.YOUTUBE)));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(LineAwesomeIcons.youtube),
                          Text("YOUTUBE", style: GoogleFonts.roboto())
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       InkWell(
            //         onTap: () => Navigator.pop(context),
            //         child: Card(
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Row(
            //               children: <Widget>[
            //                 Icon(LineAwesomeIcons.link),
            //                 Text("Link")
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       InkWell(
            //         onTap: () => Navigator.pop(context),
            //         child: Card(
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Row(
            //               children: <Widget>[
            //                 Icon(LineAwesomeIcons.file_text),
            //                 Text("Text")
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    dialogTextController = TextEditingController();
    focusNode = FocusNode();

    super.initState();
  }


  @override
  void dispose() {
    dialogTextController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
