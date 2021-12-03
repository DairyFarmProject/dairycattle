import 'dart:convert';
import 'dart:io';
import '/Screens/Cow/successrecord.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '.././Farm/text_field_container.dart';
import '../../models/AllChoose.dart';

class AddCow extends StatefulWidget {
  @override
  _AddCowState createState() => _AddCowState();
}

class _AddCowState extends State<AddCow> {
  bool isLoading = false;

  int selectType = 0;
  int selectSpecie = 0;
  int selectDadSpecie = 0;
  int selectMomSpecie = 0;
  int type = 0;
  int specie = 0;
  int dad = 0;
  int mom = 0;
  String? sex;
  int sexes = 0;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameCowController = TextEditingController();
  final tagCowController = TextEditingController();
  final noteCowController = TextEditingController();
  final idSemenController = TextEditingController();
  final idMomController = TextEditingController();
  DateTime? _dateTime;

  File? _image;
  String? url;
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
    Reference ref = storageReference.ref().child('Cow/' + fileName);
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
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("เพิ่มวัว"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
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
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  decoration: const BoxDecoration(
                      color: Color(0xff5a82de),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Text('ส่วนที่ 1 : กรอกข้อมูลพื้นฐานของวัว',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18)),
                ),
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
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                      child: IconButton(
                                    icon: const Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 30,
                                      color: Colors.blueGrey,
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
                    controller: nameCowController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) return 'กรุณากรอกชื่อวัว';
                      return null;
                    },
                    child: const Text(
                      'ชื่อวัว',
                      style: TextStyle(fontSize: 15),
                    ),
                    hintText: "ชื่อวัว"),
                TextFieldContainer(
                    controller: tagCowController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) return 'กรุณากรอกหมายเลขวัว';
                      return null;
                    },
                    child: const Text(
                      'หมายเลขวัว',
                      style: TextStyle(fontSize: 15),
                    ),
                    hintText: "หมายเลขวัว"),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
                      child: const Text(
                        'วันเกิด',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                          child: Text(
                            _dateTime == null
                                ? 'วัน/เดือน/ปี'
                                : DateFormat('dd-MM-yyyy').format(
                                    DateTime.parse(_dateTime.toString())),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: IconButton(
                            icon: const Icon(
                              Icons.calendar_today_sharp,
                              color: Colors.brown,
                            ),
                            onPressed: () {
                              showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1970),
                                  lastDate: DateTime(2022),
                                  builder: (context, picker) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.dark(
                                          primary: Colors.brown.shade200,
                                          onPrimary: Colors.white,
                                          surface: Colors.brown.shade200,
                                          onSurface: Colors.brown,
                                        ),
                                        dialogBackgroundColor: Colors.white,
                                      ),
                                      child: picker!,
                                    );
                                  }).then((date) {
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
                    validator: (value) {
                      if (value!.isEmpty) return 'หากไม่มีให้ใส่ -';
                      return null;
                    },
                    child: const Text(
                      'รายละเอียดอื่นๆ',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    hintText: "รายละเอียดอื่นๆ"),
                Container(
                    padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
                    alignment: Alignment.topLeft,
                    child: const Text('ประเภทวัว',
                        style: TextStyle(fontWeight: FontWeight.w500))),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 20, 30),
                  alignment: Alignment.topLeft,
                  child: DropdownButton<Type>(
                    isExpanded: true,
                    hint: const Text("Select a type"),
                    value: selectType == null ? null : types[selectType],
                    onChanged: (newValue) {
                      setState(() {
                        selectType = types.indexOf(newValue!);
                        print(selectType);
                      });
                    },
                    items: types.map((Type status) {
                      return DropdownMenuItem<Type>(
                        value: status,
                        child: Text(
                          status.name,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
                    alignment: Alignment.topLeft,
                    child: const Text('ชื่อสายพันธุ์',
                        style: TextStyle(fontWeight: FontWeight.w500))),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 20, 40),
                  alignment: Alignment.topLeft,
                  child: DropdownButton<Specie>(
                    isExpanded: true,
                    hint: const Text("Select a specie"),
                    value: selectSpecie == null ? null : species[selectSpecie],
                    onChanged: (newValue) {
                      setState(() {
                        selectSpecie = species.indexOf(newValue!);
                        print(selectSpecie);
                      });
                    },
                    items: species.map((Specie status) {
                      return DropdownMenuItem<Specie>(
                        value: status,
                        child: Text(
                          status.name,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                  decoration: const BoxDecoration(
                      color: Color(0xff5a82de),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Text('ส่วนที่ 2 : กรอกข้อมูลเฉพาะของวัว',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18)),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(25, 10, 20, 0),
                    alignment: Alignment.topLeft,
                    child: const Text('เพศ',
                        style: TextStyle(fontWeight: FontWeight.w500))),
                Container(
                  padding: const EdgeInsets.fromLTRB(25, 15, 30, 25),
                  child: DropdownButton<Sex>(
                      value: sex == null ? null : sexs[sexes],
                      isExpanded: true,
                      items: sexs.map((Sex status) {
                        return DropdownMenuItem<Sex>(
                          value: status,
                          child: Text(
                            status.name,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        print(newValue);
                        if (newValue == "เพศผู้") {
                          setState(() {
                            sex = "M";
                          });
                        } else {
                          setState(() {
                            sex = "F";
                          });
                        }
                      }),
                ),
                TextFieldContainer(
                    controller: idSemenController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) return 'กรุณากรอกหมายเลขพ่อพันธุ์';
                      return null;
                    },
                    child: const Text(
                      'หมายเลขพ่อพันธุ์',
                      style: TextStyle(fontSize: 15),
                    ),
                    hintText: "หมายเลขพ่อพันธุ์"),
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                    alignment: Alignment.topLeft,
                    child: const Text('ชื่อสายพันธุ์',
                        style: TextStyle(fontWeight: FontWeight.w500))),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  alignment: Alignment.topLeft,
                  child: DropdownButton<DadSpecie>(
                    isExpanded: true,
                    hint: const Text("Select a specie"),
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
                      return DropdownMenuItem<DadSpecie>(
                        value: status,
                        child: Text(
                          status.name,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                TextFieldContainer(
                    controller: idMomController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) return 'กรุณากรอกหมายเลขแม่พันธุ์';
                      return null;
                    },
                    child: const Text(
                      'หมายเลขแม่พันธุ์',
                      style: TextStyle(fontSize: 15),
                    ),
                    hintText: "หมายเลขแม่พันธุ์"),
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                    alignment: Alignment.topLeft,
                    child: const Text('ชื่อสายพันธุ์',
                        style: TextStyle(fontWeight: FontWeight.w500))),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  alignment: Alignment.topLeft,
                  child: DropdownButton<MomSpecie>(
                    isExpanded: true,
                    hint: const Text("Select a specie"),
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
                      return DropdownMenuItem<MomSpecie>(
                        value: status,
                        child: Text(
                          status.name,
                          style: const TextStyle(color: Colors.black),
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
                        margin: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                        margin: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                        child: Column(
                          children: [
                            RaisedButton(
                              onPressed: () async {
                                if (nameCowController.text.isEmpty) {
                                  _scaffoldKey.currentState?.showSnackBar(
                                      const SnackBar(
                                          content: Text("กรุณากรอกชื่อวัว")));
                                  return;
                                }
                                if (tagCowController.text.isEmpty) {
                                  _scaffoldKey.currentState?.showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("กรุณากรอกหมายเลขวัว")));
                                  return;
                                }
                                if (_dateTime == null) {
                                  _scaffoldKey.currentState?.showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("กรุณากรอกวันเกิดวัว")));
                                  return;
                                }
                                if (_image == null) {
                                  _scaffoldKey.currentState?.showSnackBar(
                                      const SnackBar(
                                          content: Text("กรุณาเพิ่มรูปวัว")));
                                  return;
                                }
                                if (_image != null) {
                                  uploadFile(_image!);
                                }
                                if (selectType != null) {
                                  setState(() {
                                    type = selectType;
                                    type = type + 1;
                                  });
                                }
                                if (selectSpecie != null) {
                                  setState(() {
                                    specie = selectSpecie;
                                    specie = specie + 1;
                                  });
                                }
                                if (sex == null) {
                                  setState(() {
                                    sex = 'F';
                                  });
                                }
                                if (idSemenController.text.isEmpty) {
                                  _scaffoldKey.currentState?.showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "กรุณากรอกหมายเลขพ่อพันธุ์")));
                                  return;
                                }
                                if (idMomController.text.isEmpty) {
                                  _scaffoldKey.currentState?.showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "กรุณากรอกหมายเลขแม่พันธุ์")));
                                  return;
                                }
                                if (selectDadSpecie != null) {
                                  setState(() {
                                    dad = selectDadSpecie;
                                    dad = dad + 1;
                                  });
                                }
                                if (selectMomSpecie != null) {
                                  setState(() {
                                    mom = selectMomSpecie;
                                    mom = mom + 1;
                                  });
                                }
                                if (nameCowController.text.isNotEmpty &&
                                    tagCowController.text.isNotEmpty &&
                                    _dateTime != null &&
                                    url != null &&
                                    idSemenController.text.isNotEmpty &&
                                    idMomController.text.isNotEmpty) {
                                  userAddCow(
                                      user?.user_id,
                                      user?.farm_id,
                                      nameCowController.text,
                                      tagCowController.text,
                                      _dateTime,
                                      url,
                                      noteCowController.text,
                                      type,
                                      specie,
                                      sex,
                                      idSemenController.text,
                                      idMomController.text,
                                      dad,
                                      mom);
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

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'กรุณาตรวจสอบความถูกต้อง',
          style: TextStyle(fontSize: 17),
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 15),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
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

    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'cows/create'),
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
        MaterialPageRoute(
          builder: (context) => SuccessRecord(),
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
          ?.showSnackBar(const SnackBar(content: Text("Please Try again")));
    }
  }
}
