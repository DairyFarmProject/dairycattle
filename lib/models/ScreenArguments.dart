import 'dart:convert';

class ScreenArguments {
  final String farm_no;
  final String farm_name;
  final String farm_code;
  final String address;
  final String moo;
  final String soi;
  final String road;
  final String sub_district;
  final String district;
  final String province;
  final String postcode;
  ScreenArguments({
    required this.farm_no,
    required this.farm_name,
    required this.farm_code,
    required this.address,
    required this.moo,
    required this.soi,
    required this.road,
    required this.sub_district,
    required this.district,
    required this.province,
    required this.postcode,
  });
  

  ScreenArguments copyWith({
    String? farm_no,
    String? farm_name,
    String? farm_code,
    String? address,
    String? moo,
    String? soi,
    String? road,
    String? sub_district,
    String? district,
    String? province,
    String? postcode,
  }) {
    return ScreenArguments(
      farm_no: farm_no ?? this.farm_no,
      farm_name: farm_name ?? this.farm_name,
      farm_code: farm_code ?? this.farm_code,
      address: address ?? this.address,
      moo: moo ?? this.moo,
      soi: soi ?? this.soi,
      road: road ?? this.road,
      sub_district: sub_district ?? this.sub_district,
      district: district ?? this.district,
      province: province ?? this.province,
      postcode: postcode ?? this.postcode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'farm_no': farm_no,
      'farm_name': farm_name,
      'farm_code': farm_code,
      'address': address,
      'moo': moo,
      'soi': soi,
      'road': road,
      'sub_district': sub_district,
      'district': district,
      'province': province,
      'postcode': postcode,
    };
  }

  factory ScreenArguments.fromMap(Map<String, dynamic> map) {
    return ScreenArguments(
      farm_no: map['farm_no'],
      farm_name: map['farm_name'],
      farm_code: map['farm_code'],
      address: map['address'],
      moo: map['moo'],
      soi: map['soi'],
      road: map['road'],
      sub_district: map['sub_district'],
      district: map['district'],
      province: map['province'],
      postcode: map['postcode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScreenArguments.fromJson(String source) => ScreenArguments.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScreenArguments(farm_no: $farm_no, farm_name: $farm_name, farm_code: $farm_code, address: $address, moo: $moo, soi: $soi, road: $road, sub_district: $sub_district, district: $district, province: $province, postcode: $postcode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ScreenArguments &&
      other.farm_no == farm_no &&
      other.farm_name == farm_name &&
      other.farm_code == farm_code &&
      other.address == address &&
      other.moo == moo &&
      other.soi == soi &&
      other.road == road &&
      other.sub_district == sub_district &&
      other.district == district &&
      other.province == province &&
      other.postcode == postcode;
  }

  @override
  int get hashCode {
    return farm_no.hashCode ^
      farm_name.hashCode ^
      farm_code.hashCode ^
      address.hashCode ^
      moo.hashCode ^
      soi.hashCode ^
      road.hashCode ^
      sub_district.hashCode ^
      district.hashCode ^
      province.hashCode ^
      postcode.hashCode;
  }
}
