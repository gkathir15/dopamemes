import 'package:dopamemes/PostType.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:dopamemes/exports/PagesExport.dart';

class NewPostBottomSheet extends StatefulWidget{


  @override
  State createState() {
    return NewPostBottomSheetState();
  }
}


class NewPostBottomSheetState extends State<NewPostBottomSheet>
{
  TextEditingController dialogTextController;
  FocusNode focusNode;
  bool isYtClicked = false;
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8,top: 12,bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 24),
              child: Text("Create a new Post with"),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) =>
                          NewPostDialog(PostType.IMAGE)));},
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
                  Navigator.pop(context);
                  var file = await FilePicker.getFile(type: FileType.video,allowCompression: true);
                  print(file.path);
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
                onTap: (){
                  Navigator.pop(context);
                  Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) =>
                          NewPostDialog(
                              PostType.YOUTUBE)));
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



            ],),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              ],),
            ),
          linkEditor(),
          ],
        ),
      ),
    );

  }


  Widget linkEditor()
  {
    if(isYtClicked) {
      return Row(children: [
        TextField(focusNode: focusNode, decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'link',
        ), controller: dialogTextController,),
        RaisedButton(onPressed: () {
          Navigator.pop(context);
          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  NewPostDialog.withPath(
                      PostType.YOUTUBE, dialogTextController.text)));
        },
          child: Text("Next"),)
      ],);
    }else {
     return Container();
    }
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

}