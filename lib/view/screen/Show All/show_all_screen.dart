// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_ordering/core/provider/home_provider.dart';
import 'package:food_ordering/core/services/home_services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../../core/provider/loading_provider.dart';
import '../../../core/services/google_map_services.dart';
import '../../../core/services/response_services.dart';
import '../../../utils/constants.dart';
import '../../../utils/style.dart';
import '../Tracking/tracking_screen.dart';

class ShowAllScreen extends StatefulWidget {
  const ShowAllScreen({super.key});

  @override
  State<ShowAllScreen> createState() => _ShowAllScreenState();
}

class _ShowAllScreenState extends State<ShowAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Orders",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: HomeServices().getHomeOrder(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.isEmpty
                        ? const Center(
                            child: Text('No Orders'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final productdata =
                                  snapshot.data![index].items!.product;
                              print(productdata!.name);
                              final statusData = snapshot.data![index];

                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 5, top: 5, bottom: 5),
                                child: Card(
                                  color: Colors.white,
                                  elevation: 2,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    190, 237, 190, 1),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                  productdata.thumbnailImage!,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              child: ListTile(
                                                title: Text(
                                                  productdata.name!,
                                                  style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          21, 34, 79, 1),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      productdata.brand!,
                                                      style: const TextStyle(
                                                          fontSize: 11),
                                                    ),
                                                    statusData.status ==
                                                            'accept_by_driver'
                                                        ? Text(
                                                            "Accepted",
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color:
                                                                    backgroundColor),
                                                          )
                                                        : const Text(""),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${productdata.price}",
                                                style: const TextStyle(
                                                    fontSize: 11,
                                                    color: Color.fromRGBO(
                                                        21, 34, 79, 1),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              statusData.status ==
                                                          'order_placed' ||
                                                      statusData.status ==
                                                          'pending'
                                                  ? Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            await ResponseServices().getResponseOrder(
                                                                orderId: snapshot
                                                                    .data![
                                                                        index]
                                                                    .id!
                                                                    .toString(),
                                                                orderStatus:
                                                                    'reject_by_driver',
                                                                id: userDetails!
                                                                    .id
                                                                    .toString());
                                                            setState(() {});
                                                          },
                                                          child: const Card(
                                                            color: Colors.red,
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 6,
                                                                      top: 2,
                                                                      bottom: 2,
                                                                      right: 6),
                                                              child: Text(
                                                                "Reject",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        11),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            await ResponseServices().getResponseOrder(
                                                                orderId: snapshot
                                                                    .data![
                                                                        index]
                                                                    .id!
                                                                    .toString(),
                                                                orderStatus:
                                                                    'accept_by_driver',
                                                                id: userDetails!
                                                                    .id
                                                                    .toString());
                                                            setState(() {});
                                                          },
                                                          child: Card(
                                                            color:
                                                                backgroundColor,
                                                            child:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 6,
                                                                      top: 2,
                                                                      bottom: 2,
                                                                      right: 6),
                                                              child: Text(
                                                                "Accept",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        11),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        SizedBox(
                                                          width: statusData
                                                                      .status ==
                                                                  'accept_by_driver'
                                                              ? 80
                                                              : 60,
                                                        ),
                                                        statusData.status ==
                                                                'accept_by_driver'
                                                            ? Consumer<
                                                                LoadingProvider>(
                                                                builder:
                                                                    (context,
                                                                        proivder,
                                                                        child) {
                                                                  return GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      proivder.setLoading(
                                                                          true);

                                                                      await GoogleMapServices()
                                                                          .getCurrentLocation(
                                                                              context)
                                                                          .then(
                                                                              (value) async {
                                                                        List<Placemark>
                                                                            placemarks =
                                                                            await placemarkFromCoordinates(value.latitude,
                                                                                value.longitude);
                                                                        final distance = GoogleMapServices().calculateDistance(
                                                                            value
                                                                                .latitude,
                                                                            value
                                                                                .longitude,
                                                                            double.parse(statusData.addressModel!.dropoffLatitude ??=
                                                                                '29.121378'),
                                                                            double.parse(statusData.addressModel!.dropoffLongitude ??=
                                                                                "76.3954252"));
                                                                        print(
                                                                            distance);
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => TrackingScreen(orderId: snapshot.data![index].id!.toString(), placemark: placemarks, startLat: value.latitude, startLng: value.longitude, order: statusData, endLat: double.parse(statusData.addressModel!.dropoffLatitude ??= '29.121378'), endLng: double.parse(statusData.addressModel!.dropoffLongitude ??= "76.3954252")),
                                                                            )).then((value) {
                                                                          proivder
                                                                              .setLoading(false);
                                                                        });
                                                                      });
                                                                    },
                                                                    child: Card(
                                                                      color:
                                                                          backgroundColor,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                8,
                                                                            top:
                                                                                2,
                                                                            bottom:
                                                                                2,
                                                                            right:
                                                                                8),
                                                                        child: proivder.isLoading ==
                                                                                true
                                                                            ? const Text("Loading..",
                                                                                style: TextStyle(color: Colors.white, fontSize: 10))
                                                                            : const Text(
                                                                                "View",
                                                                                style: TextStyle(color: Colors.white, fontSize: 11),
                                                                              ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              )
                                                            : statusData.status ==
                                                                    'reject_by_driver'
                                                                ? GestureDetector(
                                                                    onTap: () {
                                                                      QuickAlert.show(
                                                                          context:
                                                                              context,
                                                                          type: QuickAlertType
                                                                              .error,
                                                                          text:
                                                                              'Your Order has been Rejected',
                                                                          confirmBtnText:
                                                                              'Back to Home',
                                                                          title:
                                                                              'Rejected',
                                                                          confirmBtnTextStyle:
                                                                              const TextStyle(color: Colors.white),
                                                                          confirmBtnColor: backgroundColor);
                                                                    },
                                                                    child:
                                                                        const Card(
                                                                      color: Colors
                                                                          .red,
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                8,
                                                                            top:
                                                                                2,
                                                                            bottom:
                                                                                2,
                                                                            right:
                                                                                8),
                                                                        child:
                                                                            Text(
                                                                          "Rejected",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : statusData.status ==
                                                                        'delivered'
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          QuickAlert.show(
                                                                              context: context,
                                                                              type: QuickAlertType.success,
                                                                              text: 'Your Order has been Delivered',
                                                                              title: 'Delivered',
                                                                              confirmBtnText: 'Back to Home',
                                                                              confirmBtnTextStyle: const TextStyle(color: Colors.white),
                                                                              confirmBtnColor: backgroundColor);
                                                                        },
                                                                        child:
                                                                            Card(
                                                                          color:
                                                                              backgroundColor,
                                                                          child:
                                                                              const Padding(
                                                                            padding: EdgeInsets.only(
                                                                                left: 6,
                                                                                top: 2,
                                                                                bottom: 2,
                                                                                right: 6),
                                                                            child:
                                                                                Text(
                                                                              "Delivered",
                                                                              style: TextStyle(color: Colors.white, fontSize: 12),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Consumer<
                                                                            LoadingProvider>(
                                                                        builder: (context,
                                                                            proivder,
                                                                            child) {
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            //  proivder.setLoading(true);

                                                                            await GoogleMapServices().getCurrentLocation(context).then((value) async {
                                                                              List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude, value.longitude);

                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => TrackingScreen(orderId: snapshot.data![index].id!.toString(), placemark: placemarks, startLat: value.latitude, startLng: value.longitude, order: statusData, endLat: double.parse(statusData.addressModel!.dropoffLatitude ??= '29.121378'), endLng: double.parse(statusData.addressModel!.dropoffLongitude ??= "76.3954252")),
                                                                                  )).then((value) {
                                                                                proivder.setLoading(false);
                                                                              });
                                                                            });
                                                                          },
                                                                          child:
                                                                              Card(
                                                                            color:
                                                                                backgroundColor,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 6),
                                                                              child: proivder.isLoading == true
                                                                                  ? const Text("Loading..", style: TextStyle(color: Colors.white, fontSize: 10))
                                                                                  : const Text(
                                                                                      "View",
                                                                                      style: TextStyle(color: Colors.white, fontSize: 11),
                                                                                    ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }),
                                                      ],
                                                    ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
