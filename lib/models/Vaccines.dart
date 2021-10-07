import 'dart:convert';

class Vaccines {
  final int vaccine_id;
  final String vac_name_en;
  final String vac_name_th;
  final String detail;
  Vaccines({
    required this.vaccine_id,
    required this.vac_name_en,
    required this.vac_name_th,
    required this.detail, 
  });
  

  Vaccines copyWith({
    int? vaccine_id,
    String? vac_name_en,
    String? vac_name_th,
    String? detail,
  }) {
    return Vaccines(
      vaccine_id: vaccine_id ?? this.vaccine_id,
      vac_name_en: vac_name_en ?? this.vac_name_en,
      vac_name_th: vac_name_th ?? this.vac_name_th,
      detail: detail ?? this.detail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vaccine_id': vaccine_id,
      'vac_name_en': vac_name_en,
      'vac_name_th': vac_name_th,
      'detail': detail,
    };
  }

  factory Vaccines.fromMap(Map<String, dynamic> map) {
    return Vaccines(
      vaccine_id: map['vaccine_id'],
      vac_name_en: map['vac_name_en'],
      vac_name_th: map['vac_name_th'],
      detail: map['detail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Vaccines.fromJson(String source) => Vaccines.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vaccines(vaccine_id: $vaccine_id, vac_name_en: $vac_name_en, vac_name_th: $vac_name_th, detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Vaccines &&
      other.vaccine_id == vaccine_id &&
      other.vac_name_en == vac_name_en &&
      other.vac_name_th == vac_name_th &&
      other.detail == detail;
  }

  @override
  int get hashCode {
    return vaccine_id.hashCode ^
      vac_name_en.hashCode ^
      vac_name_th.hashCode ^
      detail.hashCode;
  }
}
