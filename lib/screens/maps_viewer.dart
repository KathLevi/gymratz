import 'package:flutter/material.dart';
import 'package:gymratz/widgets/app_bar.dart';
//import 'package:url_launcher/url_launcher.dart';

class MapsViewer extends StatefulWidget {
  MapsViewer({Key key, this.address}) : super(key: key);

  final String address;

  @override
  State<StatefulWidget> createState() {
    return MapsViewerState();
  }
}

class MapsViewerState extends State<MapsViewer> {
//  _launchMaps() async {
//    String googleUrl =
//        'comgooglemaps://?center=${trip.origLocationObj.lat},${trip.origLocationObj.lon}';
//    String appleUrl =
//        'https://maps.apple.com/?sll=${trip.origLocationObj.lat},${trip.origLocationObj.lon}';
//    if (await canLaunch("comgooglemaps://")) {
//      print('launching com googleUrl');
//      await launch(googleUrl);
//    } else if (await canLaunch(appleUrl)) {
//      print('launching apple url');
//      await launch(appleUrl);
//    } else {
//      throw 'Could not launch url';
//    }
//  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, profile: false),
      body: SafeArea(child: Container()),
    );
  }
}
