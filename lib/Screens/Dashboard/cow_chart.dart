import '/Screens/Activity/Breeding/allrecordbreeding.dart';
import '/Screens/Activity/Milk/recordmilkDay.dart';
import '/Screens/Cow/cow1.dart';
import '/Screens/Cow/onecow.dart';
import '/Screens/Activity/Calve/allrecordcalve.dart';

import 'package:flutter/material.dart';

class CowChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      //color: Color.fromRGBO(222, 222, 222, 5),
      decoration: BoxDecoration(color: Colors.white30),
      height: MediaQuery.of(context).size.height * 0.27,
      child: Column(
        children: <Widget>[
          Text(''),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                    'จำนวนวัวทั้งหมด', '50 ตัว', Colors.brown.shade300),
                _buildStatCard(
                  'แม่โค',
                  '30 ตัว',
                  Color.fromRGBO(234, 177, 93, 5),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                    'โคสาว', '10 ตัว', Color.fromRGBO(111, 193, 148, 5)),
                _buildStatCard(
                    'โคแก่', '2 ตัว', Color.fromRGBO(93, 124, 234, 5)),
                _buildStatCard(
                    'โคเด็ก', '8 ตัว', Color.fromRGBO(185, 110, 110, 5)),
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
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
