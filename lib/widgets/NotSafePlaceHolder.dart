import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotSafePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sensitive Content",
            style: GoogleFonts.roboto(fontSize: 30),
          ),
          Text(
            "The post may contain sensitive informaton,\nTap to View.",
            style: GoogleFonts.roboto(),
            textAlign: TextAlign.center,
          )
        ],
      )),
    );
  }
}
