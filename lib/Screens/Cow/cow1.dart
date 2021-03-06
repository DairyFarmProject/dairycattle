import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/models/Cows.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'onecow.dart';

class Cow extends StatefulWidget {
  @override
  _CowState createState() => _CowState();
}

class _CowState extends State<Cow> {
  List<Cows> cow = [];

  Future<List<Cows>> getCow() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Cows> cows = [];
    Map data = {
      'user_id': user?.user_id.toString(),
      'farm_id': user?.farm_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'farms/cow'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      cows = list.map((e) => Cows.fromMap(e)).toList();
      if (mounted) {
        setState(() {
          cow = cows;
        });
      }
    }
    return cow;
  }

  @override
  void initState() {
    super.initState();
    getCow();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(0),
      child: (cow.isEmpty)
          ? Center()
          : FutureBuilder<List<Cows>>(
              future: getCow(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                }
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return Padding(
                          padding: const EdgeInsets.all(0),
                          child: Center(
                              child: Column(
                            children: [
                              Center(
                                  child: Card(
                                elevation: 1,
                                margin: const EdgeInsets.only(top: 3),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OneCow(
                                                cow: snapshot.data![i])));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Hero(
                                          tag: i.toString(),
                                          child: Column(children: [
                                            Image.network(
                                              snapshot.data?[i].cow_image ?? "",
                                              width: 180,
                                              height: 140,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox.fromSize(
                                                size: const Size(180, 8)),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 0, 12),
                                                child: Text(
                                                  '${snapshot.data?[i].cow_name ?? ""}, ${snapshot.data?[i].cow_no}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                )),
                                          ]))
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          )));
                    });
              }),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
