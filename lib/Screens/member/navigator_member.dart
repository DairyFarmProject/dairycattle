import '/Screens/Farm/confirm_create_farm.dart';
import '/Screens/Welcome/otp.dart';
import '/Screens/Welcome/register.dart';
import '/Screens/Cow/addcow1.dart';
import '/Screens/Cow/cow2.dart';
import '/Screens/Cow/cow3.dart';
import '/Screens/Cow/cow4.dart';
import '/Screens/Cow/cow5.dart';
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

  int _selectPage = 0;

  final _pageOptions = [
    Cow(),
    AddActivity(),
    Notifications(),
    const FarmData_member(),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      const Text('วัว'),
      const Text('กิจกรรม'),
      const Text('แจ้งเตือน'),
      const Text('ฉัน'),
    ];

    List<AppBar> _appBarList = [
      AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
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
              Navigator.of(context).pushNamed(filter);
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
        theme: ThemeData(fontFamily: 'Mitr'),
        initialRoute: '/',
        routes: {
          ConfirmCreateFarm.routeName: (context) => ConfirmCreateFarm(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          OTP.routeName: (context) => OTP(),
          Cow2.routeName: (context) => Cow2(),
          Cow3.routeName: (context) => Cow3(),
          Cow4.routeName: (context) => Cow4(),
          Cow5.routeName: (context) => Cow5(),
        },
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
            visible: _selectPage == 0,
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
