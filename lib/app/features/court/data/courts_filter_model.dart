class CourtsFilter {
  final String? sport;
  final String? sort;
  const CourtsFilter({this.sport, this.sort});
  
  CourtsFilter copyWith({String? sport, String? sort}) {
    return CourtsFilter(sport: sport ?? this.sport, sort: sort ?? this.sort);
  }
}
