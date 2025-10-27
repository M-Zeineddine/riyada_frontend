import 'package:flutter/material.dart';

class CarouselDot extends StatelessWidget {
  const CarouselDot({super.key, required this.active});
  final bool active;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? cs.primary : Colors.black12,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
