import 'package:dopamemes/PostType.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 24),
              child: Text("Create a new Post with"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    var file = await FilePicker.getFile(
                        type: FileType.image, allowCompression: true);
                    if (file != null) {
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              NewPostDialog.withPath(
                                  PostType.IMAGE, file.path)));
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(LineAwesomeIcons.image),
                          Text("IMAGE")
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var file = await FilePicker.getFile(
                        type: FileType.video, allowCompression: true);
                    print(file.path);

                    if (file != null) {
                      Navigator.pop(context);
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              NewPostDialog.withPath(
                                  PostType.VIDEO, file.path)));
                      
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(LineAwesomeIcons.film),
                          Text("VIDEO")
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
                          Text("Youtube")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(LineAwesomeIcons.link),
                            Text("Link")
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(LineAwesomeIcons.file_text),
                            Text("Text")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
  void reassemble() {}

  @override
  void dispose() {
    dialogTextController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {}
}
