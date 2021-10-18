import 'dart:convert';

class Species {
  final int specie_id;
  final String specie_name_en;
  final String specie_name_th;
  Species({
    required this.specie_id,
    required this.specie_name_en,
    required this.specie_name_th,
  });

  Species copyWith({
    int? specie_id,
    String? specie_name_en,
    String? specie_name_th,
  }) {
    return Species(
      specie_id: specie_id ?? this.specie_id,
      specie_name_en: specie_name_en ?? this.specie_name_en,
      specie_name_th: specie_name_th ?? this.specie_name_th,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'specie_id': specie_id,
      'specie_name_en': specie_name_en,
      'specie_name_th': specie_name_th,
    };
  }

  factory Species.fromMap(Map<String, dynamic> map) {
    return Species(
      specie_id: map['specie_id'],
      specie_name_en: map['specie_name_en'],
      specie_name_th: map['specie_name_th'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Species.fromJson(String source) => Species.fromMap(json.decode(source));

  @override
  String toString() => 'Species(specie_id: $specie_id, specie_name_en: $specie_name_en, specie_name_th: $specie_name_th)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Species &&
      other.specie_id == specie_id &&
      other.specie_name_en == specie_name_en &&
      other.specie_name_th == specie_name_th;
  }

  @override
  int get hashCode => specie_id.hashCode ^ specie_name_en.hashCode ^ specie_name_th.hashCode;
}
