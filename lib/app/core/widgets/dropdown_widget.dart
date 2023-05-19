import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DropdownButtonWidget<T> extends StatefulWidget {
  final String label;
  final T? value;
  final void Function(T value) onSelected;
  final List<DropdownItem<T>> items;
  final bool isRequiredField;
  final String errorMessage;
  final bool isEnabled;

  DropdownButtonWidget({
    super.key,
    required this.label,
    required this.onSelected,
    required this.items,
    this.value,
    this.isRequiredField = false,
    this.errorMessage = '',
    this.isEnabled = true,
  }) : assert(
          errorMessage.isNotEmpty && isRequiredField,
          'Validation error: Please provide a value for this field. '
          'The errorMessage field must not be empty when isRequiredField is true.',
        );

  @override
  State<DropdownButtonWidget<T>> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState<T> extends State<DropdownButtonWidget<T>> {
  @override
  Widget build(BuildContext context) {
    final focusNode = FocusScope.of(context);
    final themeData = Theme.of(context);

    final items = widget.items
        .map(
          (e) => DropdownMenuItem(
            value: e.value,
            child: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(e.label),
            ),
          ),
        )
        .toList();

    return DropdownButtonFormField<T?>(
      onTap: () => focusNode.requestFocus(FocusNode()),
      value: widget.value,
      items: items,
      onChanged: widget.isEnabled ? (value) => widget.onSelected(value as T) : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      isExpanded: true,
      style: themeData.textTheme.titleMedium?.copyWith(overflow: TextOverflow.ellipsis),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        label: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(widget.label),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dropdownColor: Colors.white,
      focusColor: Colors.white,
      borderRadius: BorderRadius.circular(8),
      validator: (value) {
        if (widget.isRequiredField) {
          if (value == null) {
            return widget.errorMessage;
          }
        }
        return null;
      },
    );
  }
}
