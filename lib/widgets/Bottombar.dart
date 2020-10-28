import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/jam_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(200.0),
      child: BottomAppBar(
        elevation: 8,
        clipBehavior: Clip.hardEdge,
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                icon: Icon(
                  JamIcons.movie,
                ),
                enableFeedback: true,
                onPressed: () {
                  Navigator.pushNamed(context, 'fullVideo');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(icon: Icon(JamIcons.home), onPressed: () {
                 Provider.of<CategoriesProvider>(context, listen: false)
                .setMainCategory(
                    Categories(sId: "0"));
            Provider.of<PostProvider>(context, listen: false)
                .animateToTopOfList();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
