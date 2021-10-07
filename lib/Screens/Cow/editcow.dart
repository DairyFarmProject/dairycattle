import 'dart:io';

import '../../models/User.dart';
import '../../providers/user_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../models/Cows.dart';
import '../../models/TypeCows.dart';
import '../../models/StatusCows.dart';
import '../../models/Species.dart';

class EditCow extends StatefulWidget {
  final Cows cow;
  EditCow({required this.cow});
  @override
  _EditCowState createState() => _EditCowState();
}

class _EditCowState extends State<EditCow> {
  bool isLoading = false;
  File? _image;
  String _uploadedFileURL = '';

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

  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTypeCows();
    getStatusCows();
    getSpecies();
  }

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
  String? status;
  String? type;
  String? specie;
  String? sex;
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
          backgroundColor: Color(0xff62b490),
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
                                        getImage();
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
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 20, 20, 20));
                          })),
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
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 20, 20, 20));
                          })),
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
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: Column(
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  // saveImage();
                                  // userEditCow(
                                  //   user.farm_id,
                                  //   nameCowController.text,
                                  // );
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return SuccessEditCow();
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
}
