import 'dart:convert';

import '/editrecordvaccine.dart';
import '/models/Vaccine_schedule.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'models/User.dart';
import 'recordvaccine.dart';

class RecordVaccineMain extends StatefulWidget {
  const RecordVaccineMain({Key? key}) : super(key: key);

  @override
  _RecordVaccineMainState createState() => _RecordVaccineMainState();
}

class _RecordVaccineMainState extends State<RecordVaccineMain> {
  // Future<List<Vaccine_schedule>> getMilk() async {
  //   final response = await http.get(Uri.http('127.0.0.1:3000', 'schedules'));

  //   Map<String, dynamic> data = jsonDecode(response.body);
  //   final List list = data['data']['row'];

  //   List<Vaccine_schedule> typecows =
  //       list.map((e) => Vaccine_schedule.fromMap(e)).toList();

  //   return typecows;
  // }

  Future<List<Vaccine_schedule>> getVacS() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    late List<Vaccine_schedule> vacs;
    Map data = {'farm_id': user?.farm_id.toString()};
    final response = await http.post(Uri.http('127.0.0.1:3000', 'farm/schedules'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      print('Get Vaccine Schedule');
      final List list = db['data']['rows'];
      vacs = list.map((e) => Vaccine_schedule.fromMap(e)).toList();
    }
    return vacs;
  }

  @override
  _RecordVaccineMainState createState() => _RecordVaccineMainState();
  void initState() {
    super.initState();
    getVacS();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('บันทึกการฉีดวัคซีน'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xff59aca9),
        ),
        body: FutureBuilder<List<Vaccine_schedule>>(
            future: getVacS(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.green[400],),
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
                                collapsedBackgroundColor: Color(0xff59aca9),
                                tilePadding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                title: Text(
                                  '${snapshot.data?[i].schedule_id}',
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
                                              'วันที่ฉีด',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'วัคซีน',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'นัดหมาย',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'วัว',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('${DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.data![i].vac_date.toString()))}'),
                                            Text('${snapshot.data?[i].vac_name_th}'),
                                            Text('${DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.data![i].next_date.toString()))}'),
                                            Text('${snapshot.data?[i].cow_name}')
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
                                                builder: (context) => EditRecordVaccine(
                                                      vac: snapshot.data![i])));
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
              return RecordVacine();
            }));
          },
        ));
  }
}
