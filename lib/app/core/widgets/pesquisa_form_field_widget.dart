import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

class PesquisaFormFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const PesquisaFormFieldWidget({
    super.key,
    required this.label,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData();
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: AnaTextStyles.grey14Px.copyWith(fontSize: 16), // TODO: Pegar a formatação do texto pelo tema
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: themeData.textTheme.labelMedium?.copyWith(fontSize: 16, fontStyle: FontStyle.italic),
        contentPadding: const EdgeInsets.symmetric(vertical: 18.5, horizontal: 16),
        fillColor: const Color(0xFFF2F2F2),
        suffixIcon: Icon(
          Icons.search,
          color: AnaColors.darkBlue,
          size: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AnaColors.lightGrey),
        ),
      ),
    );
  }
}
