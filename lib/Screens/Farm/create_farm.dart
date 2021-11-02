import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'home.dart';
import '../../models/ScreenArguments.dart';
import 'text_field_container.dart';

class CreateFarm extends StatefulWidget {
  CreateFarm({Key? key}) : super(key: key);

  @override
  _CreateFarmState createState() => _CreateFarmState();
}

class _CreateFarmState extends State<CreateFarm> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
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
                child: Text('สร้างฟาร์ม'),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon:
                      Icon(Icons.account_circle, color: Colors.white, size: 30),
                  onPressed: () {},
                ),
              )),
            ],
          ),
          backgroundColor: Colors.green[400],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: <Widget>[
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
                                    return Home();
                                  }));
                                },
                                color: Colors.blueGrey[50],
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(39))),
                                child: Text(
                                  'ยกเลิก',
                                  style: TextStyle(
                                      color: Color(0xffd6786e),
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
                                    Navigator.pushNamed(
                                        context, "/confirmCreateFarm",
                                        arguments: ScreenArguments(
                                          farm_name: nameFarmController.text,
                                          farm_no: numberFarmController.text,
                                          farm_code: codeFarmController.text,
                                          address: addressFarmController.text,
                                          moo: mooFarmController.text,
                                          soi: soiFarmController.text,
                                          road: roadFarmController.text,
                                          sub_district:
                                              sub_districtFarmController.text,
                                          url: url,
                                          district: districtFarmController.text,
                                          province: provinceFarmController.text,
                                          postcode: postcodeFarmController.text,
                                        ));
                                  }
                                },
                                color: Color(0xff62b490),
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
}
