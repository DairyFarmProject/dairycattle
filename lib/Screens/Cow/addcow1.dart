import 'dart:convert';
import 'dart:io';

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

class AddCow extends StatefulWidget {
  @override
  _AddCowState createState() => _AddCowState();
}

class _AddCowState extends State<AddCow> {
  bool isLoading = false;
  File? _image;
  String _uploadedFileURL = '';
  String? imageName;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameCowController = TextEditingController();
  final tagCowController = TextEditingController();
  final noteCowController = TextEditingController();
  final idSemenController = TextEditingController();
  final idMomController = TextEditingController();
  String? sex;
  String? status;
  String? type;
  String? specie;
  String? dadSpecie;
  String? momSpecie;
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

  Future<List<TypeCows>> getTypeCows() async {
    final response = await http.get(Uri.http('127.0.0.1:3000', 'typecow'));

    Map<String, dynamic> data = jsonDecode(response.body);
    final List list = data['data']['typecow'];

    List<TypeCows> typecows = list.map((e) => TypeCows.fromMap(e)).toList();

    return typecows;
  }

  Future<List<StatusCows>> getStatusCows() async {
    final response = await http.get(Uri.http('127.0.0.1:3000', 'statuscows'));

    Map<String, dynamic> data = jsonDecode(response.body);
    final List list = data['data']['status'];

    List<StatusCows> statuscows =
        list.map((e) => StatusCows.fromMap(e)).toList();

    return statuscows;
  }

  Future<List<Species>> getSpecies() async {
    final response = await http.get(Uri.http('127.0.0.1:3000', 'species'));

    Map<String, dynamic> data = jsonDecode(response.body);
    final List list = data['data']['rows'];

    List<Species> species = list.map((e) => Species.fromMap(e)).toList();

    return species;
  }

  @override
  void initState() {
    super.initState();
    getTypeCows();
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
          backgroundColor: Color(0xff62b490),
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
                Container(
                    child: FutureBuilder<List<StatusCows>>(
                        future: getStatusCows(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: Text('Loading...'),
                              ),
                            );
                          } else
                            return Container(
                              child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  showSelectedItems: true,
                                  items: snapshot.data!
                                      .map((data) => data.status_name)
                                      .toList(),
                                  label: "สถานะวัว",
                                  hint: "country in menu mode",
                                  popupItemDisabled: (String s) =>
                                      s.startsWith('I'),
                                  onChanged: (newValue) {
                                    setState(() {
                                      status = newValue;
                                    });
                                  },
                                  selectedItem:
                                      '${snapshot.data?[0].status_name}'),
                              padding: const EdgeInsets.all(20.0),
                            );
                        })),
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
                    child: FutureBuilder<List<TypeCows>>(
                        future: getTypeCows(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: Text('Loading...'),
                              ),
                            );
                          } else
                            return Container(
                              child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  showSelectedItems: true,
                                  items: snapshot.data!
                                      .map((data) => data.type_name)
                                      .toList(),
                                  label: "ประเภทวัว",
                                  hint: "country in menu mode",
                                  popupItemDisabled: (String s) =>
                                      s.startsWith('I'),
                                  onChanged: (newValue) {
                                    setState(() {
                                      type = newValue;
                                    });
                                  },
                                  selectedItem:
                                      '${snapshot.data?[0].type_name}'),
                              padding: const EdgeInsets.all(20.0),
                            );
                        })),
                Container(
                    child: FutureBuilder<List<Species>>(
                        future: getSpecies(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: Text('Loading...'),
                              ),
                            );
                          } else
                            return Container(
                              child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  showSelectedItems: true,
                                  items: snapshot.data!
                                      .map((data) => data.specie_name_th)
                                      .toList(),
                                  label: "สายพันธ์วัว",
                                  hint: "country in menu mode",
                                  popupItemDisabled: (String s) =>
                                      s.startsWith('I'),
                                  onChanged: (newValue) {
                                    setState(() {
                                      specie = newValue;
                                    });
                                  },
                                  selectedItem:
                                      '${snapshot.data?[0].specie_name_th}'),
                              padding: const EdgeInsets.all(20.0),
                            );
                        })),
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
                  child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      items: ["เพศผู้", "เพศเมีย"],
                      label: "เพศ",
                      hint: "country in menu mode",
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: (newValue) {
                        setState(() {
                          sex = newValue;
                        });
                      },
                      selectedItem: "เพศผู้"),
                  padding: const EdgeInsets.all(20.0),
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
                    child: FutureBuilder<List<Species>>(
                        future: getSpecies(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: Text('Loading...'),
                              ),
                            );
                          } else
                            return Container(
                              child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  showSelectedItems: true,
                                  items: snapshot.data!
                                      .map((data) => data.specie_name_th)
                                      .toList(),
                                  label: "สายพันธุ์พ่อวัว",
                                  hint: "country in menu mode",
                                  popupItemDisabled: (String s) =>
                                      s.startsWith('I'),
                                  onChanged: (newValue) {
                                    setState(() {
                                      dadSpecie = newValue;
                                    });
                                  },
                                  selectedItem:
                                      '${snapshot.data?[0].specie_name_th}'),
                              padding: const EdgeInsets.all(20.0),
                            );
                        })),
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
                    child: FutureBuilder<List<Species>>(
                        future: getSpecies(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: Text('Loading...'),
                              ),
                            );
                          } else
                            return Container(
                              child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  showSelectedItems: true,
                                  items: snapshot.data!
                                      .map((data) => data.specie_name_th)
                                      .toList(),
                                  label: "สายพันธ์แม่วัว",
                                  hint: "country in menu mode",
                                  popupItemDisabled: (String s) =>
                                      s.startsWith('I'),
                                  onChanged: (newValue) {
                                    setState(() {
                                      momSpecie = newValue;
                                    });
                                  },
                                  selectedItem:
                                      '${snapshot.data?[0].specie_name_th}'),
                              padding: const EdgeInsets.all(20.0),
                            );
                        })),
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
                                    user?.farm_id,
                                    nameCowController.text,
                                    tagCowController.text,
                                    _dateTime,
                                    status,
                                    _image,
                                    noteCowController.text,
                                    type,
                                    specie,
                                    sex,
                                    idSemenController.text,
                                    idMomController.text,
                                    dadSpecie,
                                    momSpecie);
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

  userAddCow(farm_id, name, tag, date, status, image, note, type, specie, sex,
      dad, mom, dadS, momS) async {
    Map data = {
      'farm_id': farm_id.toString(),
      'cow_no': tag,
      'cow_name': name,
      'cow_birthday': date.toString(),
      'cow_sex': sex,
      'cow_image': image.toString(),
      'note': note,
      'typecow_id': type,
      'species_id': specie,
      'statuscow_id': status,
      'semen_id': dad,
      'semen_specie': dadS,
      'mom_id': mom,
      'mom_specie': momS
    };

    print(data);

    final response = await http.post(Uri.http('127.0.0.1:3000', 'createFarm'),
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
      // Navigator.push(
      //   context,
      //   new MaterialPageRoute(
      //     builder: (context) => new SuccessRecord(),
      //   ),
      // );
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please Try again")));
    }
  }
}
