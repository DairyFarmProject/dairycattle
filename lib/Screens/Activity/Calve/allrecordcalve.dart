import 'dart:convert';
import 'package:dairycattle/models/DistinctCowAb.dart';

import '../../Activity/Calve/recordcalve.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'cowcalve.dart';

class AllRecordCalve extends StatefulWidget {
  const AllRecordCalve({Key? key}) : super(key: key);

  @override
  _AllRecordCalveState createState() => _AllRecordCalveState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
void showInSnackBar(String value) {
  _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
}

class _AllRecordCalveState extends State<AllRecordCalve> {
  List<DistinctCowAb> ab = [];
  String? have;

  Future<List<DistinctCowAb>> getAbdominal() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<DistinctCowAb> adbs = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'farms/parturition/cows'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      if (db['data']['row'] != null) {
        final List list = db['data']['rows'];
        adbs = list.map((e) => DistinctCowAb.fromMap(e)).toList();
        if (mounted) {
          setState(() {
            ab = adbs;
          });
        }
      }
      if (db['data']['row'] == null) {
        if (mounted) {
          setState(() {
            have = '0';
          });
        }
      }
    }
    return adbs;
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
          title: const Text("บันทึกการคลอด"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xff5a82de),
        ),
        body: FutureBuilder<List<DistinctCowAb>>(
            future: getAbdominal(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: (have == '0')
                        ? Container()
                        : const Center(
                            child: CircularProgressIndicator(
                            color: Colors.blue,
                          )));
              }
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.86,
                            height: 150,
                            decoration: BoxDecoration(
                              color: const Color(0xff5a82de),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CowCalve(ab: snapshot.data![i])));
                              },
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 0, 10, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data![i].cow_name,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                            ),
                                            Text('${snapshot.data?[i].cow_no}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            topLeft: Radius.circular(20)),
                                        color: Colors.blue[100],
                                      ),
                                      height: 150,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 0,
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 20),
                                            alignment: Alignment.center,
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 0),
                                              child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      snapshot
                                                          .data![i].cow_image),
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
          label: const Text(
            ' เพิ่มการบันทึกข้อมูล',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 14),
          ),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.brown,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RecordCalve();
            }));
          },
        ));
  }
}
