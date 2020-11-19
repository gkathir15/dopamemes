import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:dopamemes/providers/AdMobAdProvider.dart';

class AdMobBannerAd extends StatefulWidget {
  @override
  _AdMobBannerAdState createState() => _AdMobBannerAdState();
}

class _AdMobBannerAdState extends State<AdMobBannerAd> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return AdmobBanner(
      key: UniqueKey(),
      adUnitId: AdMobAdProvider.testBannerAd,
      adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {},
    );
  }

  @override
  bool get wantKeepAlive => true;
}
