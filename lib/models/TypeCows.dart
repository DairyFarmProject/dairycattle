import 'dart:convert';

class TypeCows {
  final int type_id;
  final String type_name;
  TypeCows({
    required this.type_id,
    required this.type_name,
  });
  

  TypeCows copyWith({
    int? type_id,
    String? type_name,
  }) {
    return TypeCows(
      type_id: type_id ?? this.type_id,
      type_name: type_name ?? this.type_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type_id': type_id,
      'type_name': type_name,
    };
  }

  factory TypeCows.fromMap(Map<String, dynamic> map) {
    return TypeCows(
      type_id: map['type_id'],
      type_name: map['type_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeCows.fromJson(String source) => TypeCows.fromMap(json.decode(source));

  @override
  String toString() => 'TypeCows(type_id: $type_id, type_name: $type_name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TypeCows &&
      other.type_id == type_id &&
      other.type_name == type_name;
  }

  @override
  int get hashCode => type_id.hashCode ^ type_name.hashCode;
}
