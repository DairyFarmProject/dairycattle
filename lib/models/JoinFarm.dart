import 'dart:convert';

class JoinFarm {
  int? farm_id;
  int? join_id;
  int? user_id;
  String? firstname;
  String? user_birthday;
  String? mobile;
  String? user_image;
  String? email;
  String? password;
  JoinFarm({
    this.farm_id,
    this.join_id,
    this.user_id,
    this.firstname,
    this.user_birthday,
    this.mobile,
    this.user_image,
    this.email,
    this.password,
  });
  

  JoinFarm copyWith({
    int? farm_id,
    int? join_id,
    int? user_id,
    String? firstname,
    String? user_birthday,
    String? mobile,
    String? user_image,
    String? email,
    String? password,
  }) {
    return JoinFarm(
      farm_id: farm_id ?? this.farm_id,
      join_id: join_id ?? this.join_id,
      user_id: user_id ?? this.user_id,
      firstname: firstname ?? this.firstname,
      user_birthday: user_birthday ?? this.user_birthday,
      mobile: mobile ?? this.mobile,
      user_image: user_image ?? this.user_image,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'farm_id': farm_id,
      'join_id': join_id,
      'user_id': user_id,
      'firstname': firstname,
      'user_birthday': user_birthday,
      'mobile': mobile,
      'user_image': user_image,
      'email': email,
      'password': password,
    };
  }

  factory JoinFarm.fromMap(Map<String, dynamic> map) {
    return JoinFarm(
      farm_id: map['farm_id'],
      join_id: map['join_id'],
      user_id: map['user_id'],
      firstname: map['firstname'],
      user_birthday: map['user_birthday'],
      mobile: map['mobile'],
      user_image: map['user_image'],
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory JoinFarm.fromJson(String source) => JoinFarm.fromMap(json.decode(source));

  @override
  String toString() {
    return 'JoinFarm(farm_id: $farm_id, join_id: $join_id, user_id: $user_id, firstname: $firstname, user_birthday: $user_birthday, mobile: $mobile, user_image: $user_image, email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is JoinFarm &&
      other.farm_id == farm_id &&
      other.join_id == join_id &&
      other.user_id == user_id &&
      other.firstname == firstname &&
      other.user_birthday == user_birthday &&
      other.mobile == mobile &&
      other.user_image == user_image &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode {
    return farm_id.hashCode ^
      join_id.hashCode ^
      user_id.hashCode ^
      firstname.hashCode ^
      user_birthday.hashCode ^
      mobile.hashCode ^
      user_image.hashCode ^
      email.hashCode ^
      password.hashCode;
  }
}
