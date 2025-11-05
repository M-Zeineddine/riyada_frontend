import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourtsPage extends ConsumerStatefulWidget {
  final String? initialSport;
  final String? initialSort;

  const CourtsPage({super.key, this.initialSport, this.initialSort});

  @override
  ConsumerState<CourtsPage> createState() => _CourtsPageState();
}

class _CourtsPageState extends ConsumerState<CourtsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Sport: ${widget.initialSport}'));
  }
}
