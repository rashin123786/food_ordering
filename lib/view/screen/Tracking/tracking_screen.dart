import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:food_ordering/core/model/home_model.dart';
import 'package:food_ordering/utils/constants.dart';
import 'package:food_ordering/utils/style.dart';
import 'package:food_ordering/view/screen/update%20Status/update_status.dart';
import 'package:food_ordering/view/shared/pages/demo_scren.dart';

import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../shared/widget/stepper_widget.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({
    super.key,
    required this.startLat,
    required this.startLng,
    required this.endLat,
    required this.endLng,
    required this.order,
    required this.placemark,
    required this.orderId,
  });
  final double startLat;
  final String orderId;
  final double startLng;
  final double endLat;
  final double endLng;
  final Order order;
  final List<Placemark> placemark;

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
        elevation: 0,
        centerTitle: true,
        title: const Text("Tracking"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_horiz)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: InteractiveViewer(
                      child: DemoScreen(
                          endLat: widget.endLat,
                          endLong: widget.endLng,
                          startLat: widget.startLat,
                          startLong: widget.startLng),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DemoScreen(
                                      startLat: widget.startLat,
                                      startLong: widget.startLng,
                                      endLat: widget.endLat,
                                      endLong: widget.endLng)));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => GoogleMapWidget(
                          //           zoom: 10,
                          // startLat: widget.startLat,
                          // startLong: widget.startLng,
                          // endLat: widget.endLat,
                          // endLong: widget.endLng),
                          //     ));
                        },
                        icon: CircleAvatar(
                          backgroundColor: backgroundColor,
                          foregroundColor: Colors.white,
                          child: const Icon(Icons.navigation_outlined),
                        )),
                  )
                ],
              ),
              // Center(
              //   child: SvgPicture.asset("assets/images/Map.svg"),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(190, 237, 190, 1),
                      child: SvgPicture.asset(
                        "assets/images/userprofile.svg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(userDetails!.name!),
                    subtitle: Text(userDetails!.email!),
                    trailing: CircleAvatar(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      child: GestureDetector(
                          onTap: () async {
                            await launchUrl(
                                Uri.parse("tel://${userDetails!.phone}"));
                          },
                          child: const Icon(Icons.phone)),
                    ),
                  ),
                ),
              ),
              StepperWidget(
                firstTile: widget.placemark[0].street!,
                secondTitle:
                    '${widget.order.addressModel!.address} ${widget.order.addressModel!.cityName}',
                firstSubtitle:
                    "${widget.placemark[0].locality!} ${widget.placemark[0].country!}",
                secondSubtitle:
                    "${widget.order.addressModel!.stateName},${widget.order.addressModel!.countryName}",
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateStatusScreen(
                      orderId: widget.order.id.toString(),
                      total: widget.order.items!.totalPrice!,
                      Country: widget.order.addressModel!.countryName!,
                      city: widget.order.addressModel!.cityName!,
                      state: widget.order.addressModel!.stateName!,
                    ),
                  ));
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 50),
                backgroundColor: backgroundColor,
                foregroundColor: Colors.white),
            child: const Text('Update Status'),
          ),
        ),
      ),
    );
  }
}
