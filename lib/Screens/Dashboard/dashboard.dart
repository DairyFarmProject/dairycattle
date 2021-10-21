import 'package:dairycattle/Screens/Dashboard/cow_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../navigator.dart';
import '../../providers/user_provider.dart';
import '../../models/User.dart';
import 'package:fl_chart/fl_chart.dart';

import 'milk_chart.dart';

class Dashboard extends StatefulWidget {
  // final User user;
  // Dashboard({Key? key, required this.user}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      //backgroundColor: Palette.primaryColor,
      //appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: CowChart(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
                //child: MilkChart(),
                ),
          ),
        ],
      ),
    );
  }
}

// class MilkChart extends StatelessWidget {
//   const MilkChart({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(3),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: Offset(0, 2), // changes position of shadow
//               ),
//             ],
//           ),
//           margin: EdgeInsets.all(20),
//           width: 350,
//           height: 200,
//           child: BarChart(
//             BarChartData(
//                 barTouchData: barTouchData,
//                 titlesData: titlesData,
//                 borderData: borderData,
//                 barGroups: barGroups,
//                 alignment: BarChartAlignment.spaceAround,
//                 maxY: 20,
//                 minY: 3),
//           ),
//         ),
//       ],
//     );
//   }

//   BarTouchData get barTouchData => BarTouchData(
//         enabled: false,
//         touchTooltipData: BarTouchTooltipData(
//           tooltipBgColor: Colors.transparent,
//           tooltipPadding: const EdgeInsets.all(0),
//           tooltipMargin: 10,
//           getTooltipItem: (
//             BarChartGroupData group,
//             int groupIndex,
//             BarChartRodData rod,
//             int rodIndex,
//           ) {
//             return BarTooltipItem(
//               rod.y.round().toString(),
//               TextStyle(
//                 color: Colors.blueGrey,
//                 fontWeight: FontWeight.w500,
//               ),
//             );
//           },
//         ),
//       );

//   FlTitlesData get titlesData => FlTitlesData(
//         show: true,
//         bottomTitles: SideTitles(
//           showTitles: true,
//           getTextStyles: (context, value) => const TextStyle(
//             color: Color(0xff7589a2),
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//           ),
//           margin: 20,
//           getTitles: (double value) {
//             switch (value.toInt()) {
//               case 0:
//                 return 'Mn';
//               case 1:
//                 return 'Te';
//               case 2:
//                 return 'Wd';
//               case 3:
//                 return 'Tu';
//               case 4:
//                 return 'Fr';
//               case 5:
//                 return 'St';
//               case 6:
//                 return 'Sn';
//               default:
//                 return '';
//             }
//           },
//         ),
//         leftTitles: SideTitles(showTitles: false),
//         topTitles: SideTitles(showTitles: false),
//         rightTitles: SideTitles(showTitles: false),
//       );

//   FlBorderData get borderData => FlBorderData(
//         show: false,
//       );

//   List<BarChartGroupData> get barGroups => [
//         BarChartGroupData(
//           x: 0,
//           barRods: [
//             BarChartRodData(
//                 y: 8, colors: [Colors.lightBlueAccent, Colors.greenAccent])
//           ],
//           showingTooltipIndicators: [0],
//         ),
//         BarChartGroupData(
//           x: 1,
//           barRods: [
//             BarChartRodData(
//                 y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
//           ],
//           showingTooltipIndicators: [0],
//         ),
//         BarChartGroupData(
//           x: 2,
//           barRods: [
//             BarChartRodData(
//                 y: 14, colors: [Colors.lightBlueAccent, Colors.greenAccent])
//           ],
//           showingTooltipIndicators: [0],
//         ),
//         BarChartGroupData(
//           x: 3,
//           barRods: [
//             BarChartRodData(
//                 y: 15, colors: [Colors.lightBlueAccent, Colors.greenAccent])
//           ],
//           showingTooltipIndicators: [0],
//         ),
//         BarChartGroupData(
//           x: 4,
//           barRods: [
//             BarChartRodData(
//                 y: 13, colors: [Colors.lightBlueAccent, Colors.greenAccent])
//           ],
//           showingTooltipIndicators: [0],
//         ),
//         BarChartGroupData(
//           x: 5,
//           barRods: [
//             BarChartRodData(
//                 y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
//           ],
//           showingTooltipIndicators: [0],
//         ),
//         BarChartGroupData(
//           x: 6,
//           barRods: [
//             BarChartRodData(
//                 y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
//           ],
//           showingTooltipIndicators: [0],
//         ),
//       ];
// }

// class BarChartSample3 extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => BarChartSample3State();
// }

// class BarChartSample3State extends State<BarChartSample3> {
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.7,
//       child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//         color: const Color(0xff2c4260),
//         child: const MilkChart(),
//       ),
//     );
//   }
// }
