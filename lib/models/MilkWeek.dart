import 'dart:convert';

class MilkWeek {
  String day;
  String date;
  int total;
  MilkWeek({
    required this.day,
    required this.date,
    required this.total,
  });
  

  MilkWeek copyWith({
    String? day,
    String? date,
    int? total,
  }) {
    return MilkWeek(
      day: day ?? this.day,
      date: date ?? this.date,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'date': date,
      'total': total,
    };
  }

  factory MilkWeek.fromMap(Map<String, dynamic> map) {
    return MilkWeek(
      day: map['day'],
      date: map['date'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MilkWeek.fromJson(String source) => MilkWeek.fromMap(json.decode(source));

  @override
  String toString() => 'MilkWeek(day: $day, date: $date, total: $total)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MilkWeek &&
      other.day == day &&
      other.date == date &&
      other.total == total;
  }

  @override
  int get hashCode => day.hashCode ^ date.hashCode ^ total.hashCode;
}
