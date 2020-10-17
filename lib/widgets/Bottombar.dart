import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              LineAwesomeIcons.film,
            ),
            enableFeedback: true,
            onPressed: () {
              Navigator.pushNamed(context, 'fullVideo');
            },
          ),
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
    );
  }
}