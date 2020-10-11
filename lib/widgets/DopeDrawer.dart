import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class DopeDrawer extends StatelessWidget {
  const DopeDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8,
      child: SafeArea(
        child: Column(
          children: [
            Text(
              "Categories",
              style: GoogleFonts.roboto(fontSize: 25),
            ),
            Expanded(child: CategoriesList()),
            InkWell(
                child: ListTile(
              leading: Icon(
                LineAwesomeIcons.cog,
                size: 30,
              ),
              title: Text(
                "Settings",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed("settings");
              },
            ))
          ],
        ),
      ),
    );
  }
}
