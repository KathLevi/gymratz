import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gymratz/widgets/app_bar.dart';

class MapsViewer extends StatefulWidget {
  MapsViewer({Key key, this.address}) : super(key: key);

  final String address;

  @override
  State<StatefulWidget> createState() {
    return MapsViewerState();
  }
}

class MapsViewerState extends State<MapsViewer> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(32.942908, -117.043271);
  // todo: find lat and long for each gym and add marker for the gym

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, profile: false),
      body: SafeArea(
          child: Column(children: <Widget>[
        Expanded(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
          ),
        )
      ])),
    );
  }
}
