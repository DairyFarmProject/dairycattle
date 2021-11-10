import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '/models/CowCount.dart';
import 'package:flutter/material.dart';

class CowChart extends StatefulWidget {
  const CowChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CowChartState();
}

class CowChartState extends State<CowChart> {
  List<CowCount> cows = [];
  List list = [];
  String count = '';

  Future<List<CowCount>> getCow() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'cows/count'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic>? db = jsonDecode(response.body);
      list = db?['data']['rows'];
      List<CowCount> cow = list.map((e) => CowCount.fromMap(e)).toList();
      setState(() {
        cows = cow;
      });
    }
    return cows;
  }

  Future getCount() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'cows/count'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic>? db = jsonDecode(response.body);
      String counts = db?['data']['total'];

      setState(() {
        count = counts;
      });
    }
    return count;
  }

  @override
  void initState() {
    super.initState();
    getCow();
    getCount();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      //color: Color.fromRGBO(222, 222, 222, 5),
      decoration: const BoxDecoration(color: Colors.white30),
      height: MediaQuery.of(context).size.height * 0.30,
      child: (count.isEmpty)
          ? Center(
              child: Container(
              width: MediaQuery.of(context).size.height * 0.1,
              height: MediaQuery.of(context).size.height * 0.1,
              child: const CircularProgressIndicator(
                color: Colors.brown,
              ),
            ))
          : Column(
              children: <Widget>[
                Flexible(
                    child: Row(children: <Widget>[
                  _buildStatCard(
                      'จำนวนวัวทั้งหมด', count, Colors.brown.shade300),
                ])),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard(cows[5].type_name, '${cows[5].count}',
                          Colors.deepPurple.shade200),
                      _buildStatCard(cows[4].type_name, '${cows[4].count}',
                          Colors.pink.shade100),
                      _buildStatCard(cows[3].type_name, '${cows[3].count}',
                          Color.fromRGBO(234, 177, 93, 5)),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard(cows[2].type_name, '${cows[2].count}',
                          Color.fromRGBO(111, 193, 148, 5)),
                      _buildStatCard(cows[1].type_name, '${cows[1].count}',
                          Color.fromRGBO(93, 124, 234, 5)),
                      _buildStatCard(cows[0].type_name, '${cows[0].count}',
                          Color.fromRGBO(185, 110, 110, 5)),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Expanded _buildStatCard(String title, String count, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
