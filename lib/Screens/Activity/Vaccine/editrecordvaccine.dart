import '/models/VacIDCow.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../Cow/successrecord.dart';
import '../../../models/Vaccines.dart';

class EditRecordVaccine extends StatefulWidget {
  final VacIDCow vac;
  EditRecordVaccine({required this.vac});
  @override
  _EditRecordVaccineState createState() => _EditRecordVaccineState();
}

class _EditRecordVaccineState extends State<EditRecordVaccine> {
  Future<List<Vaccines>> getVaccines() async {
    final response = await http
        .get(Uri.https('heroku-diarycattle.herokuapp.com', 'vaccines'));

    Map<String, dynamic> data = jsonDecode(response.body);
    final List list = data['data']['rows'];

    List<Vaccines> vaccines = list.map((e) => Vaccines.fromMap(e)).toList();

    return vaccines;
  }

  @override
  void initState() {
    super.initState();
    getVaccines();
  }

  int selectVaccine = 0;
  int vac = 0;
  var date2;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  getDate(date) {
    DateTime dateTime = DateTime.parse(date);
    var newDate = DateTime(dateTime.year, dateTime.month + 1, dateTime.day);
    var date1 =
        (DateFormat('yyyy-MM-dd').format(DateTime.parse(newDate.toString())));

    setState(() {
      date2 = date1;
    });

    print(date2);

    return date1;
  }

  DateTime? _dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('แก้ไขบันทึกการฉีดวัคซีน'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            // ignore: prefer_const_constructors
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromRGBO(111, 193, 148, 5),
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  alignment: Alignment.topLeft,
                  child: Row(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ชื่อวัว : ${widget.vac.cow_name}'),
                          Text('หมายเลขวัว : ${widget.vac.cow_no}'),
                          Text(
                              'บันทึกฉีดวัคซีน : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.vac.vac_date))}'),
                        ]),
                    Container(
                        margin: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.vac.cow_image),
                            radius: 40.0))
                  ])),
              FutureBuilder<List<Vaccines>>(
                future: getVaccines(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.brown,
                      ),
                    );
                  }
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('ชื่อวัคซีนใหม่',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: DropdownButton<Vaccines>(
                                  isExpanded: true,
                                  hint: const Text('select vaccine'),
                                  value: selectVaccine == null
                                      ? null
                                      : snapshot.data?[selectVaccine],
                                  items: snapshot.data?.map((data) {
                                    return DropdownMenuItem<Vaccines>(
                                        value: data,
                                        child: Text(data.vac_name_th));
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectVaccine =
                                          snapshot.data!.indexOf(value!);
                                    });
                                  },
                                ),
                                padding: const EdgeInsets.all(20.0)),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: const Text('วันที่ฉีดวัคซีนวัว',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 20, 0, 20),
                                  child: Text(
                                    _dateTime == null
                                        ? DateFormat('dd-MM-yyyy').format(
                                            DateTime.parse(widget.vac.vac_date))
                                        : DateFormat('dd-MM-yyyy').format(
                                            DateTime.parse(
                                                _dateTime.toString())),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 10),
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
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 40, 0, 30),
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
                                              30, 10, 30, 10))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 40, 0, 30),
                                  child: Column(
                                    children: [
                                      RaisedButton(
                                          onPressed: () {
                                            if (selectVaccine != null) {
                                              setState(() {
                                                vac = selectVaccine;
                                                vac = vac + 1;
                                              });
                                            }
                                            if (_dateTime == null) {
                                              _dateTime = DateTime.parse(widget
                                                  .vac.vac_date
                                                  .toString());
                                            }
                                            if (vac != null &&
                                                _dateTime != null) {
                                              userRecordVaccine(
                                                  widget.vac.schedule_id,
                                                  vac,
                                                  widget.vac.cow_id,
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(DateTime.parse(
                                                          _dateTime
                                                              .toString())),
                                                  getDate(
                                                      _dateTime.toString()));
                                            }
                                          },
                                          color: const Color.fromRGBO(
                                              111, 193, 148, 5),
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
                                              20, 12, 20, 12))
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              )
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

  userRecordVaccine(
      schedule_id, vaccine_id, cow_id, vac_date, next_date) async {
    String note = '-';

    Map data = {
      'schedule_id': schedule_id.toString(),
      'vaccine_id': vaccine_id.toString(),
      'cow_id': cow_id.toString(),
      'vac_date': vac_date,
      'next_date': next_date,
      'note': note
    };

    print(data);

    final response = await http.put(
        Uri.https('heroku-diarycattle.herokuapp.com', 'schedules/edit'),
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
