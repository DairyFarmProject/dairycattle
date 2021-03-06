import 'dart:io';
import '/Screens/Welcome/welcome.dart';
import '/models/CheckEmail.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
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
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  //final birthdayController = TextEditingController();
  final mobileController = TextEditingController();
  // final user_imageController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _smsController = TextEditingController();

  File? _image;
  String url = '';
  String imageURL = '';
  String downloadURL = '';

  String? firstname;

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
    Reference ref = storageReference.ref().child('User/' + fileName);
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
                      child: Text('?????????????????????????????????????????????????????????'),
                    ),
                    const Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                    )),
                  ],
                ),
                backgroundColor: Colors.brown,
                key: loginStore.loginScaffoldKey,
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
                            controller: firstnameController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) return '???????????????????????????????????????';
                              return null;
                            },
                            child: const Text(
                              '????????????',
                              style: TextStyle(fontSize: 15),
                            ),
                            hintText: "????????????"),
                        TextFieldContainer(
                            controller: lastnameController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) return '????????????????????????????????????????????????';
                              return null;
                            },
                            child: const Text(
                              '?????????????????????',
                              style: TextStyle(fontSize: 15),
                            ),
                            hintText: "?????????????????????"),
                        Row(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 20, 0, 0),
                                        child: Text(
                                          '?????????????????????',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 20, 0, 20),
                                      child: Text(
                                        _dateTime == null
                                            ? '?????????/???????????????/??????'
                                            : DateFormat('dd-MM-yyyy').format(
                                                DateTime.parse(
                                                    _dateTime.toString())),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 15, 0, 10),
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
                                      ),
                                    )
                                  ])
                                ]),
                          ],
                        ),
                        TextFieldContainer(
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) return '????????????????????????????????????????????????????????????';
                              if (value.length < 10) {
                                return '???????????????????????????????????????????????? 10 ????????????';
                              }
                              if (value.length > 10) {
                                return '??????????????????????????????????????????????????????????????? 10 ????????????';
                              }
                              return null;
                            },
                            child: const Text(
                              '?????????????????????????????????',
                              style: TextStyle(fontSize: 15),
                            ),
                            hintText: "?????????????????????????????????"),
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
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return Welcome();
                                        }));
                                      },
                                      color: Colors.blueGrey[50],
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(39))),
                                      child: const Text(
                                        '??????????????????',
                                        style: TextStyle(
                                            color: Colors.brown,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 10, 30, 10),
                                    )
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: Column(
                                  children: [
                                    RaisedButton(
                                      onPressed: () {
                                        if (isLoading) {
                                          return;
                                        }
                                        if (_image == null) {
                                          _scaffoldKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "????????????????????????????????????????????????")));
                                          return;
                                        }
                                        if (firstnameController.text.isEmpty) {
                                          _scaffoldKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                                  content:
                                                      Text("???????????????????????????????????????")));
                                          return;
                                        }
                                        if (lastnameController.text.isEmpty) {
                                          _scaffoldKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "????????????????????????????????????????????????")));
                                          return;
                                        }
                                        if (_dateTime == null) {
                                          _scaffoldKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "????????????????????????????????????????????????")));
                                          return;
                                        }
                                        if (mobileController.text.isEmpty) {
                                          _scaffoldKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "????????????????????????????????????????????????????????????")));
                                          return;
                                        }
                                        if (_image != null) {
                                          uploadFile(_image!);
                                        }
                                        if (mobileController.text.isNotEmpty &&
                                            firstnameController
                                                .text.isNotEmpty &&
                                            lastnameController
                                                .text.isNotEmpty &&
                                            _dateTime != null) {
                                          UserPreferences().saveRegister(
                                              args.user_id,
                                              firstnameController.text,
                                              lastnameController.text,
                                              DateFormat('yyyy-MM-dd').format(
                                                  DateTime.parse(
                                                      _dateTime.toString())),
                                              mobileController.text.toString(),
                                              url,
                                              args.email,
                                              args.password);
                                          loginStore.getCodeWithPhoneNumber(
                                              context, mobileController.text);
                                        } else {
                                          loginStore
                                              .loginScaffoldKey.currentState
                                              ?.showSnackBar(const SnackBar(
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
                                      color: Colors.brown,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(39))),
                                      child: const Text(
                                        '????????????????????????????????????',
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
