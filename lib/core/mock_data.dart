import 'package:riyada_frontend/app/features/court/data/court_model.dart';
import '../app/features/user/data/user_model.dart';

final mockUser = UserModel(
  id: 'u1',
  name: 'Omar Haddad',
  phoneNumber: '+961 70 123 456',
  avatarUrl: 'https://i.pravatar.cc/150?img=3',
);

final mockCourts = [
  CourtModel(
    id: 'c1',
    name: 'Green Field Court',
    location: 'Beirut, Lebanon',
    pricePerHour: 30.0,
    imageUrl: 'https://picsum.photos/seed/field1/400/250',
  ),
  CourtModel(
    id: 'c2',
    name: 'Urban Sports Arena',
    location: 'Saida, Lebanon',
    pricePerHour: 25.0,
    imageUrl: 'https://picsum.photos/seed/field2/400/250',
  ),
  CourtModel(
    id: 'c3',
    name: 'Riyada Court',
    location: 'Tripoli, Lebanon',
    pricePerHour: 20.0,
    imageUrl: 'https://picsum.photos/seed/field3/400/250',
  ),
];
