import 'dart:convert';

class Milks {
  int milk_id;
  int milk_liter_morn;
  int milk_liter_even;
  String milk_date;
  int total;
  Milks({
    required this.milk_id,
    required this.milk_liter_morn,
    required this.milk_liter_even,
    required this.milk_date,
    required this.total,
  });
  

  Milks copyWith({
    int? milk_id,
    int? milk_liter_morn,
    int? milk_liter_even,
    String? milk_date,
    int? total,
  }) {
    return Milks(
      milk_id: milk_id ?? this.milk_id,
      milk_liter_morn: milk_liter_morn ?? this.milk_liter_morn,
      milk_liter_even: milk_liter_even ?? this.milk_liter_even,
      milk_date: milk_date ?? this.milk_date,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'milk_id': milk_id,
      'milk_liter_morn': milk_liter_morn,
      'milk_liter_even': milk_liter_even,
      'milk_date': milk_date,
      'total': total,
    };
  }

  factory Milks.fromMap(Map<String, dynamic> map) {
    return Milks(
      milk_id: map['milk_id'],
      milk_liter_morn: map['milk_liter_morn'],
      milk_liter_even: map['milk_liter_even'],
      milk_date: map['milk_date'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Milks.fromJson(String source) => Milks.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Milks(milk_id: $milk_id, milk_liter_morn: $milk_liter_morn, milk_liter_even: $milk_liter_even, milk_date: $milk_date, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Milks &&
      other.milk_id == milk_id &&
      other.milk_liter_morn == milk_liter_morn &&
      other.milk_liter_even == milk_liter_even &&
      other.milk_date == milk_date &&
      other.total == total;
  }

  @override
  int get hashCode {
    return milk_id.hashCode ^
      milk_liter_morn.hashCode ^
      milk_liter_even.hashCode ^
      milk_date.hashCode ^
      total.hashCode;
  }
} 
