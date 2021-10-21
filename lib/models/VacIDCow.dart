import 'dart:convert';

class VacIDCow {
  int farm_id;
  String farm_no;
  String farm_code;
  String farm_name;
  String farm_image;
  String address;
  int moo;
  String soi;
  String road;
  String sub_district;
  String district;
  String province;
  int postcode;
  int cow_id;
  int type_id;
  int specie_id;
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
  String note;
  int schedule_id;
  int vaccine_id;
  String vac_date;
  String next_date;
  VacIDCow({
    required this.farm_id,
    required this.farm_no,
    required this.farm_code,
    required this.farm_name,
    required this.farm_image,
    required this.address,
    required this.moo,
    required this.soi,
    required this.road,
    required this.sub_district,
    required this.district,
    required this.province,
    required this.postcode,
    required this.cow_id,
    required this.type_id,
    required this.specie_id,
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
    required this.schedule_id,
    required this.vaccine_id,
    required this.vac_date,
    required this.next_date,
  });

  VacIDCow copyWith({
    int? farm_id,
    String? farm_no,
    String? farm_code,
    String? farm_name,
    String? farm_image,
    String? address,
    int? moo,
    String? soi,
    String? road,
    String? sub_district,
    String? district,
    String? province,
    int? postcode,
    int? cow_id,
    int? type_id,
    int? specie_id,
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
    int? schedule_id,
    int? vaccine_id,
    String? vac_date,
    String? next_date,
  }) {
    return VacIDCow(
      farm_id: farm_id ?? this.farm_id,
      farm_no: farm_no ?? this.farm_no,
      farm_code: farm_code ?? this.farm_code,
      farm_name: farm_name ?? this.farm_name,
      farm_image: farm_image ?? this.farm_image,
      address: address ?? this.address,
      moo: moo ?? this.moo,
      soi: soi ?? this.soi,
      road: road ?? this.road,
      sub_district: sub_district ?? this.sub_district,
      district: district ?? this.district,
      province: province ?? this.province,
      postcode: postcode ?? this.postcode,
      cow_id: cow_id ?? this.cow_id,
      type_id: type_id ?? this.type_id,
      specie_id: specie_id ?? this.specie_id,
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
      schedule_id: schedule_id ?? this.schedule_id,
      vaccine_id: vaccine_id ?? this.vaccine_id,
      vac_date: vac_date ?? this.vac_date,
      next_date: next_date ?? this.next_date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'farm_id': farm_id,
      'farm_no': farm_no,
      'farm_code': farm_code,
      'farm_name': farm_name,
      'farm_image': farm_image,
      'address': address,
      'moo': moo,
      'soi': soi,
      'road': road,
      'sub_district': sub_district,
      'district': district,
      'province': province,
      'postcode': postcode,
      'cow_id': cow_id,
      'type_id': type_id,
      'specie_id': specie_id,
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
      'schedule_id': schedule_id,
      'vaccine_id': vaccine_id,
      'vac_date': vac_date,
      'next_date': next_date,
    };
  }

  factory VacIDCow.fromMap(Map<String, dynamic> map) {
    return VacIDCow(
      farm_id: map['farm_id'],
      farm_no: map['farm_no'],
      farm_code: map['farm_code'],
      farm_name: map['farm_name'],
      farm_image: map['farm_image'],
      address: map['address'],
      moo: map['moo'],
      soi: map['soi'],
      road: map['road'],
      sub_district: map['sub_district'],
      district: map['district'],
      province: map['province'],
      postcode: map['postcode'],
      cow_id: map['cow_id'],
      type_id: map['type_id'],
      specie_id: map['specie_id'],
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
      schedule_id: map['schedule_id'],
      vaccine_id: map['vaccine_id'],
      vac_date: map['vac_date'],
      next_date: map['next_date'] ?? '0000-00-00',
    );
  }

  String toJson() => json.encode(toMap());

  factory VacIDCow.fromJson(String source) =>
      VacIDCow.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VacIDCow(farm_id: $farm_id, farm_no: $farm_no, farm_code: $farm_code, farm_name: $farm_name, farm_image: $farm_image, address: $address, moo: $moo, soi: $soi, road: $road, sub_district: $sub_district, district: $district, province: $province, postcode: $postcode, cow_id: $cow_id, type_id: $type_id, specie_id: $specie_id, status_id: $status_id, cow_no: $cow_no, cow_name: $cow_name, cow_birthday: $cow_birthday, cow_sex: $cow_sex, semen_id: $semen_id, semen_specie: $semen_specie, mom_id: $mom_id, mom_specie: $mom_specie, cow_image: $cow_image, note: $note, schedule_id: $schedule_id, vaccine_id: $vaccine_id, vac_date: $vac_date, next_date: $next_date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VacIDCow &&
        other.farm_id == farm_id &&
        other.farm_no == farm_no &&
        other.farm_code == farm_code &&
        other.farm_name == farm_name &&
        other.farm_image == farm_image &&
        other.address == address &&
        other.moo == moo &&
        other.soi == soi &&
        other.road == road &&
        other.sub_district == sub_district &&
        other.district == district &&
        other.province == province &&
        other.postcode == postcode &&
        other.cow_id == cow_id &&
        other.type_id == type_id &&
        other.specie_id == specie_id &&
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
        other.schedule_id == schedule_id &&
        other.vaccine_id == vaccine_id &&
        other.vac_date == vac_date &&
        other.next_date == next_date;
  }

  @override
  int get hashCode {
    return farm_id.hashCode ^
        farm_no.hashCode ^
        farm_code.hashCode ^
        farm_name.hashCode ^
        farm_image.hashCode ^
        address.hashCode ^
        moo.hashCode ^
        soi.hashCode ^
        road.hashCode ^
        sub_district.hashCode ^
        district.hashCode ^
        province.hashCode ^
        postcode.hashCode ^
        cow_id.hashCode ^
        type_id.hashCode ^
        specie_id.hashCode ^
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
        schedule_id.hashCode ^
        vaccine_id.hashCode ^
        vac_date.hashCode ^
        next_date.hashCode;
  }
}
