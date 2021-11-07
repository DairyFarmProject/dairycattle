import 'dart:io';

import '../../models/User.dart';
import '../../providers/user_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../models/Cows.dart';
import '../../models/AllChoose.dart';
import 'successeditcow.dart';

class EditCow extends StatefulWidget {
  final Cows cow;
  EditCow({required this.cow});
  @override
  _EditCowState createState() => _EditCowState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
void showInSnackBar(String value) {
  _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
}

class _EditCowState extends State<EditCow> {
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

  int selectStatus = 1;
  int selectType = 1;
  int selectSpecie = 1;
  int selectSex = 1;

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  int _selectIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  DateTime? _dateTime;
  final _formKey = GlobalKey<FormState>();
  final nameCowController = TextEditingController();
  final cowNoController = TextEditingController();
  final cowNoteController = TextEditingController();
  final value_validator = RequiredValidator(errorText: "กรุณาใส่ข้อมูล");

  TextEditingController dateCtl = TextEditingController();
  DateTime? date;
  var formatter = new DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: Text("แก้ไขข้อมูลวัว"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.brown,
        ),
        body: Form(
            key: _formKey,
            child: Container(
                child: SingleChildScrollView(
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
                                    color: Colors.white),
                                child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Center(
                                        child: Container(
                                            child: IconButton(
                                      icon: CircleAvatar(
                                        radius: 200,
                                        backgroundImage: NetworkImage(
                                            '${widget.cow.cow_image}'),
                                        //backgroundColor: Colors.transparent,
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
                  Container(
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(20),
                    width: 350,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      border:
                          Border.all(color: (Colors.blueGrey[300])!, width: 2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 5),
                                      child: Text(
                                        'ชื่อวัว : ${widget.cow.cow_name}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 5),
                                      child: Text(
                                        'วันเกิด : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.cow.cow_birthday))}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                              child: Text(
                                'รหัสประจำตัว : ${widget.cow.cow_no}',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xff5a82de),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text(
                              'สถานะปัจจุบัน : ${widget.cow.type_name}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.all(0),
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      child: Text('ชื่อวัว',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)))),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: SizedBox(
                                            height: 30,
                                            width: 100,
                                            child: TextFormField(
                                              validator: value_validator,
                                              controller: nameCowController,
                                              decoration: InputDecoration(
                                                hintText:
                                                    '${widget.cow.cow_name}',
                                                fillColor: Colors.blueGrey,
                                                border: InputBorder.none,
                                              ),
                                              onChanged: (String _name) {
                                                if (_name.isEmpty) {
                                                  _name =
                                                      '${widget.cow.cow_name}';
                                                } else
                                                  _name = _name;
                                              },
                                            ),
                                          ))))
                            ]),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.all(0),
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 15),
                                      child: Text('รหัสประจำตัว',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)))),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 0, 0),
                                          child: SizedBox(
                                            height: 30,
                                            width: 100,
                                            child: TextFormField(
                                              validator: value_validator,
                                              controller: cowNoController,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      '${widget.cow.cow_no}',
                                                  fillColor: Colors.blueGrey,
                                                  border: InputBorder.none),
                                              onChanged: (String name) {},
                                            ),
                                          ))))
                            ]),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.all(0),
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 15),
                                child: Text('วันเกิด',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: SizedBox(
                                      height: 30,
                                      width: 250,
                                      child: TextFormField(
                                          readOnly: true,
                                          controller: dateCtl,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                '${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.cow.cow_birthday))}',
                                            fillColor: Colors.blueGrey,
                                          ),
                                          onTap: () async {
                                            date = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now()
                                                    .subtract(
                                                        Duration(days: 2)),
                                                lastDate: DateTime.now()
                                                    .add(Duration(days: 2)));
                                            if (date == null) {
                                              date = DateTime.now();
                                            } else {
                                              dateCtl.text =
                                                  formatter.format((date)!);
                                            }
                                          })),
                                )))
                          ],
                        )
                      ],
                    ),
                  ),
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
                      value:
                          selectSpecie == null ? null : species[selectSpecie],
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
                  Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(0),
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text('รายละเอียดอื่นๆ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
                      child: TextField(
                        controller: cowNoteController,
                        decoration: InputDecoration(
                          hintText: '${widget.cow.note}',
                          fillColor: Colors.blueGrey,
                        ),
                        onChanged: (String name) {},
                      ),
                    )
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
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
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: Column(
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  print('Edit cow');
                                  uploadFile(_image!);
                                  userEditCow(
                                    widget.cow.cow_id,
                                    cowNoController.text,
                                    nameCowController.text,
                                    '${DateFormat('yyyy-MM-dd').format(DateTime.parse(date.toString()))}',
                                    selectSex,
                                    url,
                                    cowNoteController.text,
                                    selectSpecie,
                                    selectType,
                                    widget.cow.semen_id,
                                    widget.cow.semen_specie,
                                    widget.cow.mom_id,
                                    widget.cow.mom_specie,
                                    user?.user_id,
                                    user?.farm_id,
                                  );
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
            ))));
  }

  userEditCow(
      cow_id,
      cow_no,
      cow_name,
      cow_birthday,
      cow_sex,
      cow_image,
      note,
      specie_id,
      type_id,
      semen_id,
      semen_specie,
      mom_id,
      mom_specie,
      user_id,
      farm_id) async {
    int status_id = 1;

    Map data = {
      'cow_id': cow_id.toString(),
      'cow_no': cow_no,
      'cow_name': cow_name,
      'cow_birthday': cow_birthday,
      'cow_sex': cow_sex.toString(),
      'cow_image': cow_image,
      'note': note,
      'type_id': type_id.toString(),
      'specie_id': specie_id.toString(),
      'status_id': status_id.toString(),
      'semen_id': semen_id,
      'semen_specie': semen_specie.toString(),
      'mom_id': mom_id,
      'mom_specie': mom_specie.toString(),
      'user_id': user_id.toString(),
      'farm_id': farm_id.toString()
    };

    print(data);

    final response = await http.put(
        Uri.https('heroku-diarycattle.herokuapp.com', 'cows/edit'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("Edit Cow Success");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SuccessEditCow();
        }));
      } else {
        print(" ${resposne['message']}");
      }
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("${resposne['message']}")));
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please Try again")));
    }
  }
}
