import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import '/models/MilkWeek.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MilkChart extends StatefulWidget {
  const MilkChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MilkChartState();
}

class MilkChartState extends State<MilkChart> {
  final Color barBackgroundColor = Colors.brown;
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;
  List<MilkWeek> milks = [];
  List list = [];
  Map<String, dynamic>? db;

  Future<List<MilkWeek>> getMilk() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'milks/week'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      db = jsonDecode(response.body);
      list = db?['data']['rows'];
      List<MilkWeek> milk = list.map((e) => MilkWeek.fromMap(e)).toList();

      if (mounted) {
        setState(() {
          milks = milk;
        });
      }
    }
    return milks;
  }

  @override
  void initState() {
    super.initState();
    getMilk();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.grey[300],
        child: (milks.isEmpty)
            ? Container(
                padding: const EdgeInsets.all(150),
                child: const CircularProgressIndicator(
                  color: Colors.brown,
                ),
              )
            : Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const Text(
                          'จำนวนน้ำนมวัว (ลิตร)',
                          style: TextStyle(
                              color: Colors.brown,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'วันที่ ${DateFormat('dd/MM/yyyy').format(DateTime.parse(milks[0].date))} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(milks[6].date))}',
                          style: const TextStyle(
                              color: Colors.brown,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BarChart(
                              mainBarData(),
                              swapAnimationDuration: animDuration,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                    ),
                  )
                ],
              ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          borderSide: isTouched
              ? const BorderSide(color: Colors.yellow, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 100,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, milks[0].total.toDouble(),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, milks[1].total.toDouble(),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, milks[2].total.toDouble(),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, milks[3].total.toDouble(),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, milks[4].total.toDouble(),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, milks[5].total.toDouble(),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, milks[6].total.toDouble(),
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'อาทิตย์';
                  break;
                case 1:
                  weekDay = 'จันทร์';
                  break;
                case 2:
                  weekDay = 'อังคาร';
                  break;
                case 3:
                  weekDay = 'พุธ';
                  break;
                case 4:
                  weekDay = 'พฤหัสบดี';
                  break;
                case 5:
                  weekDay = 'ศุกร์';
                  break;
                case 6:
                  weekDay = 'เสาร์';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return DateFormat('dd').format(DateTime.parse(milks[0].date));
              case 1:
                return DateFormat('dd').format(DateTime.parse(milks[1].date));
              case 2:
                return DateFormat('dd').format(DateTime.parse(milks[2].date));
              case 3:
                return DateFormat('dd').format(DateTime.parse(milks[3].date));
              case 4:
                return DateFormat('dd').format(DateTime.parse(milks[4].date));
              case 5:
                return DateFormat('dd').format(DateTime.parse(milks[5].date));
              case 6:
                return DateFormat('dd').format(DateTime.parse(milks[6].date));
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}
