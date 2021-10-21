import 'dart:convert';

import '/models/Worker.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AcceptMember extends StatefulWidget {
  @override
  _AcceptMemberState createState() => _AcceptMemberState();
}

class _AcceptMemberState extends State<AcceptMember> {
  Future<List<Worker>> getWorker() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    late List<Worker> vacs;
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(Uri.http('127.0.0.1:3000', 'farm/workers'),
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
      vacs = list.map((e) => Worker.fromMap(e)).toList();
    }
    return vacs;
  }

  @override
  Uri? url;
  void initState() {
    super.initState();
    getWorker();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
        body: Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Column(
                      children: [
                        Text(
                          'สมาชิกทั้งหมด',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        FutureBuilder<List<Worker>>(
                            future: getWorker(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Container();
                              } else
                                return SingleChildScrollView(
                                    child: DataTable(
                                        columnSpacing: 50,
                                        columns: <DataColumn>[
                                          DataColumn(
                                              label: Text(
                                            '',
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'ชื่อ',
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'ตำแหน่ง',
                                          )),
                                        ],
                                        rows: snapshot.data!.map<DataRow>((e) {
                                          return DataRow(
                                            cells: <DataCell>[
                                              DataCell(
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: NetworkImage(
                                                      '${e.user_image}'),
                                                ),
                                              ),
                                              DataCell(Text('${e.firstname}')),
                                              DataCell(Text('${e.role_name}')),
                                            ],
                                          );
                                        }).toList()));
                            })
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  userAccpt() async {}
}
