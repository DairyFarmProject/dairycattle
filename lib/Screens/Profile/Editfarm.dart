import 'dart:convert';

import '/Screens/Farm/success_create_farm.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '/Screens/Farm/text_field_container.dart';
import '/Screens/Profile/Farm_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EditFarm extends StatefulWidget {
  EditFarm({Key? key}) : super(key: key);

  @override
  _EditFarmState createState() => _EditFarmState();
}

class _EditFarmState extends State<EditFarm> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameFarmController = TextEditingController();
  final numberFarmController = TextEditingController();
  final codeFarmController = TextEditingController();
  final addressFarmController = TextEditingController();
  final mooFarmController = TextEditingController();
  final soiFarmController = TextEditingController();
  final roadFarmController = TextEditingController();
  final sub_districtFarmController = TextEditingController();
  final districtFarmController = TextEditingController();
  final provinceFarmController = TextEditingController();
  final postcodeFarmController = TextEditingController();
  final value_validator = RequiredValidator(errorText: "X Invalid");

  File? _image;
  List<File> _images = [];
  String url = '';
  String imageURL = '';
  String downloadURL = '';

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    if (gallery) {
      pickedFile = (await picker.getImage(
        source: ImageSource.gallery,
      ))!;
    } else {
      pickedFile = (await picker.getImage(
        source: ImageSource.camera,
      ))!;
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile(File _image) async {
    FirebaseStorage storageReference = FirebaseStorage.instance;
    String fileName = _image.path.split('/').last;
    Reference ref = storageReference.ref().child('Farm/' + fileName);
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.whenComplete(() async {
      try {
        String urls = await ref.getDownloadURL();
        setState(() {
          url = urls;
        });
      } catch (onError) {
        print("Error");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.white,
                        ))),
              ),
              Center(
                child: Text('แก้ไขข้อมูลฟาร์ม'),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
              )),
            ],
          ),
          backgroundColor: Colors.brown,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(0),
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: _image == null
                            ? Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.brown[50]),
                                child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Center(
                                        child: Container(
                                            child: IconButton(
                                      icon: Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 30,
                                        color: Colors.brown,
                                      ),
                                      onPressed: () {
                                        getImage(true);
                                      },
                                    )))))
                            : CircleAvatar(
                                backgroundImage: FileImage(_image!),
                                radius: 100.0),
                      )
                    ],
                  ),
                  TextFieldContainer(
                      controller: nameFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: value_validator,
                      child: Text(
                        'ชื่อฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "ชื่อฟาร์ม"),
                  TextFieldContainer(
                      controller: numberFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: value_validator,
                      child: Text(
                        'เลขทะเบียนฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "เลขทะเบียนฟาร์ม"),
                  TextFieldContainer(
                      controller: codeFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: value_validator,
                      child: Text(
                        'ไอดีฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "ไอดีฟาร์ม"),
                  TextFieldContainer(
                      controller: addressFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: value_validator,
                      child: Text(
                        'บ้านเลขที่',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "บ้านเลขที่"),
                  TextFieldContainer(
                      controller: mooFarmController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                      validator: value_validator,
                      child: Text(
                        'หมู่',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "หมู่"),
                  TextFieldContainer(
                      controller: soiFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: value_validator,
                      child: Text(
                        'ซอย',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "ซอย"),
                  TextFieldContainer(
                      controller: roadFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: value_validator,
                      child: Text(
                        'ถนน',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "ถนน"),
                  TextFieldContainer(
                      controller: sub_districtFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: value_validator,
                      child: Text(
                        'ตำบล',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "ตำบล"),
                  TextFieldContainer(
                      controller: districtFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: value_validator,
                      child: Text(
                        'อำเภอ',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "อำเภอ"),
                  TextFieldContainer(
                      controller: provinceFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: value_validator,
                      child: Text(
                        'จังหวัด',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "จังหวัด"),
                  TextFieldContainer(
                      controller: postcodeFarmController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                      validator: value_validator,
                      child: Text(
                        'รหัสไปรษณีย์',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "รหัสไปรษณีย์"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return FarmData();
                                  }));
                                },
                                color: Colors.blueGrey[50],
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(39))),
                                child: Text(
                                  'ยกเลิก',
                                  style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                              )
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Column(
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    uploadFile(_image!);
                                    userEditFarm(
                                      user?.user_id,
                                      user?.farm_id,
                                      nameFarmController.text,
                                      numberFarmController.text,
                                      codeFarmController.text,
                                      addressFarmController.text,
                                      mooFarmController.text,
                                      soiFarmController.text,
                                      roadFarmController.text,
                                      sub_districtFarmController.text,
                                      districtFarmController.text,
                                      provinceFarmController.text,
                                      postcodeFarmController.text,
                                      url,
                                    );
                                  }
                                },
                                color: Colors.brown,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(39))),
                                child: Text(
                                  'บันทึกข้อมูล',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 12, 20, 12),
                              )
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  userEditFarm(user_id, farm_id, farm_name, farm_no, farm_code, address, moo,
      soi, road, sub_district, district, province, postcode, url) async {
    Map data = {
      'user_id': user_id.toString(),
      'farm_id': farm_id.toString(),
      'farm_name': farm_name,
      'farm_no': farm_no,
      'farm_code': farm_code,
      'address': address,
      'moo': moo,
      'soi': soi,
      'road': road,
      'sub_district': sub_district,
      'district': district,
      'province': province,
      'postcode': postcode.toString(),
      'farm_image': url
    };

    print(data);

    final response = await http.put(
        Uri.https('heroku-diarycattle.herokuapp.com', 'farms/edit'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      Map<String, dynamic> user = resposne['data'];
      print(user['message']);
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new SuccessCreateFarm(),
        ),
      );
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please Try again")));
    }
  }
}
