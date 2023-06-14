import 'package:eshopmultivendor/Screen/Authentication/Login.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';

import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:eshopmultivendor/Model/NewModel/table_type_model.dart';
import 'package:eshopmultivendor/Screen/Media.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class RestroSignUp extends StatefulWidget {
  const RestroSignUp({Key? key}) : super(key: key);

  @override
  State<RestroSignUp> createState() => _RestroSignUpState();
}

class _RestroSignUpState extends State<RestroSignUp> {
  @override
  void initState() {
    super.initState();
    // getTableTypes();
  }

  File? tableImage;
  List<TableType> tableType = [];
  String? categoryValue;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeDescController = TextEditingController();
  double pickLat = 0;
  double pickLong = 0;

  void requestPermission(BuildContext context) async {
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  getFromGallery();
                },
                child: Container(
                  child: ListTile(
                      title: Text("Gallery"),
                      leading: Icon(
                        Icons.image,
                        color: primary,
                      )),
                ),
              ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  getFromCamera();
                },
                child: Container(
                  child: ListTile(
                      title: Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: primary,
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getFromGallery() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        tableImage = File(result.files.single.path.toString());
      });
      Navigator.pop(context);
    } else {
      // User canceled the picker
    }
  }

  Future<void> getFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        tableImage = File(pickedFile.path.toString());
      });
      Navigator.pop(context);
    } else {}
  }


  addRestroTables() async {
    CUR_USERID = await getPrefrence(Id);
    var headers = {
      'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(restroSignupApi.toString()));
    request.fields.addAll({
      'username': nameController.text.toString(),
      'email': emailController.text.toString(),
      'mobile': mobileController.text.toString(),
      'address': addressController.text.toString(),
      'store_name': storeNameController.text.toString(),
      'store_description': storeDescController.text.toString(),
      'lat': pickLat != 0 ? '${pickLat.toString()}' : '',
      'lang': pickLong != 0 ? '${pickLong.toString()}' : ''
    });
    // if (tableImage != null) {
    //   request.files.add(
    //       await http.MultipartFile.fromPath('image', tableImage!.path));
    // }

    print("this is refer request ${request.fields.toString()}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      bool error = result['error'];
      String msg = result['message'];
      if (!error) {
        Fluttertoast.showToast(msg: msg);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {}
      // var finalResponse = TableTypeModel.fromJson(result);
      // setState(() {
      //   tableType = finalResponse.data!;
      // });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/images/homelogo.png',
            height: 60,
          ),
          backgroundColor: primary,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/restaurant.png',
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Restaurant Sign Up",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                  child: Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: EdgeInsets.only(left: 15, top: 8, bottom: 4),
                    height: 50,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: primary)),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      // maxLength: 10,
                      controller: nameController,
                      decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "Name"),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                  child: Text(
                    "Mobile",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: EdgeInsets.only(left: 15, top: 8, bottom: 4),
                    height: 50,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: primary)),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      controller: mobileController,
                      decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "Mobile Number"),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                  child: Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: EdgeInsets.only(left: 15, top: 8, bottom: 4),
                    height: 50,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: primary)),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      // maxLength: 10,
                      controller: emailController,
                      decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "Email"),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                  child: Text(
                    "Restaurant Name",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: EdgeInsets.only(left: 15, top: 8, bottom: 4),
                    height: 50,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: primary)),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      // maxLength: 10,
                      controller: storeNameController,
                      decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "Restaurant Name"),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                  child: Text(
                    "Address",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                      padding: EdgeInsets.only(left: 15, top: 4, bottom: 4, right: 8),
                      // height: 50,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: primary)),
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                          maxLines: 1,
                          controller: addressController,
                          validator: (msg) {
                            if (msg!.isEmpty) {
                              return "Please Enter Address ";
                            }
                          },
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlacePicker(
                                  apiKey: Platform.isAndroid
                                      ? "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY"
                                      : "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY",
                                  onPlacePicked: (result) {
                                    print(result.formattedAddress);
                                    setState(() {
                                      addressController.text =
                                          result.formattedAddress.toString();
                                      pickLat = result.geometry!.location.lat;
                                      pickLong = result.geometry!.location.lng;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  initialPosition: LatLng(
                                      22.719568,75.857727),
                                      // double.parse(widget.lat.toString()),
                                      // double.parse(widget.long.toString())),
                                  useCurrentLocation: true,
                                ),
                              ),
                            );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => PlacePicker(
                            //       apiKey: Platform.isAndroid
                            //           ? "AIzaSyBxsWdUSLMXzjxD6X-IOKjZMp3aMoxJfKc"
                            //           : "AIzaSyBxsWdUSLMXzjxD6X-IOKjZMp3aMoxJfKc",
                            //       onPlacePicked: (result) {
                            //         print(result.formattedAddress);
                            //         setState(() {
                            //           addressController.text =
                            //               result.formattedAddress.toString();
                            //           pickLat =
                            //               result.geometry!.location.lat;
                            //           pickLong =
                            //               result.geometry!.location.lng;
                            //         });
                            //         Navigator.of(context).pop();
                            //       },
                            //       initialPosition: LatLng(22.719568,75.857727
                            //           // double.parse(widget.lat.toString()), double.parse(widget.long.toString())
                            //   ),
                            //       useCurrentLocation: true,
                            //     ),
                            //   ),
                            // );
                            // _getPickLocation();
                          },
                          decoration: InputDecoration(
                            hintText: "Address",
                              contentPadding: EdgeInsets.only(left: 10),
                              border: InputBorder.none)
                          // decoration: InputDecoration(
                          //   border: OutlineInputBorder(),
                          // ),
                          )),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                  child: Text(
                    "Restaurant Description",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: EdgeInsets.only(left: 15, top: 8, bottom: 4),
                    height: 80,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: primary)),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      // maxLength: 10,
                      controller: storeDescController,
                      decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "Restaurant Description"),
                    ),
                  ),
                ),
                // ElevatedButton(
                //     onPressed: (){
                //       requestPermission(context);
                //     },
                //     style: ElevatedButton.styleFrom(primary: primary, shape: StadiumBorder()),
                //     child: Text("Upload Images", style: TextStyle(
                //         color: white
                //     ),)),
                //
                // tableImage == null ?
                // SizedBox.shrink():
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //       image: DecorationImage(
                //           image: FileImage(File(tableImage!.path)),
                //           fit: BoxFit.fill
                //         //AssetImage(Image.file(file)File(tableImage!.path)),
                //       )
                //   ),
                //   width: MediaQuery.of(context).size.width/1.7,
                //   height: MediaQuery.of(context).size.width/1.7,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                  child: ElevatedButton(
                      onPressed: () {
                        // if (nameController.text.isNotEmpty &&
                        //     mobileController.text.isNotEmpty &&
                        //     emailController.text.isNotEmpty &&
                        //     storeNameController.text.isNotEmpty &&
                        //     storeDescController.text.isNotEmpty) {
                          if (nameController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please enter a valid name");
                          }
                          else if (storeNameController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please enter Restaurant name");
                          }
                          else if (storeDescController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please enter Restaurant description");
                          }

                          else if (mobileController.text.isEmpty &&
                              mobileController.text.length < 10) {
                            Fluttertoast.showToast(
                                msg: "Please enter a valid mobile number");
                          }
                          else if (emailController.text.isEmpty &&
                              !mobileController.text.contains('@')) {
                            Fluttertoast.showToast(
                                msg: "Please enter a valid email");
                          } else {
                            // if(tableAmountController.text.isNotEmpty && tableCountController.text.isNotEmpty && benefitsController.text.isNotEmpty && categoryValue!.isNotEmpty){
                            addRestroTables();
                          }
                        // }
                        // else {
                        //   addRestroTables();
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: primary,
                          shape: StadiumBorder(),
                          // RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(15),
                          // ),
                          fixedSize:
                              Size(MediaQuery.of(context).size.width - 40, 50)),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
