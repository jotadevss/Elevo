import 'dart:convert';

class CreateUserDTO {
  final String name;
  final String email;
  final String password;

  CreateUserDTO({
    required this.name,
    required this.email,
    required this.password,
  });

  CreateUserDTO copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return CreateUserDTO(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory CreateUserDTO.fromMap(Map<String, dynamic> map) {
    return CreateUserDTO(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateUserDTO.fromJson(String source) => CreateUserDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CreateUserDTO(name: $name, email: $email, password: $password)';

  @override
  bool operator ==(covariant CreateUserDTO other) {
    if (identical(this, other)) return true;

    return other.name == name && other.email == email && other.password == password;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ password.hashCode;
}
