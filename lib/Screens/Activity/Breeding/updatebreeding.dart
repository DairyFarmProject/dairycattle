import '/Screens/Activity/Breeding/editrecordbreed.dart';
import '/Screens/Activity/Breeding/recordbreeding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateBreeding extends StatefulWidget {
  const UpdateBreeding({Key? key}) : super(key: key);

  @override
  _UpdateBreedingState createState() => _UpdateBreedingState();
}

class _UpdateBreedingState extends State<UpdateBreeding> {
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('ผลการตรวจสอบการตั้งท้อง')),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 100, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // ignore: deprecated_member_use
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Color(0xffd6786e),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(39))),
                            child: Row(
                              children: [
                                Icon(Icons.close),
                                Text(
                                  'ไม่ตั้งท้อง',
                                  style: TextStyle(
                                      color: Colors.blueGrey[50],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          )
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 20, 20),
                      child: Column(
                        children: [
                          // ignore: deprecated_member_use

                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.brown,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(39))),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                Text(
                                  'ตั้งท้อง',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                          )
                        ],
                      )),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ExpansionTile(
                  collapsedBackgroundColor: Colors.brown,
                  tilePadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  title: Text(
                    'บุญมี - A122 กับ บุญรี - A123',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  children: <Widget>[
                    Text(
                      'วันที่เริ่มผสม 11/12/63',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    DataTable(
                      columns: <DataColumn>[
                        DataColumn(
                            label: Text(
                          'ชื่อกิจกรรม',
                        )),
                        DataColumn(
                            label: Text(
                          'วันที่',
                        )),
                        DataColumn(
                            label: Text(
                          'อีกกี่วัน',
                        )),
                      ],
                      rows: <DataRow>[
                        DataRow(cells: <DataCell>[
                          DataCell(Text('กลับสัด 1')),
                          DataCell(Text('4/1/2564')),
                          DataCell(
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[600],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2),
                                  )),
                              child: Text(
                                'เสร็จสิ้น',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ]),
                        DataRow(cells: <DataCell>[
                          DataCell(Text('กลับสัด 2')),
                          DataCell(Text('7/1/2564')),
                          DataCell(
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[600],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2),
                                  )),
                              child: Text(
                                'เสร็จสิ้น',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ]),
                        DataRow(cells: <DataCell>[
                          DataCell(Text('กลับสัด 3')),
                          DataCell(Text('12/1/2564')),
                          DataCell(
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[600],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2),
                                  )),
                              child: Text(
                                'เสร็จสิ้น',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ]),
                        DataRow(cells: <DataCell>[
                          DataCell(Text('ตรวจสอบการตั้งท้อง')),
                          DataCell(Text('13/1/2564')),
                          DataCell(
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  color: Colors.amber[400],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2),
                                  )),
                              child: Text(
                                'ถึงกำหนดแล้ว',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ]),
                        DataRow(cells: <DataCell>[
                          DataCell(Text('พักท้อง')),
                          DataCell(Text('14/1/2564')),
                          DataCell(
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  color: Colors.red[800],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2),
                                  )),
                              child: Text(
                                'อีก 12 วัน',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ]),
                        DataRow(cells: <DataCell>[
                          DataCell(Text('กำหนดคลอด')),
                          DataCell(Text('17/1/2564')),
                          DataCell(
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  color: Colors.red[800],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2),
                                  )),
                              child: Text(
                                'อีก 15 วัน',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ])
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(100, 10, 100, 20),
                      child: RaisedButton(
                        onPressed: () {
                          createAlertDialog(context);
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.update),
                              Text('อัพเดตตรวจสอบการตั้งท้อง')
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
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
              return RecordBreeding();
            }));
          },
        ));
  }
}
