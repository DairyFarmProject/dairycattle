import 'dart:convert';
import '/models/DistinctCowVac.dart';
import '/Screens/Activity/Vaccine/eachvaccine.dart';
import '/models/DistinctVac.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/models/User.dart';
import 'recordvaccine.dart';

class VaccineCow extends StatefulWidget {
  final DistinctVac vac;
  VaccineCow({required this.vac});

  @override
  _VaccineCowState createState() => _VaccineCowState();
}

class _VaccineCowState extends State<VaccineCow> {
  List<DistinctCowVac> vac = [];

  Future<List<DistinctCowVac>> getVacS() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<DistinctCowVac> vacs = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString(),
      'vaccine_id': widget.vac.vaccine_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'farm/distinct/cow'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      vacs = list.map((e) => DistinctCowVac.fromMap(e)).toList();
      if (mounted) {
        setState(() {
          vac = vacs;
        });
      }
    }
    return vacs;
  }

  @override
  _VaccineCowState createState() => _VaccineCowState();
  void initState() {
    super.initState();
    getVacS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('บันทึกการฉีดวัคซีน'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromRGBO(111, 193, 148, 5),
        ),
        body: FutureBuilder<List<DistinctCowVac>>(
            future: getVacS(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center();
              }
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return Container(
                        margin: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                        child: SingleChildScrollView(
                            child: Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.86,
                            height: 150,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(111, 193, 148, 5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EachVaccine(
                                            vac: snapshot.data![i])));
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
                                                '${snapshot.data?[i].cow_name}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20)),
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
                                        color: Colors.green[100],
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
                        )));
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
              return RecordVacine();
            }));
          },
        ));
  }
}
