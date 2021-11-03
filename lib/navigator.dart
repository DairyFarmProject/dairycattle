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

int _selectIndex = 0;

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Text('ฟาร์ม'),
    Text('วัว'),
    Text('กิจกรรม'),
    Text('แจ้งเตือน'),
    Text('ฉัน'),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<AppBar> _appBarList = [
    AppBar(
      automaticallyImplyLeading: false,
      title: Text('ภาพรวมฟาร์ม'),
      backgroundColor: Colors.brown[500],
    ),
    AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      //titleTextStyle: TextStyle(fontWeight: FontWeight.w700),
      title: Text("วัวในฟาร์ม"),
      actions: [
        PopupMenuButton<String>(
          offset: Offset(100, 38),
          icon: Icon(Icons.sort),
          itemBuilder: (BuildContext context) {
            return {'อายุ : มาก - น้อย', 'อายุ : น้อย - มาก', 'ประเภทวัว'}
                .map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        )
      ],
      backgroundColor: Colors.brown[500],
    ),
    AppBar(
      automaticallyImplyLeading: false,
      title: Text('เพิ่มกิจกรรม'),
      backgroundColor: Colors.brown[500],
    ),
    AppBar(
      automaticallyImplyLeading: false,
      title: Text('การแจ้งเตือน'),
      backgroundColor: Colors.brown[500],
    ),
    AppBar(
      automaticallyImplyLeading: false,
      title: Text('ข้อมูลส่วนตัว'),
      backgroundColor: Colors.brown[500],
    ),
  ];

  int _selectPage = 0;

  final _pageOptions = [
    Dashboard(),
    Cow(),
    AddActivity(),
    Notifications(),
    FarmData(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          backgroundColor: Color(0xff62b490),
        ),
      ),
    );
  }
}
