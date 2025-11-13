// lib/app/features/court/application/court_by_id_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';
import 'package:riyada_frontend/app/features/court/application/courts_data_providers.dart';

final courtByIdProvider = Provider.family<CourtModel?, String>((ref, id) {
  final all = ref.watch(allCourtsProvider);
  try {
    return all.firstWhere((c) => c.id == id);
  } catch (_) {
    return null;
  }
});
