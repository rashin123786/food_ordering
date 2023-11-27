import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/core/services/home_services.dart';
import 'package:food_ordering/core/services/update_status.dart';
import 'package:food_ordering/utils/style.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../core/provider/home_provider.dart';
import '../../../core/services/response_services.dart';
import '../../../utils/constants.dart';

class UpdateStatusScreen extends StatefulWidget {
  const UpdateStatusScreen(
      {super.key,
      required this.Country,
      required this.city,
      required this.state,
      required this.total,
      required this.orderId});
  final String Country;
  final String city;
  final String state;
  final String total;
  final String orderId;
  @override
  State<UpdateStatusScreen> createState() => _UpdateStatusScreenState();
}

class _UpdateStatusScreenState extends State<UpdateStatusScreen> {
  int checkPayment = 0;
  String? paymentStatus;
  String? paymentMethod;
  void cashCheck(int a) {
    setState(() {
      checkPayment = a;
    });
  }

  final GlobalKey expansionTile = GlobalKey();
  String selectedValue = "On Way";

  var items = [
    "On Way",
    "Process",
    'Delivered',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
        elevation: 0,
        centerTitle: true,
        title: const Text("Update Status"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Delivery to",
                  style: TextStyle(
                      color: Color.fromRGBO(21, 34, 79, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      widget.city,
                      style: const TextStyle(
                          color: Color.fromRGBO(21, 34, 79, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: const Icon(Icons.location_on_outlined),
                    subtitle: Text(
                      "${widget.city},${widget.state},${widget.Country}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Text(
                  "Select Payment",
                  style: TextStyle(
                      color: Color.fromRGBO(21, 34, 79, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        cashCheck(0);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                            color: checkPayment == 0
                                ? backgroundColor
                                : const Color.fromRGBO(235, 235, 235, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(125, 187, 187, 187),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const SizedBox(
                                width: 30,
                                height: 30,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.black,
                                    ),
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.amber,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            title: Text(
                              "Cash",
                              style: TextStyle(
                                  color: checkPayment == 0
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        cashCheck(1);
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: checkPayment == 1
                                ? backgroundColor
                                : const Color.fromRGBO(235, 235, 235, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(125, 187, 187, 187),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const SizedBox(
                                width: 30,
                                height: 30,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.black,
                                    ),
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.amber,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            title: Text(
                              "UPI",
                              style: TextStyle(
                                  color: checkPayment == 1
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  cashCheck(2);
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: checkPayment == 2
                          ? backgroundColor
                          : const Color.fromRGBO(235, 235, 235, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(125, 187, 187, 187),
                            borderRadius: BorderRadius.circular(8)),
                        child: const SizedBox(
                          width: 30,
                          height: 30,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.black,
                              ),
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.amber,
                              )
                            ],
                          ),
                        ),
                      ),
                      title: Text(
                        "Bank Transfer",
                        style: TextStyle(
                            color: checkPayment == 2
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Text(
                  "Order Status",
                  style: TextStyle(
                      color: Color.fromRGBO(21, 34, 79, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      iconStyleData:
                          const IconStyleData(iconEnabledColor: Colors.white),
                      dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(15))),
                      isExpanded: true,
                      hint: const Text(
                        "On Way",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      items: items
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Center(
                                  child: Text(e,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) async {
                        setState(() {
                          selectedValue = value!;
                          // if (selectedValue == 'Delivered') {
                          //   print(widget.orderId);
                          //   print(userDetails!.id);
                          //   ResponseServices().getResponseOrder(
                          //       orderId: widget.orderId,
                          //       orderStatus: 'delivered',
                          //       id: userDetails!.id.toString());
                          //   setState(() {});
                          // } else {
                          //   ResponseServices().getResponseOrder(
                          //       orderId: widget.orderId,
                          //       orderStatus: 'accept_by_driver',
                          //       id: userDetails!.id.toString());
                          //   setState(() {});
                          // }
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final boxWidth = constraints.constrainWidth();
                    const dashWidth = 8.0;
                    const dashHeight = 1.0;
                    final dashCount = (boxWidth / (2 * dashWidth)).floor();
                    return Flex(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: List.generate(dashCount, (_) {
                        return const SizedBox(
                          width: dashWidth,
                          height: dashHeight,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.grey),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Sub total",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      widget.total,
                      style: TextStyle(
                        color: backgroundColor,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Delivery Fee",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Free",
                      style: TextStyle(
                        color: backgroundColor,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      widget.total,
                      style: TextStyle(
                        color: backgroundColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              if (selectedValue == "Delivered") {
                paymentStatus = "delivered";
              } else if (selectedValue == "Process") {
                paymentStatus = "processing";
              } else if (selectedValue == "On Way") {
                paymentStatus = "out_for_delivery";
              }
              if (checkPayment == 0) {
                paymentMethod = "cash";
              } else if (checkPayment == 1) {
                paymentMethod = "upi";
              } else if (checkPayment == 2) {
                paymentMethod = "bank";
              }
              print(paymentMethod);
              print(paymentStatus);
              await updatingProcess(
                      payment: paymentMethod!, status: paymentStatus!)
                  .then((value) {
                QuickAlert.show(
                    onConfirmBtnTap: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      setState(() {});
                    },
                    context: context,
                    type: QuickAlertType.success,
                    text:
                        'Your payment has been confirmed, you can check the details for order.',
                    confirmBtnText: 'Back to Home',
                    confirmBtnTextStyle: const TextStyle(color: Colors.white),
                    confirmBtnColor: backgroundColor);
              });
              if (selectedValue == "Process") {}
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 50),
                backgroundColor: backgroundColor,
                foregroundColor: Colors.white),
            child: const Text('Process'),
          ),
        ),
      ),
    );
  }

  Future updatingProcess(
      {required String payment, required String status}) async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    await homeProvider.updateStausOrder(
        orderId: widget.orderId, orderStatus: status, id: userId!);
    await homeProvider.updatePaymentStatus(
        orderId: widget.orderId, paymentStatus: "paid", paymentMethod: payment);
  }
}
