import 'dart:convert';
import 'package:dairycattle/models/User.dart';
import 'package:dairycattle/providers/user_provider.dart';
import '/Screens/Activity/Milk/editrecordmilk.dart';
import '/models/MilkYear.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'recordmilk.dart';
import 'recordmilkDay.dart';
import 'recordmilkYear.dart';

class RecordMilkYear extends StatefulWidget {
  const RecordMilkYear({Key? key}) : super(key: key);

  @override
  _RecordMilkYearState createState() => _RecordMilkYearState();
}

class _RecordMilkYearState extends State<RecordMilkYear> {
  DateTime? now = new DateTime.now();
  var formatter = new DateFormat.yMMMMd("th_TH");
  int milks = 0;

  Future<List<MilkYear>> getMilk() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<MilkYear> milks = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'milks/year'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      milks = list.map((e) => MilkYear.fromMap(e)).toList();
    }
    return milks;
  }

  Future getCount() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    String milk = '';
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'milks/year'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      milk = db['data']['total'];

      setState(() {
        milks = int.parse(milk);
      });
    }
    return milk;
  }

  @override
  void initState() {
    super.initState();
    getMilk();
    getCount();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "จำนวนน้ำนมรวมภายในปี ${DateFormat.y("th_TH").format(DateTime.parse(now.toString()))} ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Text('${milks}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'ลิตร',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  )),
              Container(
                  child: FutureBuilder<List<MilkYear>>(
                      future: getMilk(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: Text('Loading...'),
                            ),
                          );
                        }
                        return Column(children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                return Container(
                                    child: SingleChildScrollView(
                                        child: Card(
                                            child: Column(children: [
                                  ExpansionTile(
                                    collapsedBackgroundColor:
                                        Color.fromRGBO(234, 177, 93, 5),
                                    tilePadding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    title: Text(
                                      '${snapshot.data?[i].month}  ${DateFormat.y("th_TH").format(DateTime.parse(now.toString()))}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    children: <Widget>[
                                      DataTable(
                                        columnSpacing: 20,
                                        columns: <DataColumn>[
                                          DataColumn(
                                              label: Text(
                                            'จำนวน',
                                          )),
                                        ],
                                        rows: <DataRow>[
                                          DataRow(cells: <DataCell>[
                                            DataCell(Text(
                                                '${snapshot.data?[i].sum}')),
                                          ]),
                                        ],
                                      ),
                                    ],
                                  ),
                                ]))));
                              }),
                          Container(
                            height: 400,
                          )
                        ]);
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
