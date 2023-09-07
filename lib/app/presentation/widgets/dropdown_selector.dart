import 'package:cbz_generator/app/constants.dart';
import 'package:flutter/material.dart';

class DropdownSelector<T> extends StatelessWidget {
  const DropdownSelector({
    super.key,
    this.labelText,
    this.value,
    this.items,
    this.onChanged,
  });

  // final CompressionOption? contentType;
  final String? labelText;
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return DropdownButtonFormField(
          isExpanded: true,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(
              top: 0,
              left: kDefaultPadding / 2,
              right: kDefaultPadding / 2,
            ),
          ),
          value: value,
          onChanged: onChanged,
          items: items,
        );
      },
    );
  }
}
