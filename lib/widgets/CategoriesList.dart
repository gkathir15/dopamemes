import 'package:cached_network_image/cached_network_image.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Provider.of<CategoriesProvider>(context, listen: false)
                .setMainCategory(
                    Provider.of<CategoriesProvider>(context, listen: false)
                        .allCategories()[index]);
            Provider.of<PostProvider>(context, listen: false)
                .animateToTopOfList();
            Navigator.of(context).pop();
          },
          child: ListTile(
            leading: ClipOval(
              child: CachedNetworkImage(
                imageUrl: Provider.of<CategoriesProvider>(context)
                    .allCategories()[index]
                    .displayIcon,
                width: 50,
                height: 50,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
            ),
            title: Text(
              Provider.of<CategoriesProvider>(context)
                  .allCategories()[index]
                  .displayName,
              style: GoogleFonts.roboto(fontSize: 20),
            ),
          ),
        );
      },
      itemCount:
          Provider.of<CategoriesProvider>(context).allCategories().length,
    );
  }
}
