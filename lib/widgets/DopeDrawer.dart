import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:dopamemes/jam_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DopeDrawer extends StatelessWidget {
  const DopeDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8,
      child: Container(
        child: SafeArea(
          child: Column(
            children: [
              Text(
                "Categories",
                style: GoogleFonts.roboto(fontSize: 30,fontWeight: FontWeight.w700),
              ),
              Expanded(child: CategoriesList()),
              InkWell(
                  child: ListTile(
                leading: Icon(
                  JamIcons.cog_f,
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
      ),
    );
  }
}
