import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/style.dart';

class GoogleMapScreen extends StatefulWidget {
  final double startLat;
  final double startLng;
  final double endLat;
  final double endLng;

  const GoogleMapScreen({
    super.key,
    required this.startLat,
    required this.startLng,
    required this.endLat,
    required this.endLng,
  });

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    CameraPosition initialPosition = CameraPosition(
      target: LatLng(widget.startLat, widget.startLng),
      zoom: 15.0,
    );

    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('start'),
        position: LatLng(widget.startLat, widget.startLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: 'Start Point'),
      ),
      Marker(
        markerId: const MarkerId('end'),
        position: LatLng(widget.endLat, widget.endLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'End Point'),
      ),
    };

    Set<Polyline> polylines = {
      Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.blue,
        points: [
          LatLng(widget.startLat, widget.startLng),
          LatLng(widget.endLat, widget.endLng),
        ],
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: initialPosition,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              markers: markers,
              polylines: polylines,
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: backgroundColor),
                child: Center(
                  child: IconButton(
                      onPressed: () async {
                        await launchUrl(Uri.parse(
                            "google.navigation:q=${widget.startLat}, ${widget.startLng}&key=AIzaSyA4VCkitlZE2_DDCIBmmcFzpdsUTmGSOrs"));
                      },
                      icon: const Icon(Icons.navigation_outlined)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
