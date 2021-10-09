
class Status {
  const Status(this.name);
  final String name;
}

class Type {
  const Type(this.name);
  final String name;
}

class Specie {
  const Specie(this.name);
  final String name;
}

class Sex {
  const Sex(this.name);
  final String name;
}

List<Status> statuses = <Status>[
    Status('ขายออก'),
    Status('ป่วย'),
    Status('โคแก่'),
    Status('ตาย'),
    Status('อื่น ๆ')
  ];

List<Type> types = <Type>[
    Type('ลูกโค'),
    Type('โคสาว'),
    Type('โคท้อง'),
    Type('โคแก่'),
    Type('โคผสมพันธุ์'),
    Type('โคแห้งนม')
  ];

List<Specie> species = <Specie>[
    Specie('ไทยฟรีเชียน'),
    Specie('ที เอ็ม แซด'),
    Specie('โฮลสไตน์ฟรีเชี่ยน'),
    Specie('ซาฮิวาล'),
    Specie('เรดเดน'),
    Specie('บราวน์สวิส'),
    Specie('เจอร์ซี่'),
    Specie('เรดซินดี'),
    Specie('ไอร์ไชร์'),
    Specie('ครอซบรีด'),
    Specie('เรด โฮลสไตน์'),
    Specie('กีย์นม'),
    Specie('เกิร์นซีย์'),
  ];

List<Sex> sexs = <Sex>[
    Sex('เพศผู้'),
    Sex('เพศเมีย'),
  ];

