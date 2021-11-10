import 'dart:convert';

import 'package:dairycattle/models/Address.dart';
import 'package:dropdown_search/dropdown_search.dart';

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

  List<Tombon> tombons = [];
  List<Amphure> amphures = [];
  List<Province> provinces = [];
  Tombon? selectItemTombon;
  Amphure? selectItemAmphure;
  Province? selectItemProvince;
  String province = '';
  String amphure = '';
  String tombon = '';

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

  Future<List<Province>> getProvince() async {
    final response = await http.get(Uri.https('raw.githubusercontent.com',
        'kongvut/thai-province-data/master/api_province.json'));
    var data = jsonDecode(response.body);
    for (var u in data) {
      Province test = Province(u['name_th']);
      provinces.add(test);
    }
    return provinces;
  }

  Future<List<Amphure>> getAmphure() async {
    final response = await http.get(Uri.https('raw.githubusercontent.com',
        'kongvut/thai-province-data/master/api_amphure.json'));
    var data = jsonDecode(response.body);
    for (var u in data) {
      Amphure test = Amphure(u['name_th']);
      amphures.add(test);
    }
    return amphures;
  }

  Future<List<Tombon>> getTombon() async {
    final response = await http.get(Uri.https('raw.githubusercontent.com',
        'kongvut/thai-province-data/master/api_tombon.json'));
    var data = jsonDecode(response.body);
    for (var u in data) {
      Tombon test = Tombon(u['name_th']);
      tombons.add(test);
    }
    return tombons;
  }

  @override
  _EditFarmState createState() => _EditFarmState();
  void initState() {
    super.initState();
    getProvince();
    getAmphure();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
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
                                      iconSize: 200,
                                      icon: CircleAvatar(
                                          radius: 200,
                                          backgroundImage: NetworkImage(
                                              user?.farm_image ?? '')),
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
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกชื่อฟาร์ม';
                        return null;
                      },
                      child: Text(
                        'ชื่อฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "${user?.farm_name}"),
                  TextFieldContainer(
                      controller: numberFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกเลขทะเบียนฟาร์ม';
                        return null;
                      },
                      child: Text(
                        'เลขทะเบียนฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "${user?.farm_no}"),
                  TextFieldContainer(
                      controller: addressFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกบ้านเลขที่';
                        return null;
                      },
                      child: Text(
                        'บ้านเลขที่',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "${user?.address}"),
                  TextFieldContainer(
                      controller: mooFarmController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'กรุณากรอกหมู่ หากไม่มีให้ -';
                        return null;
                      },
                      child: Text(
                        'หมู่',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "${user?.moo}"),
                  TextFieldContainer(
                      controller: soiFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกซอย หากไม่มีให้ -';
                        return null;
                      },
                      child: Text(
                        'ซอย',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "${user?.soi}"),
                  TextFieldContainer(
                      controller: roadFarmController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกถนน';
                        return null;
                      },
                      child: Text(
                        'ถนน',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: "${user?.soi}"),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: FutureBuilder<List<Tombon>>(
                                    future: getTombon(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data == null) {
                                        return Container(
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: Colors.brown,
                                          )),
                                        );
                                      } else
                                        return Container(
                                          margin: EdgeInsets.fromLTRB(
                                              20, 30, 20, 20),
                                          child: DropdownSearch<Tombon>(
                                            mode: Mode.DIALOG,
                                            showSearchBox: true,
                                            maxHeight: 300,
                                            selectedItem: selectItemTombon,
                                            items: tombons,
                                            label: 'ตำบล',
                                            hint: '${user?.sub_district}',
                                            itemAsString: (value) =>
                                                value!.name_th,
                                            onChanged: (value) {
                                              setState(() {
                                                amphure = value!.name_th;
                                              });
                                            },
                                          ),
                                        );
                                    }))
                          ])),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: FutureBuilder<List<Amphure>>(
                                    future: getAmphure(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data == null) {
                                        return Container(
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: Colors.brown,
                                          )),
                                        );
                                      } else
                                        return Container(
                                          margin: EdgeInsets.fromLTRB(
                                              20, 30, 20, 20),
                                          child: DropdownSearch<Amphure>(
                                            mode: Mode.DIALOG,
                                            showSearchBox: true,
                                            maxHeight: 300,
                                            selectedItem: selectItemAmphure,
                                            items: amphures,
                                            hint: '${user?.district}',
                                            label: 'อำเภอ',
                                            itemAsString: (value) =>
                                                value!.name_th,
                                            onChanged: (value) {
                                              setState(() {
                                                amphure = value!.name_th;
                                              });
                                            },
                                          ),
                                        );
                                    }))
                          ])),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: FutureBuilder<List<Province>>(
                                    future: getProvince(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data == null) {
                                        return Container(
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: Colors.brown,
                                          )),
                                        );
                                      } else
                                        return Container(
                                          margin: EdgeInsets.fromLTRB(
                                              20, 30, 20, 20),
                                          child: DropdownSearch<Province>(
                                            mode: Mode.DIALOG,
                                            showSearchBox: true,
                                            maxHeight: 300,
                                            selectedItem: selectItemProvince,
                                            items: provinces,
                                            hint: '${user?.province}',
                                            label: 'จังหวัด',
                                            itemAsString: (value) =>
                                                value!.name_th,
                                            onChanged: (value) {
                                              setState(() {
                                                province = value!.name_th;
                                              });
                                            },
                                          ),
                                        );
                                    }))
                          ])),
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
                      child: Text(
                        'รหัสไปรษณีย์',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: '${user?.postcode}'),
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
                                  if (nameFarmController.text.isEmpty)
                                    setState(() {
                                      nameFarmController.text = user!.farm_name;
                                    });
                                  if (numberFarmController.text.isEmpty)
                                    setState(() {
                                      numberFarmController.text = user!.farm_no;
                                    });
                                  if (addressFarmController.text.isEmpty)
                                    setState(() {
                                      addressFarmController.text =
                                          user!.address;
                                    });
                                  if (mooFarmController.text.isEmpty)
                                    setState(() {
                                      mooFarmController.text =
                                          user!.moo.toString();
                                    });
                                  if (soiFarmController.text.isEmpty)
                                    setState(() {
                                      soiFarmController.text = user!.soi;
                                    });
                                  if (roadFarmController.text.isEmpty)
                                    setState(() {
                                      roadFarmController.text = user!.road;
                                    });
                                  if (sub_districtFarmController.text.isEmpty)
                                    setState(() {
                                      sub_districtFarmController.text =
                                          user!.sub_district;
                                    });
                                  if (districtFarmController.text.isEmpty)
                                    setState(() {
                                      districtFarmController.text =
                                          user!.district;
                                    });
                                  if (provinceFarmController.text.isEmpty)
                                    setState(() {
                                      provinceFarmController.text =
                                          user!.province;
                                    });
                                  if (postcodeFarmController.text.isEmpty)
                                    setState(() {
                                      postcodeFarmController.text =
                                          user!.postcode.toString();
                                    });
                                  if (_image == null)
                                    setState(() {
                                      url = user!.farm_image;
                                    });
                                  if (_image != null) {
                                    uploadFile(_image!);
                                  }
                                  if (url != null) {
                                    userEditFarm(
                                      user?.user_id,
                                      user?.farm_id,
                                      nameFarmController.text,
                                      numberFarmController.text,
                                      user?.farm_code,
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

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'กรุณาตรวจสอบความถูกต้อง',
          style: TextStyle(fontSize: 17),
        ),
        content: Text(
          message,
          style: TextStyle(fontSize: 15),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
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
    }
    if (response.statusCode == 500) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      Map<String, dynamic> user = resposne['data'];
      String mess = user['message'];
      _showerrorDialog(mess);
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please Try again")));
    }
  }
}
