import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredMemeList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StaggeredMemeListState();
  }



}

class StaggeredMemeListState extends State<StaggeredMemeList>
{
  ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
  return  StaggeredGridView.countBuilder(controller: scrollController,
    crossAxisCount: 4,
    itemCount:double.maxFinite.round(),
    itemBuilder: (BuildContext context, int index) {
      return Image.asset("assets/bgListImg/image${(index%27)+1}.jpg");
    },

    staggeredTileBuilder: (int index) =>
    new StaggeredTile.fit(2),
    mainAxisSpacing: 4.0,
    crossAxisSpacing: 4.0,
  );
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
    scrollController.animateTo(100, duration: Duration(milliseconds: 1), curve: Curves.easeInOutBack);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  bool get mounted {
    scrollController.animateTo(100, duration: Duration(milliseconds: 1), curve: Curves.easeInOutBack);

    return false;
  }






  @override
  void initState() {
    super.initState();

    scrollController = ScrollController(initialScrollOffset: 2.0,keepScrollOffset: true);
    scrollController.addListener(() {
      Timer(Duration(milliseconds: 16), (){
        scrollController.animateTo(scrollController.offset+100, duration: Duration(milliseconds: 1), curve: Curves.easeInOutBack);
      });
    });



  }

}