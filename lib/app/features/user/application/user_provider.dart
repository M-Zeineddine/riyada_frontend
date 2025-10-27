import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/user/data/user_model.dart';

final userProvider = Provider<UserModel?>((ref) {
  return const UserModel(
    id: 'u1',
    name: 'Mohammad Zeineddine',
    phoneNumber: '+961 70 123 456',
    location: 'Beirut, Lebanon',
    avatarUrl: 'https://i.pravatar.cc/150?img=3',
  );
});
