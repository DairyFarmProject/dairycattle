import 'dart:convert';

class Farms {
  final int farm_id;
  final String farm_no;
  final String farm_code;
  final String farm_name;
  final String farm_image;
  final String address;
  final int moo;
  final String soi;
  final String road;
  final String sub_district;
  final String district;
  final String province;
  final int postcode;
  Farms({
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
  });
  

  Farms copyWith({
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
  }) {
    return Farms(
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
    };
  }

  factory Farms.fromMap(Map<String, dynamic> map) {
    return Farms(
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Farms.fromJson(String source) => Farms.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Farms(farm_id: $farm_id, farm_no: $farm_no, farm_code: $farm_code, farm_name: $farm_name, farm_image: $farm_image, address: $address, moo: $moo, soi: $soi, road: $road, sub_district: $sub_district, district: $district, province: $province, postcode: $postcode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Farms &&
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
      other.postcode == postcode;
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
      postcode.hashCode;
  }
}
