import 'package:flutter/material.dart';

class GenericSearchField extends StatelessWidget {
  const GenericSearchField({
    super.key,
    this.initialText,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String? initialText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialText);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText ?? 'Search',
        prefixIcon: prefixIcon ?? const Icon(Icons.search),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        isDense: true,
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
    );
  }
}
