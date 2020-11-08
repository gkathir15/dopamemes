import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class WaveloadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child:Shimmer.fromColors(child: Image.memory(kTransparentImage), baseColor: Theme.of(context).backgroundColor,
       highlightColor: Colors.white10,direction: ShimmerDirection.btt,enabled: true,)    );
  }
}
