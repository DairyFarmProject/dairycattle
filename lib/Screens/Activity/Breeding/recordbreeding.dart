import 'dart:convert';

import '../../../Screens/Cow/successrecord.dart';
import '../../../models/Species.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

import '../../../models/Cows.dart';
import '../../../models/User.dart';
import '../../../providers/user_provider.dart';
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
    final response = await http.post(Uri.http('127.0.0.1:3000', 'farms/cow'),
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
    final response = await http.get(Uri.http('127.0.0.1:3000', 'species'));

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
  int selectSpecie = 1;
  String? sex;
  String? status;

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

  decrement() => setState(() {
        _counter--;
      });

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: Text("บันทึกการผสมพันธ์"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xffd6786e),
        ),
        body: Form(
            key: _formKey,
            child: Container(
                child: SingleChildScrollView(
                    child: Column(children: [
              Column(
                children: [
                  Container(
                      child: FutureBuilder<List<Cows>>(
                          future: getCow(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Container(
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.red[400],
                                )),
                              );
                            } else
                              return Container(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                          })),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.all(0),
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                        child: Text(
                          'รอบการผสมพันธุ์',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: IconButton(
                              icon: Icon(
                                Icons.indeterminate_check_box,
                                color: Colors.brown,
                              ),
                              onPressed: decrement,
                            )),
                        Padding(
                          padding: EdgeInsets.all(3),
                          child: Text('$_counter'),
                        ),
                        Padding(
                            padding: EdgeInsets.all(0),
                            child: IconButton(
                              icon: Icon(
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
                      child: Text('หมายเลขพ่อพันธุ์',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextField(
                        controller: dadIdController,
                        decoration: InputDecoration(
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
                      child: Text('ชื่อพ่อพันธุ์',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextField(
                        controller: dadController,
                        decoration: InputDecoration(
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
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text('ชื่อสายพันธุ์',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Container(
                          child: FutureBuilder<List<Species>>(
                              future: getSpecies(),
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return Container(
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.green[400],
                                    )),
                                  );
                                } else
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: DropdownButton<Species>(
                                      isExpanded: true,
                                      hint: new Text('กรุณาเลือกสายพันธุ์'),
                                      value: selectSpecie == null
                                          ? null
                                          : snapshot.data?[selectSpecie],
                                      items: snapshot.data?.map((data) {
                                        return new DropdownMenuItem<Species>(
                                            value: data,
                                            child:
                                                new Text(data.specie_name_th));
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectSpecie =
                                              snapshot.data!.indexOf(value!);
                                        });
                                      },
                                    ),
                                  );
                              }))
                    ],
                  ),
                  Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(20),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text('ผู้ดูแล',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextField(
                        controller: caretakerController,
                        decoration: InputDecoration(
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
                        margin: EdgeInsets.all(0),
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                        child: Text('วันที่คลอด',
                            style: TextStyle(fontWeight: FontWeight.bold)),
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
                      Column(children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.all(20),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text('รายละเอียดอื่นๆ',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextField(
                            controller: noteController,
                            decoration: InputDecoration(
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
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                                      userAddAb(
                                          cow_id,
                                          _counter,
                                          _dateTime,
                                          caretakerController.text,
                                          dadIdController.text,
                                          dadController.text,
                                          selectSpecie + 1,
                                          noteController.text,
                                          user?.user_id,
                                          user?.farm_id);
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
                ],
              ),
            ])))));
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

    final response =
        await http.post(Uri.http('127.0.0.1:3000', 'abdominal/create'),
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
        new MaterialPageRoute(
          builder: (context) => new SuccessRecord(),
        ),
      );
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please Try again")));
    }
  }

  Widget _customDropDown(BuildContext context, Cows? item) {
    return Container(
        child: (item?.cow_name == null)
            ? ListTile(
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
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: !isSelected
            ? null
            : BoxDecoration(
                border: Border.all(color: Color(0xff5a82de)),
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
        Uri.http('127.0.0.1:3000', 'farms/cow', queryParameters),
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
