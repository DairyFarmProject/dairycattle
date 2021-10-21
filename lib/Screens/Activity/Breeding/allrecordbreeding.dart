import 'dart:convert';

import 'package:dairycattle/models/DistinctCowAb.dart';

import '/Screens/Activity/Breeding/datebreeding.dart';
import '/Screens/Activity/Breeding/recordbreeding.dart';
import '/models/Abdominal.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AllRecordBreeding extends StatefulWidget {
  @override
  _AllRecordBreedingState createState() => _AllRecordBreedingState();
}

class _AllRecordBreedingState extends State<AllRecordBreeding> {
  Future<List<DistinctCowAb>> getAbdominal() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    late List<DistinctCowAb> adb;
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response =
        await http.post(Uri.http('127.0.0.1:3000', 'farms/abdominal/cows'),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      adb = list.map((e) => DistinctCowAb.fromMap(e)).toList();
    }
    return adb;
  }

  @override
  void initState() {
    super.initState();
    getAbdominal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("บันทึกการผสมพันธุ์"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(185, 110, 110, 5),
        ),
        body: FutureBuilder<List<DistinctCowAb>>(
            future: getAbdominal(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container();
              } else
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return Container(
                          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
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
                                color: Color.fromRGBO(185, 110, 110, 5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DateBreeding(
                                              ab: snapshot.data![i])));
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
                                                '${snapshot.data![i].cow_name}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                  '${snapshot.data?[i].cow_no}',
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
                                          color: Colors.red[100],
                                        ),
                                        height: 150,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 0,
                                              padding: EdgeInsets.only(
                                                  left: 0, right: 20),
                                              alignment: Alignment.center,
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        end: 0),
                                                child: CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        '${snapshot.data![i].cow_image}'),
                                                    radius: 90.0)),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ));
                    });
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
              return RecordBreeding();
            }));
          },
        ));
  }
}
