import 'dart:convert';

class CheckEmail {
  String? user_id;
  String? email;
  String? password;
  CheckEmail({
    required this.user_id,
    required this.email,
    required this.password,
  });

  CheckEmail copyWith({
    String? user_id,
    String? email,
    String? password,
  }) {
    return CheckEmail(
      user_id: user_id ?? this.user_id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'email': email,
      'password': password,
    };
  }

  factory CheckEmail.fromMap(Map<String, dynamic> map) {
    return CheckEmail(
      user_id: map['user_id'],
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckEmail.fromJson(String source) => CheckEmail.fromMap(json.decode(source));

  @override
  String toString() => 'CheckEmail(user_id: $user_id, email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CheckEmail &&
      other.user_id == user_id &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => user_id.hashCode ^ email.hashCode ^ password.hashCode;
}
