import 'dart:convert';

class StatusCows {
  final int status_id;
  final String status_name;
  StatusCows({
    required this.status_id,
    required this.status_name,
  });
  

  StatusCows copyWith({
    int? status_id,
    String? status_name,
  }) {
    return StatusCows(
      status_id: status_id ?? this.status_id,
      status_name: status_name ?? this.status_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status_id': status_id,
      'status_name': status_name,
    };
  }

  factory StatusCows.fromMap(Map<String, dynamic> map) {
    return StatusCows(
      status_id: map['status_id'],
      status_name: map['status_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusCows.fromJson(String source) => StatusCows.fromMap(json.decode(source));

  @override
  String toString() => 'StatusCows(status_id: $status_id, status_name: $status_name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is StatusCows &&
      other.status_id == status_id &&
      other.status_name == status_name;
  }

  @override
  int get hashCode => status_id.hashCode ^ status_name.hashCode;
}
