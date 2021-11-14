import 'dart:convert';
import '/Screens/Cow/successrecord.dart';
import '/models/Species.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import '/models/Cows.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordBreeding extends StatefulWidget {
  const RecordBreeding({Key? key}) : super(key: key);

  @override
  _RecordBreedingState createState() => _RecordBreedingState();
}

class _RecordBreedingState extends State<RecordBreeding> {
  Future<List<Cows>> getCow() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Cows> cows = [];
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

  Future<List<Species>> getSpecies() async {
    final response = await http
        .get(Uri.https('heroku-diarycattle.herokuapp.com', 'species'));

    Map<String, dynamic> data = jsonDecode(response.body);
    final List list = data['data']['rows'];

    List<Species> species = list.map((e) => Species.fromMap(e)).toList();

    return species;
  }

  @override
  _RecordBreedingState createState() => _RecordBreedingState();
  void initState() {
    super.initState();
    getCow();
    getSpecies();
  }

  DateTime? _dateTime;
  int? cow_id;
  int _counter = 1;
  int selectSpecie = 0;
  String? sex;
  String? status;
  int specie = 0;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final dadController = TextEditingController();
  final caretakerController = TextEditingController();
  final dadIdController = TextEditingController();
  final noteController = TextEditingController();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
  }

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
        appBar: AppBar(
          title: const Text("บันทึกการผสมพันธ์"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xffd6786e),
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: [
              Column(
                children: [
                  FutureBuilder<List<Cows>>(
                      future: getCow(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 30, 30, 30),
                              child: const Center(
                                  child: Text('กรุณาเพิ่มข้อมูลวัว')));
                        }
                        return Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: DropdownSearch<Cows>(
                            showSelectedItems: true,
                            compareFn: (Cows? i, Cows? s) => i!.isEqual(s),
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
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
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
                        decoration: const InputDecoration(
                          hintText: 'หมายเลขพ่อพันธุ์',
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
                        decoration: const InputDecoration(
                          hintText: 'ชื่อพ่อพันธุ์',
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
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      FutureBuilder<List<Species>>(
                          future: getSpecies(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.brown,
                                ),
                              );
                            }
                            return Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: DropdownButton<Species>(
                                isExpanded: true,
                                hint: const Text('กรุณาเลือกสายพันธุ์'),
                                value: selectSpecie == null
                                    ? null
                                    : snapshot.data?[selectSpecie],
                                items: snapshot.data?.map((data) {
                                  return DropdownMenuItem<Species>(
                                      value: data,
                                      child: Text(data.specie_name_th));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectSpecie =
                                        snapshot.data!.indexOf(value!);
                                  });
                                },
                              ),
                            );
                          })
                    ],
                  ),
                  Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: const Text('ผู้ดูแล',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextField(
                        controller: caretakerController,
                        decoration: const InputDecoration(
                          hintText: 'ชื่อผู้แล',
                          fillColor: Colors.blueGrey,
                        ),
                        onChanged: (String name) {},
                      ),
                    )
                  ]),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                        child: const Text('วันที่คลอด',
                            style: TextStyle(fontWeight: FontWeight.bold)),
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
                      Column(children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: const Text('รายละเอียดอื่นๆ',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextField(
                            controller: noteController,
                            decoration: const InputDecoration(
                              hintText: 'รายละเอียด',
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
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Column(
                                children: [
                                  RaisedButton(
                                    onPressed: () {
                                      if (cow_id == null) {
                                        _scaffoldKey.currentState?.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "กรุณาเลือกวัวที่จะบันทึกข้อมูล")));
                                        return;
                                      }
                                      if (dadIdController.text.isEmpty) {
                                        _scaffoldKey.currentState?.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "กรุณากรอกหมายเลขพ่อพันธุ์")));
                                        return;
                                      }
                                      if (dadController.text.isEmpty) {
                                        _scaffoldKey.currentState?.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "กรุณากรอกชื่อพ่อพันธุ์")));
                                        return;
                                      }
                                      if (caretakerController.text.isEmpty) {
                                        _scaffoldKey.currentState?.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "กรุณากรอกชื่อคนผสมพันธุ์")));
                                        return;
                                      }
                                      if (_dateTime == null) {
                                        _scaffoldKey.currentState?.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "กรุณากรอกวันผสมพันธุ์")));
                                        return;
                                      }
                                      setState(() {
                                        specie = selectSpecie;
                                      });
                                      if (_counter < 1) {
                                        _scaffoldKey.currentState?.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "จำนวนรอบไม่สามารถต่ำกว่า 1 ได้")));
                                        return;
                                      }
                                      if (noteController.text.isEmpty) {
                                        setState(() {
                                          noteController.text = '-';
                                        });
                                      }
                                      if (_counter >= 1 &&
                                          _dateTime != null &&
                                          caretakerController.text.isNotEmpty &&
                                          dadIdController.text.isNotEmpty) {
                                        userAddAb(
                                            cow_id,
                                            _counter,
                                            _dateTime,
                                            caretakerController.text,
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
            ]))));
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

  userAddAb(cow_id, round, date, caretaker, semen_id, semen_name, specie, note,
      user, farm) async {
    String ab_status = 'wait';
    String ab_calf = 'f';

    Map data = {
      'cow_id': cow_id.toString(),
      'round': round.toString(),
      'ab_date': date.toString(),
      'ab_status': ab_status,
      'ab_caretaker': caretaker,
      'semen_id': semen_id,
      'semen_name': semen_name,
      'semen_specie': specie.toString(),
      'ab_calf': ab_calf,
      'note': note,
      'user_id': user.toString(),
      'farm_id': farm.toString()
    };

    print(data);

    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'abdominal/create'),
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
