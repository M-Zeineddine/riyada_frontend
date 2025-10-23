class UserModel {
  final String id;
  final String name;
  final String? avatarUrl;
  final String phoneNumber;

  const UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.avatarUrl,
  });
}
