import 'dart:io';
import '/Screens/Welcome/welcome.dart';
import '/models/CheckEmail.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/CheckEmail.dart';
import '../Farm/text_field_container.dart';
import 'welcome.dart';
import '../../util/register_store.dart';
import '../../util/shared_preference.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  bool _isInit = true;

  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late CheckEmail args;
  late String user_id;
  late String email;
  late String password;
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? firebaseUser;
  late String actualCode;
  late String _verificationId;
  File? _image;
  String _uploadedFileURL = '';
  String? imageName;
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  //final birthdayController = TextEditingController();
  final mobileController = TextEditingController();
  // final user_imageController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _smsController = TextEditingController();
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
      TaskSnapshot addImg = await ref.child("User/$_image").putFile(_image!);
      if (addImg.state == TaskState.success) {
        setState(() {
          this.isLoading = false;
        });
        print("added to Firebase Storage");
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget._isInit) {
      args = ModalRoute.of(context)!.settings.arguments as CheckEmail;
      user_id = args.user_id!;
      email = args.email!;
      password = args.password!;
      widget._isInit = false;
    }
  }

  DateTime? _dateTime;
  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterStore>(builder: (_, loginStore, __) {
      return Observer(
          builder: (_) => (Scaffold(
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
                      child: Text('DairyCattle'),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.account_circle,
                            color: Colors.green[400], size: 30),
                        onPressed: () {},
                      ),
                    )),
                  ],
                ),
                backgroundColor: Colors.green[400],
                key: loginStore.loginScaffoldKey,
              ),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Text('สร้างบัญชีผู้ใช้งาน',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 25)),
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
                                          color: Colors.white),
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
                            controller: firstnameController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            validator: value_validator,
                            child: Text(
                              'ชื่อ',
                              style: TextStyle(fontSize: 15),
                            ),
                            hintText: "ชื่อ"),
                        TextFieldContainer(
                            controller: lastnameController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            validator: value_validator,
                            child: Text(
                              'นามสกุล',
                              style: TextStyle(fontSize: 15),
                            ),
                            hintText: "นามสกุล"),
                        Container(
                          child: Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 20, 0, 0),
                                          child: Text(
                                            'วันเกิด',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(40, 20, 0, 20),
                                        child: Text(
                                          _dateTime == null
                                              ? 'วัน/เดือน/ปี'
                                              : '${DateFormat('dd-MM-yyyy').format(DateTime.parse(_dateTime.toString()))}',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 15, 0, 10),
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
                                                builder: (context, picker) {
                                                  return Theme(
                                                    data: ThemeData.light()
                                                        .copyWith(
                                                      colorScheme:
                                                          ColorScheme.dark(
                                                        primary: Colors.green,
                                                        onPrimary: Colors.white,
                                                        surface: Colors.green,
                                                        onSurface:
                                                            Color(0xFF77dd77),
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
                                        ),
                                      )
                                    ])
                                  ]),
                            ],
                          ),
                        ),
                        TextFieldContainer(
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {},
                            validator: value_validator,
                            child: Text(
                              'เบอร์มือถือ',
                              style: TextStyle(fontSize: 15),
                            ),
                            hintText: "เบอร์มือถือ"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RaisedButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return Welcome();
                                        }));
                                      },
                                      color: Colors.blueGrey[50],
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(39))),
                                      child: Text(
                                        'ยกเลิก',
                                        style: TextStyle(
                                            color: Color(0xffd6786e),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 10, 30, 10),
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
                                        if (isLoading) {
                                          return;
                                        }
                                        if (firstnameController.text.isEmpty) {
                                          _scaffoldKey.currentState
                                              ?.showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please Enter Firstname")));
                                          return;
                                        }
                                        if (lastnameController.text.isEmpty) {
                                          _scaffoldKey.currentState
                                              ?.showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please Enter Lastname")));
                                          return;
                                        }
                                        if (_dateTime == null) {
                                          _scaffoldKey.currentState
                                              ?.showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please Enter BirthDay")));
                                          return;
                                        }
                                        if (mobileController.text.isEmpty) {
                                          _scaffoldKey.currentState
                                              ?.showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please Enter Mobile")));
                                          return;
                                        }

                                        if (mobileController.text.isNotEmpty) {
                                          String d = '${DateFormat('yyyy-MM-dd').format(DateTime.parse(_dateTime.toString()))}';
                                          print('------' + d);
                                          UserPreferences().saveRegister(
                                              args.user_id,
                                              firstnameController.text,
                                              lastnameController.text,
                                              '${DateFormat('yyyy-MM-dd').format(DateTime.parse(_dateTime.toString()))}',
                                              mobileController.text.toString(),
                                              FileImage(_image!).toString(),
                                              args.email,
                                              args.password);
                                          loginStore.getCodeWithPhoneNumber(
                                              context, mobileController.text);
                                        } else {
                                          loginStore
                                              .loginScaffoldKey.currentState
                                              ?.showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              'Please enter a phone number',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ));
                                        }
                                      },
                                      color: Color(0xff62b490),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(39))),
                                      child: Text(
                                        'บันทึกข้อมูล',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 12, 20, 12),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ))));
    });
  }
}
