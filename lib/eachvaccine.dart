import 'dart:convert';
import 'dart:math';

import '/editrecordvaccine.dart';
import '/models/Vaccine_schedule.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'models/User.dart';
import 'recordvaccine.dart';

class EachVaccine extends StatefulWidget {
  const EachVaccine({Key? key}) : super(key: key);

  @override
  _EachVaccineState createState() => _EachVaccineState();
}

class _EachVaccineState extends State<EachVaccine> {
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
  _EachVaccineState createState() => _EachVaccineState();
  void initState() {
    super.initState();
    getVacS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("บันทึกการฉีดวัคซีน"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(111, 193, 148, 5)),
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
                      margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(50, 25, 50, 0),
                            margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.brown,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                    'วันที่ฉีด : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.data![i].vac_date.toString()))}'),
                                Text(
                                    'ชื่อวัคซีน : ${snapshot.data?[i].vac_name_th}'),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            // alignment: Alignment.centerLeft,
                            child: Text(
                                'นัดหมายครั้งถัดไป : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.data![i].next_date.toString()))}'),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'วัวที่ได้รับการฉีด ',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.centerLeft,
                            child: Text('${snapshot.data?[i].cow_name}'),
                          ),
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
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.brown,
                                              ),
                                            ),
                                            Text(
                                              'ลบข้อมูล',
                                              style: TextStyle(
                                                  color: Colors.brown,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                      )
                                    ],
                                  )),
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  child: Column(
                                    children: [
                                      // ignore: deprecated_member_use

                                      RaisedButton(
                                        onPressed: () {},
                                        color: Colors.brown,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(39))),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                'แก้ไข',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 12, 30, 12),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      )),
                    );
                  });
          }),
    );
  }
}
