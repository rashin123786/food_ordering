import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/core/provider/loading_provider.dart';
import 'package:food_ordering/core/services/profile_services.dart';
import 'package:food_ordering/utils/constants.dart';
import 'package:food_ordering/utils/style.dart';
import 'package:food_ordering/view/screen/changePassword/passowrd_chnage_screen.dart';
import 'package:food_ordering/view/shared/widget/bottom_sheet.dart';
import 'package:food_ordering/view/shared/widget/text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/model/AuthModel/login_model.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _pickedImageBytes;
  Future<void> picksinglefile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image, withData: true);

    if (result != null) {
      Uint8List? pickedImageBytes = result.files.first.bytes;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('pickedImageBytes',
          pickedImageBytes!.map((e) => e.toString()).toList());
      setState(() {
        _pickedImageBytes = pickedImageBytes;
      });
    }
  }

  Future<void> retrieveImageFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final pickedImageBytesList = prefs.getStringList('pickedImageBytes');

    if (pickedImageBytesList != null) {
      final pickedImageBytes = Uint8List.fromList(
          pickedImageBytesList.map((e) => int.parse(e)).toList());
      setState(() {
        _pickedImageBytes = pickedImageBytes;
      });
    }
  }

  @override
  void initState() {
    retrieveImageFromSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
      ),
      body: SafeArea(
        child: Consumer<LoadingProvider>(
          builder: (context, value, child) => FutureBuilder(
            future: value.getProfileData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            width: 130.0,
                            height: 130.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(65),
                              child: _pickedImageBytes == null
                                  ? Center(
                                      child: Text("No Profile"),
                                    )
                                  : FittedBox(
                                      fit: BoxFit.fill,
                                      child: Image.memory(
                                        _pickedImageBytes!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 97, 97, 97),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(65.0)),
                              border: Border.all(
                                color: backgroundColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            left: 210,
                            bottom: 0,
                            child: CircleAvatar(
                              backgroundColor: backgroundColor,
                              foregroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () {
                                    picksinglefile();
                                  },
                                  icon: Icon(Icons.edit)),
                            ))
                      ],
                    ),
                    ListTile(
                      title: Text(
                        "Name",
                        style: TextStyle(fontSize: 12),
                      ),
                      subtitle: Text(
                        snapshot.data!.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Phone",
                        style: TextStyle(fontSize: 12),
                      ),
                      subtitle: Text(
                        snapshot.data!.phone,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Email",
                        style: TextStyle(fontSize: 12),
                      ),
                      subtitle: Text(
                        snapshot.data!.email,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertProfileUpdate(
                                  name: snapshot.data!.name,
                                  number: snapshot.data!.phone,
                                );
                              },
                            );
                          },
                          child: Text("Update"),
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: backgroundColor),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasword(),
                                ));
                          },
                          child: Text("change password"),
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: backgroundColor),
                        ),
                      ],
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
