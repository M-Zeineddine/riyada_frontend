import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/court/application/courts_search_provider.dart';
import 'package:riyada_frontend/app/shared/widgets/custom_search_bar.dart';

class CourtsSearchBar extends ConsumerStatefulWidget {
  final VoidCallback? onFilterTap;

  const CourtsSearchBar({super.key, this.onFilterTap});

  @override
  ConsumerState<CourtsSearchBar> createState() => _CourtsSearchBarState();
}

class _CourtsSearchBarState extends ConsumerState<CourtsSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(courtsSearchQueryProvider),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    ref.read(courtsSearchQueryProvider.notifier).setQuery(query);
  }

  void _onClear() {
    _controller.clear();
    ref.read(courtsSearchQueryProvider.notifier).clear();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSearchBar(
      controller: _controller,
      hintText: 'Search courts, locations...',
      onChanged: _onSearchChanged,
      onClear: _onClear,
      suffixIcon: widget.onFilterTap != null
          ? IconButton(
              icon: const Icon(Icons.tune),
              onPressed: widget.onFilterTap,
              tooltip: 'Filters',
            )
          : null,
    );
  }
}
