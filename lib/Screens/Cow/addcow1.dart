import 'dart:convert';
import 'dart:io';

import 'package:dairycattle/Screens/Cow/successrecord.dart';

import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/Species.dart';
import '../../models/StatusCows.dart';
import '../../Screens/Cow/cow1.dart';
import '../../models/TypeCows.dart';
import '.././Farm/text_field_container.dart';
import '../../models/AllChoose.dart';

class AddCow extends StatefulWidget {
  @override
  _AddCowState createState() => _AddCowState();
}

class _AddCowState extends State<AddCow> {
  bool isLoading = false;
  File? _image;
  String _uploadedFileURL = '';
  String? imageName;

  int selectStatus = 1;
  int selectType = 1;
  int selectSpecie = 1;
  int selectDadSpecie = 1;
  int selectMomSpecie = 1;
  int selectSex = 1;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameCowController = TextEditingController();
  final tagCowController = TextEditingController();
  final noteCowController = TextEditingController();
  final idSemenController = TextEditingController();
  final idMomController = TextEditingController();
  DateTime? _dateTime;
  final value_validator = RequiredValidator(errorText: "X Invalid");

  Future getImage() async {
    final _picker = ImagePicker();
    var image = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }

  Future saveImage() async {
    if (_image != null) {
      setState(() {
        this.isLoading = true;
      });
      Reference ref = FirebaseStorage.instance.ref();
      TaskSnapshot addImg = await ref.child("Cow/$_image").putFile(_image!);
      if (addImg.state == TaskState.success) {
        setState(() {
          this.isLoading = false;
        });
        print("added to Firebase Storage");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  int _selectIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: Text("เพิ่มวัว"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.brown[900],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  decoration: BoxDecoration(
                      color: Color(0xff5a82de),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text('ส่วนที่ 1 : กรอกข้อมูลพื้นฐานของวัว',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18)),
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
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Center(
                                      child: Container(
                                          child: IconButton(
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 30,
                                      color: Colors.blueGrey,
                                    ),
                                    onPressed: () {
                                      getImage();
                                    },
                                  )))))
                          : CircleAvatar(
                              backgroundImage: FileImage(_image!),
                              radius: 100.0),
                    )
                  ],
                ),
                TextFieldContainer(
                    controller: nameCowController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: value_validator,
                    child: Text(
                      'ชื่อวัว',
                      style: TextStyle(fontSize: 15),
                    ),
                    hintText: "ชื่อวัว"),
                TextFieldContainer(
                    controller: tagCowController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: value_validator,
                    child: Text(
                      'หมายเลขวัว',
                      style: TextStyle(fontSize: 15),
                    ),
                    hintText: "หมายเลขวัว"),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(0),
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Text(
                        'วันเกิด',
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                          child: Text(
                            _dateTime == null
                                ? 'วัน/เดือน/ปี'
                                : '${DateFormat('dd-MM-yyyy').format(DateTime.parse(_dateTime.toString()))}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: IconButton(
                            icon: Icon(
                              Icons.calendar_today_sharp,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1970),
                                lastDate: DateTime(2022),
                              ).then((date) {
                                setState(() {
                                  _dateTime = date;
                                });
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TextFieldContainer(
                    controller: noteCowController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: value_validator,
                    child: Text(
                      'รายละเอียดอื่นๆ',
                      style: TextStyle(fontSize: 15),
                    ),
                    hintText: "รายละเอียดอื่นๆ"),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButton<Type>(
                    hint: new Text("Select a type"),
                    value: selectStatus == null ? null : types[selectType],
                    onChanged: (newValue) {
                      setState(() {
                        selectType = types.indexOf(newValue!);
                        print(selectType);
                      });
                    },
                    items: types.map((Type status) {
                      return new DropdownMenuItem<Type>(
                        value: status,
                        child: new Text(
                          status.name,
                          style: new TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButton<Specie>(
                    hint: new Text("Select a specie"),
                    value: selectSpecie == null ? null : species[selectSpecie],
                    onChanged: (newValue) {
                      setState(() {
                        selectSpecie = species.indexOf(newValue!);
                        print(selectSpecie);
                      });
                    },
                    items: species.map((Specie status) {
                      return new DropdownMenuItem<Specie>(
                        value: status,
                        child: new Text(
                          status.name,
                          style: new TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 20),
                  decoration: BoxDecoration(
                      color: Color(0xff5a82de),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text('ส่วนที่ 2 : กรอกข้อมูลเฉพาะของวัว',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18)),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButton<Sex>(
                    hint: new Text("Select a sex"),
                    value: selectSex == null ? null : sexs[selectSex],
                    onChanged: (newValue) {
                      setState(() {
                        selectSex = sexs.indexOf(newValue!);
                        print(selectSex);
                      });
                    },
                    items: sexs.map((Sex status) {
                      return new DropdownMenuItem<Sex>(
                        value: status,
                        child: new Text(
                          status.name,
                          style: new TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                TextFieldContainer(
                    controller: idSemenController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: value_validator,
                    child: Text(
                      'หมายเลขพ่อพันธุ์',
                      style: TextStyle(fontSize: 15),
                    ),
                    hintText: "หมายเลขพ่อพันธุ์"),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButton<DadSpecie>(
                    hint: new Text("Select a specie"),
                    value: selectDadSpecie == null
                        ? null
                        : semen_species[selectDadSpecie],
                    onChanged: (newValue) {
                      setState(() {
                        selectDadSpecie = semen_species.indexOf(newValue!);
                        print(selectDadSpecie);
                      });
                    },
                    items: semen_species.map((DadSpecie status) {
                      return new DropdownMenuItem<DadSpecie>(
                        value: status,
                        child: new Text(
                          status.name,
                          style: new TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                TextFieldContainer(
                    controller: idMomController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: value_validator,
                    child: Text(
                      'หมายเลขแม่พันธุ์',
                      style: TextStyle(fontSize: 15),
                    ),
                    hintText: "หมายเลขแม่พันธุ์"),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButton<MomSpecie>(
                    hint: new Text("Select a specie"),
                    value: selectMomSpecie == null
                        ? null
                        : mom_species[selectMomSpecie],
                    onChanged: (newValue) {
                      setState(() {
                        selectMomSpecie = mom_species.indexOf(newValue!);
                        print(selectMomSpecie);
                      });
                    },
                    items: mom_species.map((MomSpecie status) {
                      return new DropdownMenuItem<MomSpecie>(
                        value: status,
                        child: new Text(
                          status.name,
                          style: new TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ignore: deprecated_member_use
                            RaisedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Cow();
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
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 20),
                        child: Column(
                          children: [
                            // ignore: deprecated_member_use
                            RaisedButton(
                              onPressed: () {
                                saveImage();
                                userAddCow(
                                    user?.user_id,
                                    user?.farm_id,
                                    nameCowController.text,
                                    tagCowController.text,
                                    _dateTime,
                                    _image,
                                    noteCowController.text,
                                    selectType,
                                    selectSpecie,
                                    selectSex,
                                    idSemenController.text,
                                    idMomController.text,
                                    selectDadSpecie,
                                    selectMomSpecie);
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) {
                                //   return SuccessAddCow();
                                // }));
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
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            )
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  userAddCow(user_id, farm_id, name, tag, date, image, note, type, specie, sex,
      dad, mom, dadS, momS) async {
    int status_id = 1;

    Map data = {
      'user_id': user_id.toString(),
      'farm_id': farm_id.toString(),
      'cow_no': tag,
      'cow_name': name,
      'cow_birthday': date.toString(),
      'cow_sex': sex.toString(),
      'cow_image': image.toString(),
      'note': note,
      'type_id': type.toString(),
      'specie_id': specie.toString(),
      'status_id': status_id.toString(),
      'semen_id': dad.toString(),
      'semen_specie': dadS.toString(),
      'mom_id': mom,
      'mom_specie': momS.toString()
    };

    print(data);

    final response = await http.post(Uri.http('127.0.0.1:3000', 'cows/create'),
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
          builder: (context) => new SuccessRecord(),
        ),
      );
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please Try again")));
    }
  }
}
