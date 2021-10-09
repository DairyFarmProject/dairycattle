import 'dart:convert';

class Parturition {
  final int parturition_id;
  final int cow_id;
  final String par_date;
  final String calf_name;
  final String calf_sex;
  final String par_caretaker;
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
  Parturition({
    required this.parturition_id,
    required this.cow_id,
    required this.par_date,
    required this.calf_name,
    required this.calf_sex,
    required this.par_caretaker,
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
  

  Parturition copyWith({
    int? parturition_id,
    int? cow_id,
    String? par_date,
    String? calf_name,
    String? calf_sex,
    String? par_caretaker,
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
    return Parturition(
      parturition_id: parturition_id ?? this.parturition_id,
      cow_id: cow_id ?? this.cow_id,
      par_date: par_date ?? this.par_date,
      calf_name: calf_name ?? this.calf_name,
      calf_sex: calf_sex ?? this.calf_sex,
      par_caretaker: par_caretaker ?? this.par_caretaker,
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
      'parturition_id': parturition_id,
      'cow_id': cow_id,
      'par_date': par_date,
      'calf_name': calf_name,
      'calf_sex': calf_sex,
      'par_caretaker': par_caretaker,
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

  factory Parturition.fromMap(Map<String, dynamic> map) {
    return Parturition(
      parturition_id: map['parturition_id'],
      cow_id: map['cow_id'],
      par_date: map['par_date'],
      calf_name: map['calf_name'],
      calf_sex: map['calf_sex'],
      par_caretaker: map['par_caretaker'],
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

  factory Parturition.fromJson(String source) => Parturition.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Parturition(parturition_id: $parturition_id, cow_id: $cow_id, par_date: $par_date, calf_name: $calf_name, calf_sex: $calf_sex, par_caretaker: $par_caretaker, note: $note, type_id: $type_id, specie_id: $specie_id, farm_id: $farm_id, status_id: $status_id, cow_no: $cow_no, cow_name: $cow_name, cow_birthday: $cow_birthday, cow_sex: $cow_sex, mom_id: $mom_id, mom_specie: $mom_specie, cow_image: $cow_image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Parturition &&
      other.parturition_id == parturition_id &&
      other.cow_id == cow_id &&
      other.par_date == par_date &&
      other.calf_name == calf_name &&
      other.calf_sex == calf_sex &&
      other.par_caretaker == par_caretaker &&
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
    return parturition_id.hashCode ^
      cow_id.hashCode ^
      par_date.hashCode ^
      calf_name.hashCode ^
      calf_sex.hashCode ^
      par_caretaker.hashCode ^
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