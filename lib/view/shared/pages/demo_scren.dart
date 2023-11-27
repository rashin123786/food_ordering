import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:food_ordering/utils/constants.dart';
import 'package:food_ordering/utils/style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen(
      {super.key,
      required this.startLat,
      required this.startLong,
      required this.endLat,
      required this.endLong});

  final double startLat, startLong, endLat, endLong;

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  // static const LatLng sourceLocation = LatLng(11.2588, 75.7804);
  // static const LatLng destinationLocation = LatLng(11.1895, 75.8698);
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  Future<void> _camerToPosition(LatLng pos) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition newCamerPostion = CameraPosition(target: pos, zoom: 15);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCamerPostion));
  }

  void getCurrentLoaction() async {
    Location location = Location();
    setState(() {});

    location.getLocation().then((value) {
      currentLocation = value;
    });

    // GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((event) {
      currentLocation = event;

      _camerToPosition(LatLng(event.latitude!, event.longitude!));
      setState(() {});
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(widget.startLat, widget.startLong),
      PointLatLng(widget.endLat, widget.endLong),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (element) => polylineCoordinates
            .add(LatLng(element.latitude, element.longitude)),
      );
      setState(() {});
    } else {
      print("error message: ${result.errorMessage}");
    }
  }

  @override
  void initState() {
    getCurrentLoaction();
    getPolyPoints();
    print(currentLocation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.startLat, widget.startLong),
                zoom: 13.5,
              ),
              polylines: {
                Polyline(
                    polylineId: PolylineId("route"),
                    points: polylineCoordinates,
                    color: backgroundColor,
                    width: 4)
              },
              markers: {
                Marker(
                    markerId: MarkerId("currentLocation"),
                    position: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!)),
                Marker(
                    markerId: MarkerId("destination"),
                    position: LatLng(widget.endLat, widget.endLong))
              },
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
            ),
    );
  }
}
