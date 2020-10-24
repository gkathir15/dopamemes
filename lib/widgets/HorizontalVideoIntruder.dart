import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:flutter/rendering.dart';

class HorizontalVideoIntruder extends StatefulWidget {
  final List<Posts> postsList;

  const HorizontalVideoIntruder({Key key, this.postsList}) : super(key: key);
  @override
  _HorizontalVideoIntruderState createState() =>
      _HorizontalVideoIntruderState();
}

class _HorizontalVideoIntruderState extends State<HorizontalVideoIntruder> {
  
  @override
  Widget build(BuildContext context) {
    return 
    Container(
     
    
      height: 450,
      width: 800,
      child: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
          child: SizedBox(child: ClipRRect(child: VideoFullScreenPlayer(url: widget.postsList[index].fileUrl,),borderRadius: BorderRadius.circular(5.0),),
          width: 760/2.5,
          height: 430,
          ),
        );
      },itemCount:widget.postsList.length ,
      scrollDirection: Axis.horizontal,
      ),
    );
  }
}
