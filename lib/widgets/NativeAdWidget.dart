import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/providers/AdMobAdProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

class NativeAdWidget extends StatelessWidget {
  const NativeAdWidget({
    Key key,
    @required int count,
    @required NativeAdmobController nativeAdController,
  }) : _count = count, _nativeAdController = nativeAdController, super(key: key);

  final int _count;
  final NativeAdmobController _nativeAdController;

  @override
  Widget build(BuildContext context) {
    return NativeAdmob(
      numberAds:_count ,
      loading: Center(child: CircularProgressIndicator()),
      error: Center(child: CircularProgressIndicator()),
      adUnitID: AdMobAdProvider.dopeBannerAd,
      controller: _nativeAdController,
      type: NativeAdmobType.full,
    );
  }
}