import 'dart:io';
import '../../models/User.dart';
import '../../providers/user_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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

  int? selectType;
  int? selectSpecie;
  int? type;
  int? specie;
  int one = 1;
  String sex = '';

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  DateTime? _dateTime;
  final _formKey = GlobalKey<FormState>();
  final nameCowController = TextEditingController();
  final cowNoController = TextEditingController();
  final cowNoteController = TextEditingController();

  TextEditingController dateCtl = TextEditingController();
  var formatter = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("แก้ไขข้อมูลวัว"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.brown,
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
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
                                      iconSize: 200,
                                      icon: CircleAvatar(
                                          radius: 200,
                                          backgroundImage: NetworkImage(
                                              widget.cow.cow_image)),
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
                  Container(
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(20),
                    width: 350,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
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
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                    child: Text(
                                      'ชื่อวัว : ${widget.cow.cow_name}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                    child: Text(
                                      'วันเกิด : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.cow.cow_birthday))}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                            child: Text(
                              'รหัสประจำตัว : ${widget.cow.cow_no}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xff5a82de),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text(
                              'สถานะปัจจุบัน : ${widget.cow.type_name}',
                              style: const TextStyle(
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      child: const Text('ชื่อ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)))),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: SizedBox(
                                        height: 30,
                                        width: 100,
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty)
                                              return 'กรุณากรอกชื่อวัว';
                                            return null;
                                          },
                                          controller: nameCowController,
                                          decoration: InputDecoration(
                                            hintText: widget.cow.cow_name,
                                            fillColor: Colors.blueGrey,
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (String _name) {
                                            if (_name.isEmpty) {
                                              _name = widget.cow.cow_name;
                                            } else
                                              _name = _name;
                                          },
                                        ),
                                      ))),
                            ]),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 15),
                                      child: const Text('รหัสประจำตัว',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)))),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 0),
                                      child: SizedBox(
                                        height: 30,
                                        width: 100,
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'กรุณากรอกรหัสประจำตัว';
                                            }
                                            return null;
                                          },
                                          controller: cowNoController,
                                          decoration: InputDecoration(
                                              hintText: widget.cow.cow_no,
                                              fillColor: Colors.blueGrey,
                                              border: InputBorder.none),
                                          onChanged: (String _name) {
                                            if (_name.isEmpty) {
                                              _name = widget.cow.cow_no;
                                            } else
                                              _name = _name;
                                          },
                                        ),
                                      )))
                            ]),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 15),
                                child: const Text('วันเกิด',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Expanded(
                                flex: 2,
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
                                          hintText: _dateTime == null
                                              ? DateFormat('dd-MM-yyyy').format(
                                                  DateTime.parse(
                                                      widget.cow.cow_birthday))
                                              : DateFormat('dd-MM-yyyy').format(
                                                  DateTime.parse(
                                                      _dateTime.toString())),
                                          fillColor: Colors.blueGrey,
                                        ),
                                        onTap: () async {
                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1970),
                                              lastDate: DateTime(2022),
                                              builder: (context, picker) {
                                                return Theme(
                                                  data: ThemeData.light()
                                                      .copyWith(
                                                    colorScheme:
                                                        ColorScheme.dark(
                                                      primary:
                                                          Colors.brown.shade200,
                                                      onPrimary: Colors.white,
                                                      surface:
                                                          Colors.brown.shade200,
                                                      onSurface: Colors.brown,
                                                    ),
                                                    dialogBackgroundColor:
                                                        Colors.white,
                                                  ),
                                                  child: picker!,
                                                );
                                              }).then((date) {
                                            setState(() {
                                              _dateTime = date;
                                            });
                                          });
                                        },
                                      )),
                                ))
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: const Text('ประเภท',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 90, 0),
                                child: DropdownButton<Type>(
                                  hint: Text(
                                      "${widget.cow.status_id}                 "),
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
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: const Text('สายพันธุ์',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 90, 0),
                                child: DropdownButton<Specie>(
                                  hint: Text(widget.cow.specie_name_th),
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
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: const Text('เพศ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: DropdownButton<String>(
                                    hint: sex == null
                                        ? Text(widget.cow.cow_sex)
                                        : Text(sex),
                                    items: <String>[
                                      '                  ',
                                      'เพศผู้',
                                      'เพศเมีย'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
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
                                      ;
                                    }),
                              ),
                            ),
                          ],
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 15),
                                      child: const Text('รายละเอียดอื่นๆ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)))),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 20, 0),
                                      child: SizedBox(
                                        height: 30,
                                        width: 100,
                                        child: TextField(
                                          controller: cowNoteController,
                                          decoration: InputDecoration(
                                            hintText: '${widget.cow.note}',
                                            fillColor: Colors.blueGrey,
                                          ),
                                          onChanged: (String _name) {
                                            if (_name.isEmpty) {
                                              _name = '-';
                                            } else
                                              _name = _name;
                                          },
                                        ),
                                      )))
                            ]),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
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
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: Column(
                            children: [
                              RaisedButton(
                                onPressed: () async {
                                  if (cowNoController.text.isEmpty) {
                                    setState(() {
                                      cowNoController.text = widget.cow.cow_no;
                                    });
                                  }
                                  if (nameCowController.text.isEmpty) {
                                    setState(() {
                                      nameCowController.text =
                                          widget.cow.cow_name;
                                    });
                                  }
                                  if (_dateTime == null) {
                                    setState(() {
                                      _dateTime = DateTime.parse(
                                          widget.cow.cow_birthday);
                                    });
                                  }
                                  if (sex == null) {
                                    setState(() {
                                      sex = widget.cow.cow_sex;
                                    });
                                  }
                                  if (_image == null) {
                                    setState(() {
                                      url = widget.cow.cow_image;
                                    });
                                  }
                                  if (selectSpecie == null) {
                                    setState(() {
                                      specie = widget.cow.specie_id;
                                    });
                                  }
                                  if (selectSpecie != null) {
                                    setState(() {
                                      specie = selectSpecie;
                                    });
                                  }
                                  if (selectType != null) {
                                    setState(() {
                                      type = selectType;
                                    });
                                  }
                                  if (cowNoteController.text.isEmpty) {
                                    setState(() {
                                      cowNoteController.text = widget.cow.note;
                                    });
                                  }
                                  if (_image != null) {
                                    uploadFile(_image!);
                                  }
                                  if (url != null &&
                                      cowNoController.text != null &&
                                      nameCowController.text != null &&
                                      _dateTime != null &&
                                      sex != null &&
                                      cowNoteController.text != null &&
                                      specie != null &&
                                      type != null) {
                                    userEditCow(
                                      widget.cow.cow_id,
                                      cowNoController.text,
                                      nameCowController.text,
                                      DateFormat('yyyy-MM-dd').format(
                                          DateTime.parse(_dateTime.toString())),
                                      sex,
                                      url,
                                      cowNoteController.text,
                                      specie! + one,
                                      type! + one,
                                      widget.cow.semen_id,
                                      widget.cow.semen_specie,
                                      widget.cow.mom_id,
                                      widget.cow.mom_specie,
                                      user?.user_id,
                                      user?.farm_id,
                                    );
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
            )));
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

    // final response = await http.put(
    //     Uri.https('heroku-diarycattle.herokuapp.com', 'cows/edit'),
    //     headers: {
    //       "Accept": "application/json",
    //       "Content-Type": "application/x-www-form-urlencoded"
    //     },
    //     body: data,
    //     encoding: Encoding.getByName("utf-8"));

    // if (response.statusCode == 200) {
    //   Map<String, dynamic> resposne = jsonDecode(response.body);
    //   if (response.statusCode == 200) {
    //     print("Edit Cow Success");
    //     Navigator.push(context, MaterialPageRoute(builder: (context) {
    //       return SuccessEditCow();
    //     }));
    //   } else {
    //     print(" ${resposne['message']}");
    //   }
    //   _scaffoldKey.currentState
    //       ?.showSnackBar(SnackBar(content: Text("${resposne['message']}")));
    // }
    // if (response.statusCode == 500) {
    //   _scaffoldKey.currentState
    //       ?.showSnackBar(const SnackBar(content: Text("Please Try again")));
    // }
  }
}
