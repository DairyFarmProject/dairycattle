import 'dart:convert';

class Vaccine_schedule {
  int schedule_id;
  int vaccine_id;
  int cow_id;
  String vac_date;
  String next_date;
  String note;
  String vac_name_en;
  String vac_name_th;
  String detail;
  int type_id;
  int specie_id;
  int farm_id;
  int status_id;
  String cow_no;
  String cow_name;
  String cow_birthday;
  String cow_sex;
  String semen_id;
  int semen_specie;
  String mom_id;
  int mom_specie;
  String cow_image;
  Vaccine_schedule({
    required this.schedule_id,
    required this.vaccine_id,
    required this.cow_id,
    required this.vac_date,
    required this.next_date,
    required this.note,
    required this.vac_name_en,
    required this.vac_name_th,
    required this.detail,
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
  });
  

  Vaccine_schedule copyWith({
    int? schedule_id,
    int? vaccine_id,
    int? cow_id,
    String? vac_date,
    String? next_date,
    String? note,
    String? vac_name_en,
    String? vac_name_th,
    String? detail,
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
  }) {
    return Vaccine_schedule(
      schedule_id: schedule_id ?? this.schedule_id,
      vaccine_id: vaccine_id ?? this.vaccine_id,
      cow_id: cow_id ?? this.cow_id,
      vac_date: vac_date ?? this.vac_date,
      next_date: next_date ?? this.next_date,
      note: note ?? this.note,
      vac_name_en: vac_name_en ?? this.vac_name_en,
      vac_name_th: vac_name_th ?? this.vac_name_th,
      detail: detail ?? this.detail,
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'schedule_id': schedule_id,
      'vaccine_id': vaccine_id,
      'cow_id': cow_id,
      'vac_date': vac_date,
      'next_date': next_date,
      'note': note,
      'vac_name_en': vac_name_en,
      'vac_name_th': vac_name_th,
      'detail': detail,
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
    };
  }

  factory Vaccine_schedule.fromMap(Map<String, dynamic> map) {
    return Vaccine_schedule(
      schedule_id: map['schedule_id'],
      vaccine_id: map['vaccine_id'],
      cow_id: map['cow_id'],
      vac_date: map['vac_date'],
      next_date: map['next_date'],
      note: map['note'],
      vac_name_en: map['vac_name_en'],
      vac_name_th: map['vac_name_th'],
      detail: map['detail'],
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Vaccine_schedule.fromJson(String source) => Vaccine_schedule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vaccine_schedule(schedule_id: $schedule_id, vaccine_id: $vaccine_id, cow_id: $cow_id, vac_date: $vac_date, next_date: $next_date, note: $note, vac_name_en: $vac_name_en, vac_name_th: $vac_name_th, detail: $detail, type_id: $type_id, specie_id: $specie_id, farm_id: $farm_id, status_id: $status_id, cow_no: $cow_no, cow_name: $cow_name, cow_birthday: $cow_birthday, cow_sex: $cow_sex, semen_id: $semen_id, semen_specie: $semen_specie, mom_id: $mom_id, mom_specie: $mom_specie, cow_image: $cow_image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Vaccine_schedule &&
      other.schedule_id == schedule_id &&
      other.vaccine_id == vaccine_id &&
      other.cow_id == cow_id &&
      other.vac_date == vac_date &&
      other.next_date == next_date &&
      other.note == note &&
      other.vac_name_en == vac_name_en &&
      other.vac_name_th == vac_name_th &&
      other.detail == detail &&
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
      other.cow_image == cow_image;
  }

  @override
  int get hashCode {
    return schedule_id.hashCode ^
      vaccine_id.hashCode ^
      cow_id.hashCode ^
      vac_date.hashCode ^
      next_date.hashCode ^
      note.hashCode ^
      vac_name_en.hashCode ^
      vac_name_th.hashCode ^
      detail.hashCode ^
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
      cow_image.hashCode;
  }
}
