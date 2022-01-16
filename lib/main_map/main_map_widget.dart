import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_google_map.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MainMapWidget extends StatefulWidget {
  const MainMapWidget({
    Key key,
    this.city,
  }) : super(key: key);

  final CityRecord city;

  @override
  _MainMapWidgetState createState() => _MainMapWidgetState();
}

class _MainMapWidgetState extends State<MainMapWidget> {
  LatLng googleMapsCenter;
  Completer<GoogleMapController> googleMapsController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'LetsLink',
          style: FlutterFlowTheme.bodyText1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FlutterFlowGoogleMap(
          controller: googleMapsController,
          onCameraIdle: (latLng) => googleMapsCenter = latLng,
          initialLocation: googleMapsCenter ??= widget.city.location,
          markers: [
            if (widget.city != null)
              FlutterFlowMarker(
                widget.city.reference.path,
                widget.city.location,
              ),
          ],
          markerColor: GoogleMarkerColor.violet,
          mapType: MapType.normal,
          style: GoogleMapStyle.standard,
          initialZoom: 14,
          allowInteraction: true,
          allowZoom: true,
          showZoomControls: true,
          showLocation: true,
          showCompass: false,
          showMapToolbar: false,
          showTraffic: false,
          centerMapOnMarkerTap: true,
        ),
      ),
    );
  }
}
