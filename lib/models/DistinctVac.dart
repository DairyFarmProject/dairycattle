import 'dart:convert';

class DistinctVac {
  int vaccine_id;
  String vac_name_th;
  String vac_name_en;
  DistinctVac({
    required this.vaccine_id,
    required this.vac_name_th,
    required this.vac_name_en,
  });
  

  DistinctVac copyWith({
    int? vaccine_id,
    String? vac_name_th,
    String? vac_name_en,
  }) {
    return DistinctVac(
      vaccine_id: vaccine_id ?? this.vaccine_id,
      vac_name_th: vac_name_th ?? this.vac_name_th,
      vac_name_en: vac_name_en ?? this.vac_name_en,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vaccine_id': vaccine_id,
      'vac_name_th': vac_name_th,
      'vac_name_en': vac_name_en,
    };
  }

  factory DistinctVac.fromMap(Map<String, dynamic> map) {
    return DistinctVac(
      vaccine_id: map['vaccine_id'],
      vac_name_th: map['vac_name_th'],
      vac_name_en: map['vac_name_en'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DistinctVac.fromJson(String source) => DistinctVac.fromMap(json.decode(source));

  @override
  String toString() => 'DistinctVac(vaccine_id: $vaccine_id, vac_name_th: $vac_name_th, vac_name_en: $vac_name_en)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DistinctVac &&
      other.vaccine_id == vaccine_id &&
      other.vac_name_th == vac_name_th &&
      other.vac_name_en == vac_name_en;
  }

  @override
  int get hashCode => vaccine_id.hashCode ^ vac_name_th.hashCode ^ vac_name_en.hashCode;
}
