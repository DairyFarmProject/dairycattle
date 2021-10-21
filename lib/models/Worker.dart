import 'dart:convert';

class Worker {
  int worker_id;
  int role_id;
  int farm_id;
  int user_id;
  String startwork;
  String firstname;
  String lastname;
  String user_birthday;
  String mobile;
  String user_image;
  String email;
  String password;
  String role_name;
  Worker({
    required this.worker_id,
    required this.role_id,
    required this.farm_id,
    required this.user_id,
    required this.startwork,
    required this.firstname,
    required this.lastname,
    required this.user_birthday,
    required this.mobile,
    required this.user_image,
    required this.email,
    required this.password,
    required this.role_name,
  });
  

  Worker copyWith({
    int? worker_id,
    int? role_id,
    int? farm_id,
    int? user_id,
    String? startwork,
    String? firstname,
    String? lastname,
    String? user_birthday,
    String? mobile,
    String? user_image,
    String? email,
    String? password,
    String? role_name,
  }) {
    return Worker(
      worker_id: worker_id ?? this.worker_id,
      role_id: role_id ?? this.role_id,
      farm_id: farm_id ?? this.farm_id,
      user_id: user_id ?? this.user_id,
      startwork: startwork ?? this.startwork,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      user_birthday: user_birthday ?? this.user_birthday,
      mobile: mobile ?? this.mobile,
      user_image: user_image ?? this.user_image,
      email: email ?? this.email,
      password: password ?? this.password,
      role_name: role_name ?? this.role_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'worker_id': worker_id,
      'role_id': role_id,
      'farm_id': farm_id,
      'user_id': user_id,
      'startwork': startwork,
      'firstname': firstname,
      'lastname': lastname,
      'user_birthday': user_birthday,
      'mobile': mobile,
      'user_image': user_image,
      'email': email,
      'password': password,
      'role_name': role_name,
    };
  }

  factory Worker.fromMap(Map<String, dynamic> map) {
    return Worker(
      worker_id: map['worker_id'],
      role_id: map['role_id'],
      farm_id: map['farm_id'],
      user_id: map['user_id'],
      startwork: map['startwork'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      user_birthday: map['user_birthday'],
      mobile: map['mobile'],
      user_image: map['user_image'],
      email: map['email'],
      password: map['password'],
      role_name: map['role_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Worker.fromJson(String source) => Worker.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Worker(worker_id: $worker_id, role_id: $role_id, farm_id: $farm_id, user_id: $user_id, startwork: $startwork, firstname: $firstname, lastname: $lastname, user_birthday: $user_birthday, mobile: $mobile, user_image: $user_image, email: $email, password: $password, role_name: $role_name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Worker &&
      other.worker_id == worker_id &&
      other.role_id == role_id &&
      other.farm_id == farm_id &&
      other.user_id == user_id &&
      other.startwork == startwork &&
      other.firstname == firstname &&
      other.lastname == lastname &&
      other.user_birthday == user_birthday &&
      other.mobile == mobile &&
      other.user_image == user_image &&
      other.email == email &&
      other.password == password &&
      other.role_name == role_name;
  }

  @override
  int get hashCode {
    return worker_id.hashCode ^
      role_id.hashCode ^
      farm_id.hashCode ^
      user_id.hashCode ^
      startwork.hashCode ^
      firstname.hashCode ^
      lastname.hashCode ^
      user_birthday.hashCode ^
      mobile.hashCode ^
      user_image.hashCode ^
      email.hashCode ^
      password.hashCode ^
      role_name.hashCode;
  }
}
