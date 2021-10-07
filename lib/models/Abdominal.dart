import 'dart:convert';

class Abdominal {
  final int abdominal_id;
  final int cow_id;
  final int round;
  final String ab_date;
  final String ab_status;
  final String ab_caretaker;
  final int dry_period;
  final String semen_id;
  final String semen_name;
  final int semen_specie;
  final String note;
  final int type_id;
  final int specie_id;
  final int farm_id;
  final int status_id;
  final String cow_no;
  final String cow_name;
  final String cow_birthday;
  final String cow_sex;
  final String mom_id;
  final int mom_specie;
  final String cow_image;
  Abdominal({
    required this.abdominal_id,
    required this.cow_id,
    required this.round,
    required this.ab_date,
    required this.ab_status,
    required this.ab_caretaker,
    required this.dry_period,
    required this.semen_id,
    required this.semen_name,
    required this.semen_specie,
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
  });
 

  Abdominal copyWith({
    int? abdominal_id,
    int? cow_id,
    int? round,
    String? ab_date,
    String? ab_status,
    String? ab_caretaker,
    int? dry_period,
    String? semen_id,
    String? semen_name,
    int? semen_specie,
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
  }) {
    return Abdominal(
      abdominal_id: abdominal_id ?? this.abdominal_id,
      cow_id: cow_id ?? this.cow_id,
      round: round ?? this.round,
      ab_date: ab_date ?? this.ab_date,
      ab_status: ab_status ?? this.ab_status,
      ab_caretaker: ab_caretaker ?? this.ab_caretaker,
      dry_period: dry_period ?? this.dry_period,
      semen_id: semen_id ?? this.semen_id,
      semen_name: semen_name ?? this.semen_name,
      semen_specie: semen_specie ?? this.semen_specie,
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
      'dry_period': dry_period,
      'semen_id': semen_id,
      'semen_name': semen_name,
      'semen_specie': semen_specie,
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
    };
  }

  factory Abdominal.fromMap(Map<String, dynamic> map) {
    return Abdominal(
      abdominal_id: map['abdominal_id'],
      cow_id: map['cow_id'],
      round: map['round'],
      ab_date: map['ab_date'],
      ab_status: map['ab_status'],
      ab_caretaker: map['ab_caretaker'],
      dry_period: map['dry_period'],
      semen_id: map['semen_id'],
      semen_name: map['semen_name'],
      semen_specie: map['semen_specie'],
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Abdominal.fromJson(String source) => Abdominal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Abdominal(abdominal_id: $abdominal_id, cow_id: $cow_id, round: $round, ab_date: $ab_date, ab_status: $ab_status, ab_caretaker: $ab_caretaker, dry_period: $dry_period, semen_id: $semen_id, semen_name: $semen_name, semen_specie: $semen_specie, note: $note, type_id: $type_id, specie_id: $specie_id, farm_id: $farm_id, status_id: $status_id, cow_no: $cow_no, cow_name: $cow_name, cow_birthday: $cow_birthday, cow_sex: $cow_sex, mom_id: $mom_id, mom_specie: $mom_specie, cow_image: $cow_image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Abdominal &&
      other.abdominal_id == abdominal_id &&
      other.cow_id == cow_id &&
      other.round == round &&
      other.ab_date == ab_date &&
      other.ab_status == ab_status &&
      other.ab_caretaker == ab_caretaker &&
      other.dry_period == dry_period &&
      other.semen_id == semen_id &&
      other.semen_name == semen_name &&
      other.semen_specie == semen_specie &&
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
      other.cow_image == cow_image;
  }

  @override
  int get hashCode {
    return abdominal_id.hashCode ^
      cow_id.hashCode ^
      round.hashCode ^
      ab_date.hashCode ^
      ab_status.hashCode ^
      ab_caretaker.hashCode ^
      dry_period.hashCode ^
      semen_id.hashCode ^
      semen_name.hashCode ^
      semen_specie.hashCode ^
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
      cow_image.hashCode;
  }
}
