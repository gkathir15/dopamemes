import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:flutter/cupertino.dart';
import 'package:dopamemes/exports/PagesExport.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesFullScreenDialog extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Stack(
          children: [Align(
            alignment: Alignment.center,
            child: ListView.separated(itemBuilder: (BuildContext context, int index)
            {
              return InkWell(child: Text(Provider.of<CategoriesProvider>(context,listen: false).getAllCategories()[index].name,textAlign: TextAlign.center,style: TextStyle(fontSize: 25,),),onTap: (){
                Navigator.pop(context);
                Provider.of<CategoriesProvider>(context).setNewPostSelected(index);

              },);
            },itemCount:Provider.of<CategoriesProvider>(context).getAllCategories().length, separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),),
          ),
            Align(alignment: Alignment.bottomCenter,
            child:

            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ClipOval(
                child: Material(
                  elevation: 22,
                  shadowColor: Colors.grey,
                  child: InkWell(
                    child: SizedBox(width: 56, height: 56, child: Icon(Icons.close)),
                    onTap:  ()=>Navigator.pop(context),
                  ),
                ),
              ),
            )


            )
          ],
        ),
      ),
    );
  }
  
}