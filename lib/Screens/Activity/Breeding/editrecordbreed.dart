import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';
import '/Screens/Cow/successrecord.dart';
import '/main.dart';
import 'package:flutter/material.dart';

class EditRecordBreed extends StatefulWidget {
  const EditRecordBreed({Key? key}) : super(key: key);

  @override
  _EditRecordBreedState createState() => _EditRecordBreedState();
}

class _EditRecordBreedState extends State<EditRecordBreed> {
  DateTime? _dateTime;

  String n1 = 'มูมู้';
  String c1 = 'A121';
  String n2 = 'บุญเกิด';
  String c2 = 'A122';
  String n3 = 'บุญมี';
  String c3 = 'A123';
  String n4 = 'บุญจัง';
  String c4 = 'A124';
  String A = 'อื่นๆ';

  bool isShowOtherField = false;

  int _counter = 0;

  increment() => setState(() {
        _counter++;
      });

  decrement() => setState(() {
        _counter--;
      });

  //selectother(String data){
  //  if(data==A){
  //   return
  // }
  //}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('แก้ไขบันทึกการผสมพันธ์'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: [n1 + c1, n2 + c2, n3 + c3, n4 + c4, A],
                  label: "ชื่อวัว",
                  popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: (String? selectedCow) async {
                    if (selectedCow == A) {
                      setState(() async {
                        isShowOtherField = true;
                      });
                    }
                  },
                  selectedItem: n4 + c4),
              padding: const EdgeInsets.all(20.0),
            ),
            Visibility(
              visible: isShowOtherField,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'ชื่อวัว',
                      fillColor: Colors.blueGrey,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 2),
                      )),
                  onChanged: (String name) {},
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(0),
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Text(
                    'รอบการผสมพันธ์',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: IconButton(
                        icon: Icon(
                          Icons.indeterminate_check_box,
                          color: Colors.blueGrey,
                        ),
                        onPressed: decrement,
                      )),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: Text('$_counter'),
                  ),
                  Padding(
                      padding: EdgeInsets.all(0),
                      child: IconButton(
                        icon: Icon(
                          Icons.add_box,
                          color: Colors.blueGrey,
                        ),
                        onPressed: increment,
                      )),
                ])
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: [n1 + c1, n2 + c2, n3 + c3, n4 + c4, A],
                  label: "ชื่อพ่อพันธ์",
                  // popupItemDisabled: (String s) => s.startsWith('I'),
                  popupItemDisabled: (String s) {
                    return s.startsWith('I');
                  },
                  onChanged: (String? selectedCow) {
                    if (selectedCow == A) {
                      setState(() {
                        isShowOtherField = true;
                      });
                    }
                  },
                  selectedItem: n4 + c4),
              padding: const EdgeInsets.all(20.0),
            ),
            Visibility(
              visible: isShowOtherField,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'ชื่อพ่อพันธ์',
                      fillColor: Colors.blueGrey,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 2),
                      )),
                  onChanged: (String name) {},
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(0),
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Text('วันที่',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                      child: Text(
                        _dateTime == null ? 'yyyy/mm/dd' : _dateTime.toString(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: IconButton(
                        icon: Icon(
                          Icons.calendar_today_sharp,
                          color: Colors.blueGrey,
                        ),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1970),
                            lastDate: DateTime(2022),
                          ).then((date) {
                            setState(() {
                              _dateTime = date;
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'รายละเอียดอื่นๆ',
                        fillColor: Colors.blueGrey,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey, width: 2),
                        )),
                    onChanged: (String name) {},
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ignore: deprecated_member_use
                            RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Colors.blueGrey[50],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(39))),
                              child: Text(
                                'ยกเลิก',
                                style: TextStyle(
                                    color: Color(0xffd6786e),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Column(
                          children: [
                            // ignore: deprecated_member_use

                            RaisedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SuccessRecord();
                                }));
                              },
                              color: Color(0xff62b490),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(39))),
                              child: Text(
                                'บันทึกข้อมูล',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 12, 20, 12),
                            )
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
