import 'dart:convert';

class SignInDTO {
  final String email;
  final String password;

  SignInDTO({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory SignInDTO.fromMap(Map<String, dynamic> map) {
    return SignInDTO(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInDTO.fromJson(String source) => SignInDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  SignInDTO copyWith({
    String? email,
    String? password,
  }) {
    return SignInDTO(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() => 'SignInDTO(email: $email, password: $password)';

  @override
  bool operator ==(covariant SignInDTO other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
