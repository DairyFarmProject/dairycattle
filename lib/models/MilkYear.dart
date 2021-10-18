import 'dart:convert';

class MilkYear {
  String month;
  String sum;
  MilkYear({
    required this.month,
    required this.sum,
  });

  MilkYear copyWith({
    String? month,
    String? sum,
  }) {
    return MilkYear(
      month: month ?? this.month,
      sum: sum ?? this.sum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'sum': sum,
    };
  }

  factory MilkYear.fromMap(Map<String, dynamic> map) {
    return MilkYear(
      month: map['month'],
      sum: map['sum'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MilkYear.fromJson(String source) =>
      MilkYear.fromMap(json.decode(source));

  @override
  String toString() => 'MilkYear(month: $month, sum: $sum)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MilkYear && other.month == month && other.sum == sum;
  }

  @override
  int get hashCode => month.hashCode ^ sum.hashCode;
}
