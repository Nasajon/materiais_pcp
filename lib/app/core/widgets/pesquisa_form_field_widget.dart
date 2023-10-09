// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PesquisaFormFieldWidget extends StatelessWidget {
  final String label;
  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const PesquisaFormFieldWidget({
    Key? key,
    required this.label,
    this.initialValue,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData();

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      style: AnaTextStyles.grey14Px.copyWith(fontSize: 16), // TODO: Pegar a formatação do texto pelo tema
      autofocus: true,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: themeData.textTheme.labelMedium?.copyWith(fontSize: 16, fontStyle: FontStyle.italic),
        contentPadding: const EdgeInsets.symmetric(vertical: 18.5, horizontal: 16),
        fillColor: const Color(0xFFF2F2F2),
        suffixIcon: const Icon(
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
