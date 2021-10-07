import 'dart:convert';

class Cows {
  final int cow_id;
  final int type_id;
  final int specie_id;
  final int farm_id;
  final int status_id;
  final String cow_no;
  final String cow_name;
  final String cow_birthday;
  final String cow_sex;
  final String semen_id;
  final int semen_specie;
  final String mom_id;
  final int mom_specie;
  final String cow_image;
  final String note;
  final String type_name;
  final String specie_name_en;
  final String specie_name_th;
  Cows({
    required this.cow_id,
    required this.type_id,
    required this.specie_id,
    required this.farm_id,
    required this.status_id,
    required this.cow_no,
    required this.cow_name,
    required this.cow_birthday,
    required this.cow_sex,
    required this.semen_id,
    required this.semen_specie,
    required this.mom_id,
    required this.mom_specie,
    required this.cow_image,
    required this.note,
    required this.type_name,
    required this.specie_name_en,
    required this.specie_name_th,
  });
  

  Cows copyWith({
    int? cow_id,
    int? type_id,
    int? specie_id,
    int? farm_id,
    int? status_id,
    String? cow_no,
    String? cow_name,
    String? cow_birthday,
    String? cow_sex,
    String? semen_id,
    int? semen_specie,
    String? mom_id,
    int? mom_specie,
    String? cow_image,
    String? note,
    String? type_name,
    String? specie_name_en,
    String? specie_name_th,
  }) {
    return Cows(
      cow_id: cow_id ?? this.cow_id,
      type_id: type_id ?? this.type_id,
      specie_id: specie_id ?? this.specie_id,
      farm_id: farm_id ?? this.farm_id,
      status_id: status_id ?? this.status_id,
      cow_no: cow_no ?? this.cow_no,
      cow_name: cow_name ?? this.cow_name,
      cow_birthday: cow_birthday ?? this.cow_birthday,
      cow_sex: cow_sex ?? this.cow_sex,
      semen_id: semen_id ?? this.semen_id,
      semen_specie: semen_specie ?? this.semen_specie,
      mom_id: mom_id ?? this.mom_id,
      mom_specie: mom_specie ?? this.mom_specie,
      cow_image: cow_image ?? this.cow_image,
      note: note ?? this.note,
      type_name: type_name ?? this.type_name,
      specie_name_en: specie_name_en ?? this.specie_name_en,
      specie_name_th: specie_name_th ?? this.specie_name_th,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cow_id': cow_id,
      'type_id': type_id,
      'specie_id': specie_id,
      'farm_id': farm_id,
      'status_id': status_id,
      'cow_no': cow_no,
      'cow_name': cow_name,
      'cow_birthday': cow_birthday,
      'cow_sex': cow_sex,
      'semen_id': semen_id,
      'semen_specie': semen_specie,
      'mom_id': mom_id,
      'mom_specie': mom_specie,
      'cow_image': cow_image,
      'note': note,
      'type_name': type_name,
      'specie_name_en': specie_name_en,
      'specie_name_th': specie_name_th,
    };
  }

  factory Cows.fromMap(Map<String, dynamic> map) {
    return Cows(
      cow_id: map['cow_id'],
      type_id: map['type_id'],
      specie_id: map['specie_id'],
      farm_id: map['farm_id'],
      status_id: map['status_id'],
      cow_no: map['cow_no'],
      cow_name: map['cow_name'],
      cow_birthday: map['cow_birthday'],
      cow_sex: map['cow_sex'],
      semen_id: map['semen_id'],
      semen_specie: map['semen_specie'],
      mom_id: map['mom_id'],
      mom_specie: map['mom_specie'],
      cow_image: map['cow_image'],
      note: map['note'],
      type_name: map['type_name'],
      specie_name_en: map['specie_name_en'],
      specie_name_th: map['specie_name_th'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cows.fromJson(String source) => Cows.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cows(cow_id: $cow_id, type_id: $type_id, specie_id: $specie_id, farm_id: $farm_id, status_id: $status_id, cow_no: $cow_no, cow_name: $cow_name, cow_birthday: $cow_birthday, cow_sex: $cow_sex, semen_id: $semen_id, semen_specie: $semen_specie, mom_id: $mom_id, mom_specie: $mom_specie, cow_image: $cow_image, note: $note, type_name: $type_name, specie_name_en: $specie_name_en, specie_name_th: $specie_name_th)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Cows &&
      other.cow_id == cow_id &&
      other.type_id == type_id &&
      other.specie_id == specie_id &&
      other.farm_id == farm_id &&
      other.status_id == status_id &&
      other.cow_no == cow_no &&
      other.cow_name == cow_name &&
      other.cow_birthday == cow_birthday &&
      other.cow_sex == cow_sex &&
      other.semen_id == semen_id &&
      other.semen_specie == semen_specie &&
      other.mom_id == mom_id &&
      other.mom_specie == mom_specie &&
      other.cow_image == cow_image &&
      other.note == note &&
      other.type_name == type_name &&
      other.specie_name_en == specie_name_en &&
      other.specie_name_th == specie_name_th;
  }

  @override
  int get hashCode {
    return cow_id.hashCode ^
      type_id.hashCode ^
      specie_id.hashCode ^
      farm_id.hashCode ^
      status_id.hashCode ^
      cow_no.hashCode ^
      cow_name.hashCode ^
      cow_birthday.hashCode ^
      cow_sex.hashCode ^
      semen_id.hashCode ^
      semen_specie.hashCode ^
      mom_id.hashCode ^
      mom_specie.hashCode ^
      cow_image.hashCode ^
      note.hashCode ^
      type_name.hashCode ^
      specie_name_en.hashCode ^
      specie_name_th.hashCode;
  }
}
