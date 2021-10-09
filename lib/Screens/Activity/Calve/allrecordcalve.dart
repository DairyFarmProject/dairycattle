import 'dart:convert';

import 'package:intl/intl.dart';

import '../../Activity/Calve/editrecordclave.dart';
import '../../Activity/Calve/recordcalve.dart';
import '../../../models/Parturitions.dart';
import '../../../models/User.dart';
import '../../../providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AllRecordCalve extends StatefulWidget {
  const AllRecordCalve({Key? key}) : super(key: key);

  @override
  _AllRecordCalveState createState() => _AllRecordCalveState();
}

class _AllRecordCalveState extends State<AllRecordCalve> {
  Future<List<Parturition>> getParturition() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Parturition> milks = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    var body = json.encode(data);
    print(data);
    final response =
        await http.post(Uri.http('127.0.0.1:3000', 'farms/parturition'),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      milks = list.map((e) => Parturition.fromMap(e)).toList();
    }
    return milks;
  }

  @override
  void initState() {
    super.initState();
    getParturition();
  }

  int _selectIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('บันทึกการคลอด'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xff5a82de),
        ),
        body: FutureBuilder<List<Parturition>>(
            future: getParturition(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.green[400]),
                  ),
                );
              } else
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return Container(
                          margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
                          child: SingleChildScrollView(
                              child: Card(
                                  child: Column(
                            children: [
                              ExpansionTile(
                                collapsedBackgroundColor: Colors.blue[100],
                                tilePadding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                title: Text(
                                  '${snapshot.data?[i].parturition_id}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'วันที่',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'ผลการทำคลอด',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'ชื่อลูกวัว',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'หมายเหตุ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                '${DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.data![i].par_date))}'),
                                            Text('ปกติ'),
                                            Text(
                                                '${snapshot.data![i].calf_name}'),
                                            Text('ไม่มีเลย')
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(100, 10, 100, 20),
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return EditRecordCalve();
                                        }));
                                      },
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit),
                                            Text('แก้ไข')
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ))));
                    });
            }),
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            ' เพิ่มการบันทึกข้อมูล',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 14),
          ),
          icon: Icon(Icons.add),
          backgroundColor: Color(0xff62b490),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RecordCalve();
            }));
          },
        ));
  }
}
