import 'dart:convert';

class CowAb {
  String cow_name;
  int? cow_id;
  String cow_image;
  int? abdominal_id;
  CowAb({
    required this.cow_name,
    this.cow_id,
    required this.cow_image,
    this.abdominal_id,
  });
  
  bool isEqual(CowAb? model) {
    return this.cow_id == model?.cow_id;
  }

  

  CowAb copyWith({
    String? cow_name,
    int? cow_id,
    String? cow_image,
    int? abdominal_id,
  }) {
    return CowAb(
      cow_name: cow_name ?? this.cow_name,
      cow_id: cow_id ?? this.cow_id,
      cow_image: cow_image ?? this.cow_image,
      abdominal_id: abdominal_id ?? this.abdominal_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cow_name': cow_name,
      'cow_id': cow_id,
      'cow_image': cow_image,
      'abdominal_id': abdominal_id,
    };
  }

  factory CowAb.fromMap(Map<String, dynamic> map) {
    return CowAb(
      cow_name: map['cow_name'],
      cow_id: map['cow_id'],
      cow_image: map['cow_image'],
      abdominal_id: map['abdominal_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CowAb.fromJson(String source) => CowAb.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CowAb(cow_name: $cow_name, cow_id: $cow_id, cow_image: $cow_image, abdominal_id: $abdominal_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CowAb &&
      other.cow_name == cow_name &&
      other.cow_id == cow_id &&
      other.cow_image == cow_image &&
      other.abdominal_id == abdominal_id;
  }

  @override
  int get hashCode {
    return cow_name.hashCode ^
      cow_id.hashCode ^
      cow_image.hashCode ^
      abdominal_id.hashCode;
  }
}
