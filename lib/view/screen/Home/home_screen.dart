// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:food_ordering/core/provider/home_provider.dart';
import 'package:food_ordering/core/provider/loading_provider.dart';
import 'package:food_ordering/core/services/google_map_services.dart';
import 'package:food_ordering/core/services/home_services.dart';
import 'package:food_ordering/core/services/profile_services.dart';
import 'package:food_ordering/core/services/response_services.dart';
import 'package:food_ordering/utils/constants.dart';
import 'package:food_ordering/utils/style.dart';
import 'package:food_ordering/view/screen/Authentication/login_screen.dart';
import 'package:food_ordering/view/screen/Profile/profile_screen.dart';
import 'package:food_ordering/view/screen/Show%20All/show_all_screen.dart';
import 'package:food_ordering/view/screen/Tracking/tracking_screen.dart';
import 'package:food_ordering/view/shared/widget/drawer_widget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchrControl = TextEditingController();

  bool istap = false;

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 253, 253, 1),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                color: backgroundColor, borderRadius: BorderRadius.circular(8)),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileScreen(userModel: userDetails!),
                      ));
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                )),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8)),
              child: IconButton(
                  onPressed: () {
                    showLogout(context);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: () => HomeServices().getHomeOrder(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 246, 246, 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextFormField(
                    onChanged: (value) {
                      istap = true;
                      homeProvider.onButtonChanged(value);
                    },
                    controller: searchrControl,
                    decoration: const InputDecoration(
                        suffixIcon: Card(
                          color: Color.fromRGBO(9, 197, 255, 1),
                          child: Icon(
                            Icons.menu,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        labelText: 'Search Favourite food',
                        labelStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Your Order",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShowAllScreen(),
                          ));
                    },
                    child: const Text(
                      "Show All",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: istap == false
                  ? HomeServices().getHomeOrder()
                  : HomeServices().getSearch(searchrControl.text.toLowerCase()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.isEmpty
                      ? const Center(
                          child: Text('No Orders'),
                        )
                      : Expanded(
                          child: ListView.builder(
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
                                                      BorderRadius.circular(
                                                          10)),
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                        bottom:
                                                                            2,
                                                                        right:
                                                                            6),
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
                                                                        bottom:
                                                                            2,
                                                                        right:
                                                                            6),
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
                                                                  builder: (context,
                                                                      proivder,
                                                                      child) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        proivder
                                                                            .setLoading(true);

                                                                        await GoogleMapServices()
                                                                            .getCurrentLocation(context)
                                                                            .then((value) async {
                                                                          List<Placemark>
                                                                              placemarks =
                                                                              await placemarkFromCoordinates(value.latitude, value.longitude);
                                                                          final distance = GoogleMapServices().calculateDistance(
                                                                              value.latitude,
                                                                              value.longitude,
                                                                              double.parse(statusData.addressModel!.dropoffLatitude ??= '29.121378'),
                                                                              double.parse(statusData.addressModel!.dropoffLongitude ??= "76.3954252"));
                                                                          print(
                                                                              distance);
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
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 8,
                                                                              top: 2,
                                                                              bottom: 2,
                                                                              right: 8),
                                                                          child: proivder.isLoading == true
                                                                              ? const Text("Loading..", style: TextStyle(color: Colors.white, fontSize: 10))
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
                                                                      onTap:
                                                                          () {
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
                                                                              left: 8,
                                                                              top: 2,
                                                                              bottom: 2,
                                                                              right: 8),
                                                                          child:
                                                                              Text(
                                                                            "Rejected",
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 12),
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
                                                                              padding: EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 6),
                                                                              child: Text(
                                                                                "Delivered",
                                                                                style: TextStyle(color: Colors.white, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Consumer<LoadingProvider>(builder: (context,
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
                                                                              color: backgroundColor,
                                                                              child: Padding(
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
                              }),
                        );
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
    );
  }

  showLogout(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: backgroundColor),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Continue",
        style: TextStyle(color: backgroundColor),
      ),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.remove('pickedImageBytes');
        prefs.remove('id');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext ctx) => LoginScreen(
                      isLogin: true,
                    )));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Logout",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        "Are you sure you want to logout?",
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
