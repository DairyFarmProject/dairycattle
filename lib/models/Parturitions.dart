import 'dart:convert';

class Parturition {
  final int parturition_id;
  final String count;
  final String countSuc;
  final String countFail;
  final int ab_id;
  final String par_date;
  final String calf_name;
  final String calf_sex;
  final String par_caretaker;
  final String par_status;
  final String note;
  final int cow_id;
  final int round;
  final String ab_date;
  final String ab_status;
  final String ab_caretaker;
  final String semen_id;
  final String semen_name;
  final int semen_specie;
  final String ab_calf;
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
    required this.count,
    required this.countSuc,
    required this.countFail,
    required this.ab_id,
    required this.par_date,
    required this.calf_name,
    required this.calf_sex,
    required this.par_caretaker,
    required this.par_status,
    required this.note,
    required this.cow_id,
    required this.round,
    required this.ab_date,
    required this.ab_status,
    required this.ab_caretaker,
    required this.semen_id,
    required this.semen_name,
    required this.semen_specie,
    required this.ab_calf,
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
    String? count,
    String? countSuc,
    String? countFail,
    int? ab_id,
    String? par_date,
    String? calf_name,
    String? calf_sex,
    String? par_caretaker,
    String? par_status,
    String? note,
    int? cow_id,
    int? round,
    String? ab_date,
    String? ab_status,
    String? ab_caretaker,
    String? semen_id,
    String? semen_name,
    int? semen_specie,
    String? ab_calf,
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
      count: count ?? this.count,
      countSuc: countSuc ?? this.countSuc,
      countFail: countFail ?? this.countFail,
      ab_id: ab_id ?? this.ab_id,
      par_date: par_date ?? this.par_date,
      calf_name: calf_name ?? this.calf_name,
      calf_sex: calf_sex ?? this.calf_sex,
      par_caretaker: par_caretaker ?? this.par_caretaker,
      par_status: par_status ?? this.par_status,
      note: note ?? this.note,
      cow_id: cow_id ?? this.cow_id,
      round: round ?? this.round,
      ab_date: ab_date ?? this.ab_date,
      ab_status: ab_status ?? this.ab_status,
      ab_caretaker: ab_caretaker ?? this.ab_caretaker,
      semen_id: semen_id ?? this.semen_id,
      semen_name: semen_name ?? this.semen_name,
      semen_specie: semen_specie ?? this.semen_specie,
      ab_calf: ab_calf ?? this.ab_calf,
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
      'count': count,
      'countSuc': countSuc,
      'countFail': countFail,
      'ab_id': ab_id,
      'par_date': par_date,
      'calf_name': calf_name,
      'calf_sex': calf_sex,
      'par_caretaker': par_caretaker,
      'par_status': par_status,
      'note': note,
      'cow_id': cow_id,
      'round': round,
      'ab_date': ab_date,
      'ab_status': ab_status,
      'ab_caretaker': ab_caretaker,
      'semen_id': semen_id,
      'semen_name': semen_name,
      'semen_specie': semen_specie,
      'ab_calf': ab_calf,
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
      count: map['count'],
      countSuc: map['countSuc'],
      countFail: map['countFail'],
      ab_id: map['ab_id'],
      par_date: map['par_date'],
      calf_name: map['calf_name'],
      calf_sex: map['calf_sex'],
      par_caretaker: map['par_caretaker'],
      par_status: map['par_status'],
      note: map['note'],
      cow_id: map['cow_id'],
      round: map['round'],
      ab_date: map['ab_date'],
      ab_status: map['ab_status'],
      ab_caretaker: map['ab_caretaker'],
      semen_id: map['semen_id'],
      semen_name: map['semen_name'],
      semen_specie: map['semen_specie'],
      ab_calf: map['ab_calf'],
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

  factory Parturition.fromJson(String source) =>
      Parturition.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Parturition(parturition_id: $parturition_id, count: $count, countSuc: $countSuc, countFail: $countFail, ab_id: $ab_id, par_date: $par_date, calf_name: $calf_name, calf_sex: $calf_sex, par_caretaker: $par_caretaker, par_status: $par_status, note: $note, cow_id: $cow_id, round: $round, ab_date: $ab_date, ab_status: $ab_status, ab_caretaker: $ab_caretaker, semen_id: $semen_id, semen_name: $semen_name, semen_specie: $semen_specie, ab_calf: $ab_calf, type_id: $type_id, specie_id: $specie_id, farm_id: $farm_id, status_id: $status_id, cow_no: $cow_no, cow_name: $cow_name, cow_birthday: $cow_birthday, cow_sex: $cow_sex, mom_id: $mom_id, mom_specie: $mom_specie, cow_image: $cow_image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Parturition &&
        other.parturition_id == parturition_id &&
        other.count == count &&
        other.countSuc == countSuc &&
        other.countFail == countFail &&
        other.ab_id == ab_id &&
        other.par_date == par_date &&
        other.calf_name == calf_name &&
        other.calf_sex == calf_sex &&
        other.par_caretaker == par_caretaker &&
        other.par_status == par_status &&
        other.note == note &&
        other.cow_id == cow_id &&
        other.round == round &&
        other.ab_date == ab_date &&
        other.ab_status == ab_status &&
        other.ab_caretaker == ab_caretaker &&
        other.semen_id == semen_id &&
        other.semen_name == semen_name &&
        other.semen_specie == semen_specie &&
        other.ab_calf == ab_calf &&
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
        count.hashCode ^
        countSuc.hashCode ^
        countFail.hashCode ^
        ab_id.hashCode ^
        par_date.hashCode ^
        calf_name.hashCode ^
        calf_sex.hashCode ^
        par_caretaker.hashCode ^
        par_status.hashCode ^
        note.hashCode ^
        cow_id.hashCode ^
        round.hashCode ^
        ab_date.hashCode ^
        ab_status.hashCode ^
        ab_caretaker.hashCode ^
        semen_id.hashCode ^
        semen_name.hashCode ^
        semen_specie.hashCode ^
        ab_calf.hashCode ^
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
