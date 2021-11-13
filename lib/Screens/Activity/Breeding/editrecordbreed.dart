import 'dart:convert';
import '/models/Cows.dart';
import '/models/DateAb.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/Screens/Cow/successrecord.dart';
import '/models/AllChoose.dart';

class EditRecordBreed extends StatefulWidget {
  final DateAb ab;
  EditRecordBreed({Key? key, required this.ab}) : super(key: key);

  @override
  _EditRecordBreedState createState() => _EditRecordBreedState();
}

class _EditRecordBreedState extends State<EditRecordBreed> {
  Future<List<Cows>> getCow() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    late List<Cows> cows;
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'farms/cow'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      cows = list.map((e) => Cows.fromMap(e)).toList();
    }
    return cows;
  }

  @override
  _EditRecordBreedState createState() => _EditRecordBreedState();
  void initState() {
    super.initState();
    getCow();
  }

  DateTime? _dateTime;

  bool isShowOtherField = false;
  int? cow_id;
  int _counter = 1;
  int selectCow = 0;
  int selectSpecie = 0;
  int cow = 0;
  int specie = 0;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final dadController = TextEditingController();
  final dadIdController = TextEditingController();
  final noteController = TextEditingController();

  increment() => setState(() {
        _counter++;
      });

  decrement() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
    }
    if (_counter <= 1) {
      _scaffoldKey.currentState?.showSnackBar(
          const SnackBar(content: Text("จำนวนรอบไม่สามารถต่ำกว่า 1 ได้")));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('แก้ไขบันทึกการผสมพันธุ์'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromRGBO(185, 110, 110, 5),
        ),
        body: Form(
            key: _formKey,
            child: FutureBuilder<List<Cows>>(
                future: getCow(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.red[400],
                    ));
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        FutureBuilder<List<Cows>>(
                            future: getCow(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.red[400],
                                  )),
                                );
                              }
                              return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: DropdownSearch<Cows>(
                                  showSelectedItems: true,
                                  compareFn: (Cows? i, Cows? s) =>
                                      i!.isEqual(s),
                                  label: "วัว",
                                  onFind: (String? filter) => getData(filter),
                                  onChanged: (Cows? data) {
                                    setState(() {
                                      cow_id = data!.cow_id;
                                    });
                                  },
                                  dropdownBuilder: _customDropDown,
                                  popupItemBuilder: _customPopup,
                                ),
                              );
                            }),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.all(0),
                              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                              child: const Text(
                                'รอบการผสมพันธุ์',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Row(children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.indeterminate_check_box,
                                      color: Colors.brown,
                                    ),
                                    onPressed: decrement,
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(3),
                                child: Text('$_counter'),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.add_box,
                                      color: Colors.brown,
                                    ),
                                    onPressed: increment,
                                  )),
                            ])
                          ],
                        ),
                        Column(children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: const Text('หมายเลขพ่อพันธุ์',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: TextField(
                              controller: dadIdController,
                              decoration: InputDecoration(
                                hintText: widget.ab.semen_id,
                                fillColor: Colors.blueGrey,
                              ),
                              onChanged: (String name) {},
                            ),
                          )
                        ]),
                        Column(children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: const Text('ชื่อพ่อพันธุ์',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: TextField(
                              controller: dadController,
                              decoration: InputDecoration(
                                hintText: widget.ab.semen_name,
                                fillColor: Colors.blueGrey,
                              ),
                              onChanged: (String name) {},
                            ),
                          )
                        ]),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                              alignment: Alignment.topLeft,
                              child: const Text('ชื่อสายพันธุ์',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              child: DropdownButton<Specie>(
                                isExpanded: true,
                                hint: const Text("Select a specie"),
                                value: selectSpecie == null
                                    ? null
                                    : species[selectSpecie],
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
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: const Text('วันที่',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    _dateTime == null
                                        ? DateFormat('dd-MM-yyyy').format(
                                            DateTime.parse(
                                                widget.ab.ab_date.toString()))
                                        : DateFormat('dd-MM-yyyy').format(
                                            DateTime.parse(
                                                _dateTime.toString())),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                                ),
                              ],
                            ),
                            Column(children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: const Text('รายละเอียดอื่นๆ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: TextField(
                                  controller: noteController,
                                  decoration: InputDecoration(
                                    hintText: widget.ab.note,
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
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // ignore: deprecated_member_use
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
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    child: Column(
                                      children: [
                                        RaisedButton(
                                          onPressed: () {
                                            if (dadIdController.text.isEmpty) {
                                              setState(() {
                                                dadIdController.text =
                                                    widget.ab.semen_id;
                                              });
                                            }
                                            if (dadController.text.isEmpty) {
                                              setState(() {
                                                dadController.text =
                                                    widget.ab.semen_name;
                                              });
                                            }
                                            setState(() {
                                              cow = selectCow;
                                            });
                                            setState(() {
                                              specie = selectSpecie;
                                            });
                                            if (_counter < 1) {
                                              _scaffoldKey.currentState
                                                  ?.showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "จำนวนรอบไม่สามารถต่ำกว่า 1 ได้")));
                                              return;
                                            }
                                            if (noteController.text.isEmpty) {
                                              setState(() {
                                                noteController.text =
                                                    widget.ab.note;
                                              });
                                            }
                                            if (_dateTime == null) {
                                              _dateTime = DateTime.parse(
                                                  widget.ab.ab_date.toString());
                                            }
                                            if (dadIdController.text != null &&
                                                dadController.text != null &&
                                                _counter >= 1 &&
                                                noteController.text != null) {
                                              userEditAb(
                                                  widget.ab.abdominal_id,
                                                  cow + 1,
                                                  _counter,
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(DateTime.parse(
                                                          _dateTime
                                                              .toString())),
                                                  widget.ab.ab_caretaker,
                                                  dadIdController.text,
                                                  dadController.text,
                                                  specie + 1,
                                                  noteController.text,
                                                  user?.user_id,
                                                  user?.farm_id);
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
                      ],
                    ),
                  );
                })));
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

  userEditAb(ab_id, cow_id, round, ab_date, caretaker, id, name, specie, note,
      user, farm) async {
    String ab_status = 'wait';
    String ab_calf = 'f';

    Map data = {
      'abdominal_id': ab_id.toString(),
      'cow_id': cow_id.toString(),
      'round': round.toString(),
      'ab_date': ab_date,
      'ab_status': ab_status,
      'ab_caretaker': caretaker,
      'semen_id': id,
      'semen_name': name,
      'semen_specie': specie.toString(),
      'ab_calf': ab_calf,
      'note': note,
      'user_id': user.toString(),
      'farm_id': farm.toString()
    };

    print(data);

    final response = await http.put(
        Uri.https('heroku-diarycattle.herokuapp.com', 'abdominal/edit'),
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
    }
    else {
      _scaffoldKey.currentState
          ?.showSnackBar(const SnackBar(content: Text("Please Try again")));
    }
  }

  Widget _customDropDown(BuildContext context, Cows? item) {
    return Container(
        child: (item?.cow_name == null)
            ? const ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.add_outlined),
                title: Text("กรุณาเลือกวัว"),
              )
            : ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item!.cow_image),
                ),
                title: Text("${item.cow_name}"),
              ));
  }

  Widget _customPopup(BuildContext context, Cows? item, bool isSelected) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: !isSelected
            ? null
            : BoxDecoration(
                border: Border.all(color: const Color(0xff5a82de)),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white),
        child: ListTile(
          selected: isSelected,
          title: Text(item!.cow_name),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.cow_image),
          ),
        ));
  }

  Future<List<Cows>> getData(filter) async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Cows> cows = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };

    final queryParameters = {'filter': filter};

    final response = await http.post(
        Uri.https(
            'heroku-diarycattle.herokuapp.com', 'farms/cow', queryParameters),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      cows = list.map((e) => Cows.fromMap(e)).toList();
    }
    return cows;
  }
}
