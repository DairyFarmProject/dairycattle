import 'dart:convert';

class MilkYear {
  int month;
  String count;
  MilkYear({
    required this.month,
    required this.count,
  });
  

  MilkYear copyWith({
    int? month,
    String? count,
  }) {
    return MilkYear(
      month: month ?? this.month,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'count': count,
    };
  }

  factory MilkYear.fromMap(Map<String, dynamic> map) {
    return MilkYear(
      month: map['month'],
      count: map['count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MilkYear.fromJson(String source) => MilkYear.fromMap(json.decode(source));

  @override
  String toString() => 'MilkYear(month: $month, count: $count)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MilkYear &&
      other.month == month &&
      other.count == count;
  }

  @override
  int get hashCode => month.hashCode ^ count.hashCode;
}
