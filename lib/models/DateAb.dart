import 'dart:convert';

class DateAb {
  int abdominal_id;
  int cow_id;
  int round;
  String ab_date;
  String ab_status;
  String ab_caretaker;
  String semen_id;
  String semen_name;
  int semen_specie;
  String ab_calf;
  String note;
  int type_id;
  int specie_id;
  int farm_id;
  int status_id;
  String cow_no;
  String cow_name;
  String cow_birthday;
  String cow_sex;
  String mom_id;
  int mom_specie;
  String cow_image;
  String firstHeat;
  int firstcount;
  String secondHeat;
  int secondcount;
  String thirdHeat;
  int thirdcount;
  String dryDate;
  int drycount;
  String parDate;
  int parcount;
  DateAb({
    required this.abdominal_id,
    required this.cow_id,
    required this.round,
    required this.ab_date,
    required this.ab_status,
    required this.ab_caretaker,
    required this.semen_id,
    required this.semen_name,
    required this.semen_specie,
    required this.ab_calf,
    required this.note,
    required this.type_id,
    required this.specie_id,
    required this.farm_id,
    required this.status_id,
    required this.cow_no,
    required this.cow_name,
    required this.cow_birthday,
    required this.cow_sex,
    required this.mom_id,
    required this.mom_specie,
    required this.cow_image,
    required this.firstHeat,
    required this.firstcount,
    required this.secondHeat,
    required this.secondcount,
    required this.thirdHeat,
    required this.thirdcount,
    required this.dryDate,
    required this.drycount,
    required this.parDate,
    required this.parcount,
  });
  

  DateAb copyWith({
    int? abdominal_id,
    int? cow_id,
    int? round,
    String? ab_date,
    String? ab_status,
    String? ab_caretaker,
    String? semen_id,
    String? semen_name,
    int? semen_specie,
    String? ab_calf,
    String? note,
    int? type_id,
    int? specie_id,
    int? farm_id,
    int? status_id,
    String? cow_no,
    String? cow_name,
    String? cow_birthday,
    String? cow_sex,
    String? mom_id,
    int? mom_specie,
    String? cow_image,
    String? firstHeat,
    int? firstcount,
    String? secondHeat,
    int? secondcount,
    String? thirdHeat,
    int? thirdcount,
    String? dryDate,
    int? drycount,
    String? parDate,
    int? parcount,
  }) {
    return DateAb(
      abdominal_id: abdominal_id ?? this.abdominal_id,
      cow_id: cow_id ?? this.cow_id,
      round: round ?? this.round,
      ab_date: ab_date ?? this.ab_date,
      ab_status: ab_status ?? this.ab_status,
      ab_caretaker: ab_caretaker ?? this.ab_caretaker,
      semen_id: semen_id ?? this.semen_id,
      semen_name: semen_name ?? this.semen_name,
      semen_specie: semen_specie ?? this.semen_specie,
      ab_calf: ab_calf ?? this.ab_calf,
      note: note ?? this.note,
      type_id: type_id ?? this.type_id,
      specie_id: specie_id ?? this.specie_id,
      farm_id: farm_id ?? this.farm_id,
      status_id: status_id ?? this.status_id,
      cow_no: cow_no ?? this.cow_no,
      cow_name: cow_name ?? this.cow_name,
      cow_birthday: cow_birthday ?? this.cow_birthday,
      cow_sex: cow_sex ?? this.cow_sex,
      mom_id: mom_id ?? this.mom_id,
      mom_specie: mom_specie ?? this.mom_specie,
      cow_image: cow_image ?? this.cow_image,
      firstHeat: firstHeat ?? this.firstHeat,
      firstcount: firstcount ?? this.firstcount,
      secondHeat: secondHeat ?? this.secondHeat,
      secondcount: secondcount ?? this.secondcount,
      thirdHeat: thirdHeat ?? this.thirdHeat,
      thirdcount: thirdcount ?? this.thirdcount,
      dryDate: dryDate ?? this.dryDate,
      drycount: drycount ?? this.drycount,
      parDate: parDate ?? this.parDate,
      parcount: parcount ?? this.parcount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'abdominal_id': abdominal_id,
      'cow_id': cow_id,
      'round': round,
      'ab_date': ab_date,
      'ab_status': ab_status,
      'ab_caretaker': ab_caretaker,
      'semen_id': semen_id,
      'semen_name': semen_name,
      'semen_specie': semen_specie,
      'ab_calf': ab_calf,
      'note': note,
      'type_id': type_id,
      'specie_id': specie_id,
      'farm_id': farm_id,
      'status_id': status_id,
      'cow_no': cow_no,
      'cow_name': cow_name,
      'cow_birthday': cow_birthday,
      'cow_sex': cow_sex,
      'mom_id': mom_id,
      'mom_specie': mom_specie,
      'cow_image': cow_image,
      'firstHeat': firstHeat,
      'firstcount': firstcount,
      'secondHeat': secondHeat,
      'secondcount': secondcount,
      'thirdHeat': thirdHeat,
      'thirdcount': thirdcount,
      'dryDate': dryDate,
      'drycount': drycount,
      'parDate': parDate,
      'parcount': parcount,
    };
  }

  factory DateAb.fromMap(Map<String, dynamic> map) {
    return DateAb(
      abdominal_id: map['abdominal_id'],
      cow_id: map['cow_id'],
      round: map['round'],
      ab_date: map['ab_date'],
      ab_status: map['ab_status'],
      ab_caretaker: map['ab_caretaker'],
      semen_id: map['semen_id'],
      semen_name: map['semen_name'],
      semen_specie: map['semen_specie'],
      ab_calf: map['ab_calf'],
      note: map['note'],
      type_id: map['type_id'],
      specie_id: map['specie_id'],
      farm_id: map['farm_id'],
      status_id: map['status_id'],
      cow_no: map['cow_no'],
      cow_name: map['cow_name'],
      cow_birthday: map['cow_birthday'],
      cow_sex: map['cow_sex'],
      mom_id: map['mom_id'],
      mom_specie: map['mom_specie'],
      cow_image: map['cow_image'],
      firstHeat: map['firstHeat'],
      firstcount: map['firstcount'],
      secondHeat: map['secondHeat'],
      secondcount: map['secondcount'],
      thirdHeat: map['thirdHeat'],
      thirdcount: map['thirdcount'],
      dryDate: map['dryDate'],
      drycount: map['drycount'],
      parDate: map['parDate'],
      parcount: map['parcount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DateAb.fromJson(String source) => DateAb.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DateAb(abdominal_id: $abdominal_id, cow_id: $cow_id, round: $round, ab_date: $ab_date, ab_status: $ab_status, ab_caretaker: $ab_caretaker, semen_id: $semen_id, semen_name: $semen_name, semen_specie: $semen_specie, ab_calf: $ab_calf, note: $note, type_id: $type_id, specie_id: $specie_id, farm_id: $farm_id, status_id: $status_id, cow_no: $cow_no, cow_name: $cow_name, cow_birthday: $cow_birthday, cow_sex: $cow_sex, mom_id: $mom_id, mom_specie: $mom_specie, cow_image: $cow_image, firstHeat: $firstHeat, firstcount: $firstcount, secondHeat: $secondHeat, secondcount: $secondcount, thirdHeat: $thirdHeat, thirdcount: $thirdcount, dryDate: $dryDate, drycount: $drycount, parDate: $parDate, parcount: $parcount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DateAb &&
      other.abdominal_id == abdominal_id &&
      other.cow_id == cow_id &&
      other.round == round &&
      other.ab_date == ab_date &&
      other.ab_status == ab_status &&
      other.ab_caretaker == ab_caretaker &&
      other.semen_id == semen_id &&
      other.semen_name == semen_name &&
      other.semen_specie == semen_specie &&
      other.ab_calf == ab_calf &&
      other.note == note &&
      other.type_id == type_id &&
      other.specie_id == specie_id &&
      other.farm_id == farm_id &&
      other.status_id == status_id &&
      other.cow_no == cow_no &&
      other.cow_name == cow_name &&
      other.cow_birthday == cow_birthday &&
      other.cow_sex == cow_sex &&
      other.mom_id == mom_id &&
      other.mom_specie == mom_specie &&
      other.cow_image == cow_image &&
      other.firstHeat == firstHeat &&
      other.firstcount == firstcount &&
      other.secondHeat == secondHeat &&
      other.secondcount == secondcount &&
      other.thirdHeat == thirdHeat &&
      other.thirdcount == thirdcount &&
      other.dryDate == dryDate &&
      other.drycount == drycount &&
      other.parDate == parDate &&
      other.parcount == parcount;
  }

  @override
  int get hashCode {
    return abdominal_id.hashCode ^
      cow_id.hashCode ^
      round.hashCode ^
      ab_date.hashCode ^
      ab_status.hashCode ^
      ab_caretaker.hashCode ^
      semen_id.hashCode ^
      semen_name.hashCode ^
      semen_specie.hashCode ^
      ab_calf.hashCode ^
      note.hashCode ^
      type_id.hashCode ^
      specie_id.hashCode ^
      farm_id.hashCode ^
      status_id.hashCode ^
      cow_no.hashCode ^
      cow_name.hashCode ^
      cow_birthday.hashCode ^
      cow_sex.hashCode ^
      mom_id.hashCode ^
      mom_specie.hashCode ^
      cow_image.hashCode ^
      firstHeat.hashCode ^
      firstcount.hashCode ^
      secondHeat.hashCode ^
      secondcount.hashCode ^
      thirdHeat.hashCode ^
      thirdcount.hashCode ^
      dryDate.hashCode ^
      drycount.hashCode ^
      parDate.hashCode ^
      parcount.hashCode;
  }
}
