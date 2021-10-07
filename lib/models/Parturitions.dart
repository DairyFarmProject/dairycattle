import 'dart:convert';

class Parturition {
  final int parturition_id;
  final int cow_id;
  final String par_date;
  final String calf_name;
  final String calf_sex;
  final String per_caretaker;
  final String note;
  Parturition({
    required this.parturition_id,
    required this.cow_id,
    required this.par_date,
    required this.calf_name,
    required this.calf_sex,
    required this.per_caretaker,
    required this.note,
  });
  

  Parturition copyWith({
    int? parturition_id,
    int? cow_id,
    String? par_date,
    String? calf_name,
    String? calf_sex,
    String? per_caretaker,
    String? note,
  }) {
    return Parturition(
      parturition_id: parturition_id ?? this.parturition_id,
      cow_id: cow_id ?? this.cow_id,
      par_date: par_date ?? this.par_date,
      calf_name: calf_name ?? this.calf_name,
      calf_sex: calf_sex ?? this.calf_sex,
      per_caretaker: per_caretaker ?? this.per_caretaker,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'parturition_id': parturition_id,
      'cow_id': cow_id,
      'par_date': par_date,
      'calf_name': calf_name,
      'calf_sex': calf_sex,
      'per_caretaker': per_caretaker,
      'note': note,
    };
  }

  factory Parturition.fromMap(Map<String, dynamic> map) {
    return Parturition(
      parturition_id: map['parturition_id'],
      cow_id: map['cow_id'],
      par_date: map['par_date'],
      calf_name: map['calf_name'],
      calf_sex: map['calf_sex'],
      per_caretaker: map['per_caretaker'],
      note: map['note'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Parturition.fromJson(String source) => Parturition.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Parturition(parturition_id: $parturition_id, cow_id: $cow_id, par_date: $par_date, calf_name: $calf_name, calf_sex: $calf_sex, per_caretaker: $per_caretaker, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Parturition &&
      other.parturition_id == parturition_id &&
      other.cow_id == cow_id &&
      other.par_date == par_date &&
      other.calf_name == calf_name &&
      other.calf_sex == calf_sex &&
      other.per_caretaker == per_caretaker &&
      other.note == note;
  }

  @override
  int get hashCode {
    return parturition_id.hashCode ^
      cow_id.hashCode ^
      par_date.hashCode ^
      calf_name.hashCode ^
      calf_sex.hashCode ^
      per_caretaker.hashCode ^
      note.hashCode;
  }
}
