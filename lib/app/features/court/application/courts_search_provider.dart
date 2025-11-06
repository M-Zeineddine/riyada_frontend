import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourtsSearchQuery extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }

  void clear() {
    state = '';
  }
}

final courtsSearchQueryProvider = NotifierProvider<CourtsSearchQuery, String>(
  () {
    return CourtsSearchQuery();
  },
);
