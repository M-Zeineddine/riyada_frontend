// courts_filter_model.dart
class CourtsFilter {
  final String? sport;
  final String? sort;

  const CourtsFilter({this.sport, this.sort});

  CourtsFilter copyWith({String? sport, String? sort}) {
    return CourtsFilter(sport: sport, sort: sort);
  }
}
