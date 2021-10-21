import 'dart:convert';

class DistinctCowAb {
  int cow_id;
  String cow_name;
  String cow_no;
  String cow_image;
  DistinctCowAb({
    required this.cow_id,
    required this.cow_name,
    required this.cow_no,
    required this.cow_image,
  });

  DistinctCowAb copyWith({
    int? cow_id,
    String? cow_name,
    String? cow_no,
    String? cow_image,
  }) {
    return DistinctCowAb(
      cow_id: cow_id ?? this.cow_id,
      cow_name: cow_name ?? this.cow_name,
      cow_no: cow_no ?? this.cow_no,
      cow_image: cow_image ?? this.cow_image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cow_id': cow_id,
      'cow_name': cow_name,
      'cow_no': cow_no,
      'cow_image': cow_image,
    };
  }

  factory DistinctCowAb.fromMap(Map<String, dynamic> map) {
    return DistinctCowAb(
      cow_id: map['cow_id'],
      cow_name: map['cow_name'],
      cow_no: map['cow_no'],
      cow_image: map['cow_image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DistinctCowAb.fromJson(String source) => DistinctCowAb.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DistinctCowAb(cow_id: $cow_id, cow_name: $cow_name, cow_no: $cow_no, cow_image: $cow_image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DistinctCowAb &&
      other.cow_id == cow_id &&
      other.cow_name == cow_name &&
      other.cow_no == cow_no &&
      other.cow_image == cow_image;
  }

  @override
  int get hashCode {
    return cow_id.hashCode ^
      cow_name.hashCode ^
      cow_no.hashCode ^
      cow_image.hashCode;
  }
}
