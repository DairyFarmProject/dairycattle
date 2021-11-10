import 'dart:convert';
import 'dart:io';
import '/Screens/Cow/successrecord.dart';
import '/providers/user_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/User.dart' as DairyUser;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Farm/text_field_container.dart';
import '../../util/register_store.dart';

class EditProfile extends StatefulWidget {
  bool _isInit = true;

  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late String email;
  late String password;
  bool isLoading = false;
  User? firebaseUser;
  late String actualCode;
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  //final birthdayController = TextEditingController();
  // final mobileController = TextEditingController();
  // final user_imageController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
  }

  DateTime? _dateTime;
  @override
  Widget build(BuildContext context) {
    DairyUser.User? user =
        Provider.of<UserProvider>(context, listen: false).user;
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
                    Center(
                      child: Text('แก้ไขบัญชีผู้ใช้งาน'),
                    ),
                    Expanded(
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
                                          padding: EdgeInsets.all(4.0),
                                          child: Center(
                                              child: Container(
                                                  child: IconButton(
                                            iconSize: 200,
                                            icon: CircleAvatar(
                                                radius: 200,
                                                backgroundImage: NetworkImage(
                                                    user?.user_image ?? '')),
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
                            controller: firstnameController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) return 'กรุณากรอกชื่อ';
                              return null;
                            },
                            child: const Text(
                              'ชื่อ',
                              style: TextStyle(fontSize: 15),
                            ),
                            hintText: user!.firstname),
                        TextFieldContainer(
                            controller: lastnameController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) return 'กรุณากรอกนามสกุล';
                              return null;
                            },
                            child: const Text(
                              'นามสกุล',
                              style: TextStyle(fontSize: 15),
                            ),
                            hintText: user.lastname),
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
                                            'วันเกิด',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(40, 20, 0, 20),
                                        child: Text(
                                          _dateTime == null
                                              ? DateFormat('dd-MM-yyyy').format(DateTime.parse(user.user_birthday.toString()))
                                              : DateFormat('dd-MM-yyyy').format(DateTime.parse(_dateTime.toString())),
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
                                                        primary: Colors
                                                            .brown.shade200,
                                                        onPrimary: Colors.white,
                                                        surface: Colors
                                                            .brown.shade200,
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
                                        Navigator.pop(context);
                                      },
                                      color: Colors.blueGrey[50],
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(39))),
                                      child: const Text(
                                        'ยกเลิก',
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
                                      onPressed: () async {
                                        if (isLoading) {
                                          return;
                                        }
                                        if (firstnameController.text.isEmpty) {
                                          setState(() {
                                            firstnameController.text =
                                                user.firstname;
                                          });
                                        }
                                        if (lastnameController.text.isEmpty) {
                                          setState(() {
                                            lastnameController.text =
                                                user.lastname;
                                          });
                                        }
                                        if (_dateTime == null) {
                                          setState(() {
                                            _dateTime = DateTime.parse(
                                                user.user_birthday);
                                          });
                                        }
                                        if (_image == null) {
                                          setState(() {
                                            url = user.farm_image;
                                          });
                                        }
                                        if (_image != null) {
                                          uploadFile(_image!);
                                        }
                                        if (url != null) {
                                          userEditProfile(
                                              user.user_id,
                                              firstnameController.text,
                                              lastnameController.text,
                                              _dateTime.toString(),
                                              user.mobile,
                                              url);
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
          style: TextStyle(fontSize: 15),
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

  userEditProfile(
    user_id,
    firstname,
    lastname,
    birthday,
    mobile,
    image,
  ) async {
    Map data = {
      'user_id': user_id.toString(),
      'firstname': firstname,
      'lastname': lastname,
      'user_birthday': birthday,
      'mobile': mobile,
      'user_image': image,
    };

    print(data);

    final response = await http.put(
        Uri.https('heroku-diarycattle.herokuapp.com', 'users/edit'),
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
