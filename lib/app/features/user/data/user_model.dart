class UserModel {
  final String id;
  final String name;
  final String? avatarUrl;
  final String location;
  final String phoneNumber;

  const UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.location,
    this.avatarUrl,
  });
}
