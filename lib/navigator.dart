import 'package:dairycattle/Screens/Cow/cow2.dart';

import '/Screens/Profile/Farm_data.dart';
import 'Screens/Dashboard/dashboard.dart';
import '/notification.dart';
import 'package:flutter/material.dart';
import 'Screens/Activity/addactivity.dart';
import 'Screens/Cow/addcow1.dart';
import 'Screens/Cow/cow1.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  int _selectPage = 0;

  final _pageOptions = [
    Dashboard(),
    Cow(),
    AddActivity(),
    Notifications(),
    const FarmData(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      const Text('ฟาร์ม'),
      const Text('วัว'),
      const Text('กิจกรรม'),
      const Text('แจ้งเตือน'),
      const Text('ฉัน'),
    ];

    final List<AppBar> _appBarList = [
      AppBar(
        automaticallyImplyLeading: false,
        title: const Text('ภาพรวมฟาร์ม'),
        backgroundColor: Colors.brown[500],
      ),
      AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        //titleTextStyle: TextStyle(fontWeight: FontWeight.w700),
        title: const Text("วัวในฟาร์ม"),
        actions: [
          PopupMenuButton<String>(
            offset: const Offset(100, 38),
            icon: const Icon(Icons.sort),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                  value: '/cow5', child: Text('อายุ : มาก - น้อย')),
              const PopupMenuItem<String>(
                  value: '/cow2', child: Text('อายุ : น้อย - มาก')),
              const PopupMenuItem<String>(
                  value: '/cow3', child: Text('วัว : เก่า - ใหม่')),
              const PopupMenuItem<String>(
                  value: '/cow4', child: Text('วัว : ใหม่ - เก่า')),
            ],
            onSelected: (filter) {
              Navigator.pushNamed(context, filter);
            },
          )
        ],
        backgroundColor: Colors.brown[500],
      ),
      AppBar(
        automaticallyImplyLeading: false,
        title: const Text('เพิ่มกิจกรรม'),
        backgroundColor: Colors.brown[500],
      ),
      AppBar(
        automaticallyImplyLeading: false,
        title: const Text('การแจ้งเตือน'),
        backgroundColor: Colors.brown[500],
      ),
      AppBar(
        automaticallyImplyLeading: false,
        title: const Text('ข้อมูลส่วนตัว'),
        backgroundColor: Colors.brown[500],
      ),
    ];

    return MaterialApp(
        home: Scaffold(
      appBar: _appBarList[_selectPage],
      body: _pageOptions[_selectPage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            print('page:$index');
            _selectPage = index;
          });
        },
        selectedItemColor: Colors.brown[500],
        unselectedItemColor: Colors.blueGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ภาพรวม',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/icon_cow.png")),
            label: 'วัวของฉัน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add),
            label: 'เพิ่มกิจกรรม',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'แจ้งเตือน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'ฉัน',
          ),
        ],
        currentIndex: _selectPage,
      ),
      floatingActionButton: Visibility(
        visible: _selectPage == 1,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddCow();
            }));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
          backgroundColor: const Color(0xff62b490),
        ),
      ),
    ));
  }
}
