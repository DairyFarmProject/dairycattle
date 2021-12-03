import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'confirm_create_farm.dart';
import 'home.dart';
import '/models/ScreenArguments.dart';
import 'text_field_container.dart';

class CreateFarm extends StatefulWidget {
  CreateFarm({Key? key}) : super(key: key);

  @override
  _CreateFarmState createState() => _CreateFarmState();
}

class _CreateFarmState extends State<CreateFarm> with TickerProviderStateMixin {
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

  File? _image;
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
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.white,
                        ))),
              ),
              const Center(
                child: Text('สร้างฟาร์ม'),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.account_circle,
                      color: Colors.brown, size: 30),
                  onPressed: () {},
                ),
              )),
            ],
          ),
          backgroundColor: Colors.brown,
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
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: _image == null
                            ? Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.brown[50]),
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Center(
                                        child: IconButton(
                                      icon: const Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 30,
                                        color: Colors.brown,
                                      ),
                                      onPressed: () {
                                        getImage(true);
                                      },
                                    ))))
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
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกชื่อฟาร์ม';
                        return null;
                      },
                      child: const Text(
                        'ชื่อฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "ชื่อฟาร์ม"),
                  TextFieldContainer(
                      controller: numberFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกเลขทะเบียนฟาร์ม';
                        return null;
                      },
                      child: const Text(
                        'เลขทะเบียนฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "เลขทะเบียนฟาร์ม"),
                  TextFieldContainer(
                      controller: codeFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกไอดีฟาร์ม';
                        return null;
                      },
                      child: const Text(
                        'ไอดีฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "ไอดีฟาร์ม"),
                  TextFieldContainer(
                      controller: addressFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกบ้านเลขที่';
                        return null;
                      },
                      child: const Text(
                        'บ้านเลขที่',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "บ้านเลขที่"),
                  TextFieldContainer(
                      controller: mooFarmController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกหมู่ หากไม่มีให้ -';
                        }
                        return null;
                      },
                      child: const Text(
                        'หมู่',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "หมู่"),
                  TextFieldContainer(
                      controller: soiFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกซอย หากไม่มีให้กรอก -';
                        }
                        return null;
                      },
                      child: const Text(
                        'ซอย',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "ซอย"),
                  TextFieldContainer(
                      controller: roadFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกถนน';
                        return null;
                      },
                      child: const Text(
                        'ถนน',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "ถนน"),
                  TextFieldContainer(
                      controller: sub_districtFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกตำบล';
                        return null;
                      },
                      child: const Text(
                        'ตำบล',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "ตำบล"),
                  TextFieldContainer(
                      controller: districtFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกอำเภอ';
                        return null;
                      },
                      child: const Text(
                        'อำเภอ',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "อำเภอ"),
                  TextFieldContainer(
                      controller: provinceFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกจังหวัด';
                        return null;
                      },
                      child: const Text(
                        'จังหวัด',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "จังหวัด"),
                  TextFieldContainer(
                      controller: postcodeFarmController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกรหัสไปรษณีย์';
                        if (value.length != 5)
                          return 'รหัสไปรษณีย์มี 5 ตำแหน่ง';
                        return null;
                      },
                      child: const Text(
                        'รหัสไปรษณีย์',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "รหัสไปรษณีย์"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const Home();
                                  }));
                                },
                                color: Colors.blueGrey[50],
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(39))),
                                child: const Text(
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
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Column(
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  if (_image == null) {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("กรุณาเพิ่มรูปฟาร์ม")));
                                    return;
                                  }
                                  if (nameFarmController.text.isEmpty) {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("กรุณากรอกชื่อฟาร์ม")));
                                    return;
                                  }
                                  if (numberFarmController.text.isEmpty) {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "กรุณากรอกเลขทะเบียนฟาร์ม")));
                                    return;
                                  }
                                  if (codeFarmController.text.isEmpty) {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("กรุณากรอกไอดีฟาร์ม")));
                                    return;
                                  }
                                  if (addressFarmController.text.isEmpty) {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("กรุณากรอกบ้านเลขที่")));
                                    return;
                                  }
                                  if (mooFarmController.text.isEmpty) {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "กรุณากรอกหมู่ หากไม่มีให้กรอก -")));
                                    return;
                                  }
                                  if (soiFarmController.text.isEmpty) {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "กรุณากรอกซอย หากไม่มีให้กรอก -")));
                                    return;
                                  }
                                  if (roadFarmController.text.isEmpty) {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            content: Text("กรุณากรอกถนน")));
                                    return;
                                  }
                                  if (sub_districtFarmController.text.isEmpty) {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            content: Text("กรุณากรอกตำบล")));
                                    return;
                                  }
                                  if (districtFarmController.text.isEmpty) {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            content: Text("กรุณากรอกอำเภอ")));
                                    return;
                                  }
                                  if (provinceFarmController.text.isEmpty) {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            content: Text("กรุณากรอกจังหวัด")));
                                    return;
                                  }
                                  if (postcodeFarmController.text.isEmpty) {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("กรุณากรอกรหัสไปรษณีย์")));
                                    return;
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    uploadFile(_image!);
                                    Navigator.pushNamed(
                                        context, ConfirmCreateFarm.routeName,
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
                                color: Colors.brown,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(39))),
                                child: const Text(
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
