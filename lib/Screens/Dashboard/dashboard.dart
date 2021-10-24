import 'package:dairycattle/Screens/Cow/cow1.dart';
import 'package:dairycattle/Screens/Dashboard/cow_chart.dart';
import 'package:dairycattle/Screens/Dashboard/ref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../navigator.dart';
import '../../providers/user_provider.dart';
import '../../models/User.dart';
import 'package:fl_chart/fl_chart.dart';

import 'milk_chart.dart';

class Dashboard extends StatefulWidget {
  // final User user;
  //Dashboard({Key? key, required this.user}) : super(key: key);
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
              child: MilkChart(),
            ),
          ),
        ],
      ),
    );
  }
}
