import '/Screens/Activity/addactivity.dart';
import '/Screens/Cow/cow1.dart';
import '/Screens/member/farm_data_member.dart';
import '/notification.dart';
import 'package:flutter/material.dart';

class Homepage_Member extends StatefulWidget {
  @override
  _Homepage_MemberState createState() => _Homepage_MemberState();
}

int _selectIndex = 0;

class _Homepage_MemberState extends State<Homepage_Member> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Text('วัวของฉัน'),
    Text('เพิ่มกิจกรรม'),
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
    Cow(),
    AddActivity(),
    Notifications(),
    FarmData_member(),
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
    );
  }
}
