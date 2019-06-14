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
// todo: find lat and long for each gym

  GoogleMapController controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  static final LatLng center = const LatLng(32.942908, -117.043271);

  void initState() {
    final String markerIdVal = 'Vertical Hold';
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(center.latitude, center.longitude),
      infoWindow: InfoWindow(title: markerIdVal, snippet: ''),
      onTap: () {
        _onMarkerTapped(markerId);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, profile: false),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: 15.0,
                ),
                markers: Set<Marker>.of(markers.values),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
