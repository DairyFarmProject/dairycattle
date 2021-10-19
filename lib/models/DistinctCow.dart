import 'dart:convert';

class DistinctCow {
  int cow_id;
  String cow_no;
  String cow_name;
  String cow_image;
  int vaccine_id;
  String vac_name_th;
  String vac_name_en;
  DistinctCow({
    required this.cow_id,
    required this.cow_no,
    required this.cow_name,
    required this.cow_image,
    required this.vaccine_id,
    required this.vac_name_th,
    required this.vac_name_en,
  });
  

  DistinctCow copyWith({
    int? cow_id,
    String? cow_no,
    String? cow_name,
    String? cow_image,
    int? vaccine_id,
    String? vac_name_th,
    String? vac_name_en,
  }) {
    return DistinctCow(
      cow_id: cow_id ?? this.cow_id,
      cow_no: cow_no ?? this.cow_no,
      cow_name: cow_name ?? this.cow_name,
      cow_image: cow_image ?? this.cow_image,
      vaccine_id: vaccine_id ?? this.vaccine_id,
      vac_name_th: vac_name_th ?? this.vac_name_th,
      vac_name_en: vac_name_en ?? this.vac_name_en,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cow_id': cow_id,
      'cow_no': cow_no,
      'cow_name': cow_name,
      'cow_image': cow_image,
      'vaccine_id': vaccine_id,
      'vac_name_th': vac_name_th,
      'vac_name_en': vac_name_en,
    };
  }

  factory DistinctCow.fromMap(Map<String, dynamic> map) {
    return DistinctCow(
      cow_id: map['cow_id'],
      cow_no: map['cow_no'],
      cow_name: map['cow_name'],
      cow_image: map['cow_image'],
      vaccine_id: map['vaccine_id'],
      vac_name_th: map['vac_name_th'],
      vac_name_en: map['vac_name_en'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DistinctCow.fromJson(String source) => DistinctCow.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DistinctCow(cow_id: $cow_id, cow_no: $cow_no, cow_name: $cow_name, cow_image: $cow_image, vaccine_id: $vaccine_id, vac_name_th: $vac_name_th, vac_name_en: $vac_name_en)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DistinctCow &&
      other.cow_id == cow_id &&
      other.cow_no == cow_no &&
      other.cow_name == cow_name &&
      other.cow_image == cow_image &&
      other.vaccine_id == vaccine_id &&
      other.vac_name_th == vac_name_th &&
      other.vac_name_en == vac_name_en;
  }

  @override
  int get hashCode {
    return cow_id.hashCode ^
      cow_no.hashCode ^
      cow_name.hashCode ^
      cow_image.hashCode ^
      vaccine_id.hashCode ^
      vac_name_th.hashCode ^
      vac_name_en.hashCode;
  }
}
