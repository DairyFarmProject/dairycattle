import 'dart:convert';

class CowCount {
  String type_name;
  int count;
  CowCount({
    required this.type_name,
    required this.count,
  });

  CowCount copyWith({
    String? type_name,
    int? count,
  }) {
    return CowCount(
      type_name: type_name ?? this.type_name,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type_name': type_name,
      'count': count,
    };
  }

  factory CowCount.fromMap(Map<String, dynamic> map) {
    return CowCount(
      type_name: map['type_name'],
      count: map['count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CowCount.fromJson(String source) =>
      CowCount.fromMap(json.decode(source));

  @override
  String toString() => 'CowCount(type_name: $type_name, count: $count)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CowCount &&
        other.type_name == type_name &&
        other.count == count;
  }

  @override
  int get hashCode => type_name.hashCode ^ count.hashCode;
}
