class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String? imagePath;

  UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.imagePath,
  });
}
