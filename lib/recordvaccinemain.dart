// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:dairycattle/eachvaccine.dart';

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
  Future<List<Vaccine_schedule>> getVacS() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    late List<Vaccine_schedule> vacs;
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response =
        await http.post(Uri.http('127.0.0.1:3000', 'farm/schedules'),
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
          backgroundColor: Color.fromRGBO(111, 193, 148, 5),
        ),
        body: FutureBuilder<List<Vaccine_schedule>>(
            future: getVacS(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.green[400],
                    ),
                  ),
                );
              } else
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return Container(
                          margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
                          child: SingleChildScrollView(
                              child: Material(
                            // color: Colors.transparent,
                            //elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.86,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(111, 193, 148, 5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EachVaccine()));
                                },
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 10, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.data![i].vac_date.toString()))}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                  '${snapshot.data?[i].vac_name_th}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topLeft: Radius.circular(20)),
                                          color: Colors.green[100],
                                        ),
                                        height: 100,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 40,
                                              padding: EdgeInsets.only(
                                                  left: 0, right: 20),
                                              alignment: Alignment.center,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                      end: 20),
                                              child: Image.asset(
                                                "assets/images/vaccines.png",
                                                height: 50,
                                                color:  Color.fromRGBO(111, 193, 148, 5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          )

                              // child: Card(
                              //     child: Column(
                              // children: [
                              //   ExpansionTile(
                              //     collapsedBackgroundColor: Color(0xff59aca9),
                              //     tilePadding:
                              //         const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              //     title: Text(
                              //       '${snapshot.data?[i].schedule_id}',
                              //       style: TextStyle(
                              //           color: Colors.black,
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 16),
                              //     ),
                              //     children: <Widget>[

                              //       Container(
                              //         margin:
                              //             EdgeInsets.only(top: 20, bottom: 10),
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceEvenly,
                              //           children: [
                              //             Column(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 Text(
                              //                   'วันที่ฉีด',
                              //                   style: TextStyle(
                              //                       fontWeight: FontWeight.bold),
                              //                 ),
                              //                 Text(
                              //                   'วัคซีน',
                              //                   style: TextStyle(
                              //                       fontWeight: FontWeight.bold),
                              //                 ),
                              //                 Text(
                              //                   'นัดหมาย',
                              //                   style: TextStyle(
                              //                       fontWeight: FontWeight.bold),
                              //                 ),
                              //                 Text(
                              //                   'วัว',
                              //                   style: TextStyle(
                              //                       fontWeight: FontWeight.bold),
                              //                 )
                              //               ],
                              //             ),
                              //             Column(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 Text(
                              //                     '${DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.data![i].vac_date.toString()))}'),
                              //                 Text(
                              //                     '${snapshot.data?[i].vac_name_th}'),
                              //                 Text(
                              //                     '${DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.data![i].next_date.toString()))}'),
                              //                 Text(
                              //                     '${snapshot.data?[i].cow_name}')
                              //               ],
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //       Container(
                              //         margin:
                              //             EdgeInsets.fromLTRB(100, 10, 100, 20),
                              //         child: RaisedButton(
                              //           onPressed: () {
                              //             Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                     builder: (context) =>
                              //                         EditRecordVaccine(
                              //                             vac: snapshot
                              //                                 .data![i])));
                              //           },
                              //           child: Center(
                              //             child: Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.center,
                              //               children: [
                              //                 Icon(Icons.edit),
                              //                 Text('แก้ไข')
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ],
                              //))
                              ));
                    }
                    );
            }),
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            ' เพิ่มการบันทึกข้อมูล',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 14),
          ),
          icon: Icon(Icons.add),
          backgroundColor: Colors.brown,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RecordVacine();
            }));
          },
        ));
  }
}
