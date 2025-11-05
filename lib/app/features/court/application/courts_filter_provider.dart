import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/court/data/courts_filter_model.dart';

class CourtsFilterNotifier extends Notifier<CourtsFilter> {
  @override
  CourtsFilter build() {
    return const CourtsFilter();
  }

  void setSport(String? sport) {
    state = state.copyWith(sport: sport);
  }

  void setSort(String? sort) {
    state = state.copyWith(sort: sort);
  }

  void setFilters({String? sport, String? sort}) {
    state = CourtsFilter(sport: sport, sort: sort);
  }

  void reset() {
    state = const CourtsFilter();
  }
}

final courtsFilterProvider =
    NotifierProvider<CourtsFilterNotifier, CourtsFilter>(() {
      return CourtsFilterNotifier();
    });
