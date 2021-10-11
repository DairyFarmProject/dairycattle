
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

class DadSpecie {
  const DadSpecie(this.name);
  final String name;
}

class MomSpecie {
  const MomSpecie(this.name);
  final String name;
}

class Sex {
  const Sex(this.name);
  final String name;
}

class Vaccine {
  const Vaccine(this.name);
  final String name;
}

List<Status> statuses = <Status>[
    Status('ปกติ'),
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

List<DadSpecie> semen_species = <DadSpecie>[
    DadSpecie('ไทยฟรีเชียน'),
    DadSpecie('ที เอ็ม แซด'),
    DadSpecie('โฮลสไตน์ฟรีเชี่ยน'),
    DadSpecie('ซาฮิวาล'),
    DadSpecie('เรดเดน'),
    DadSpecie('บราวน์สวิส'),
    DadSpecie('เจอร์ซี่'),
    DadSpecie('เรดซินดี'),
    DadSpecie('ไอร์ไชร์'),
    DadSpecie('ครอซบรีด'),
    DadSpecie('เรด โฮลสไตน์'),
    DadSpecie('กีย์นม'),
    DadSpecie('เกิร์นซีย์'),
  ];

List<MomSpecie> mom_species = <MomSpecie>[
    MomSpecie('ไทยฟรีเชียน'),
    MomSpecie('ที เอ็ม แซด'),
    MomSpecie('โฮลสไตน์ฟรีเชี่ยน'),
    MomSpecie('ซาฮิวาล'),
    MomSpecie('เรดเดน'),
    MomSpecie('บราวน์สวิส'),
    MomSpecie('เจอร์ซี่'),
    MomSpecie('เรดซินดี'),
    MomSpecie('ไอร์ไชร์'),
    MomSpecie('ครอซบรีด'),
    MomSpecie('เรด โฮลสไตน์'),
    MomSpecie('กีย์นม'),
    MomSpecie('เกิร์นซีย์'),
  ];

List<Sex> sexs = <Sex>[
    Sex('เพศผู้'),
    Sex('เพศเมีย'),
  ];

List<Vaccine> vacs = <Vaccine>[
    Vaccine('ไข้ขา'),
    Vaccine('คอบวม'),
    Vaccine('กาลี'),
    Vaccine('ปากเท้าเปื่อย'),
    Vaccine('ผิวหนังที่เป็นก้อน'),
    Vaccine('อัลเบนดาโซล'),
    Vaccine('ไอเวอร์เมคติน'),
  ];

