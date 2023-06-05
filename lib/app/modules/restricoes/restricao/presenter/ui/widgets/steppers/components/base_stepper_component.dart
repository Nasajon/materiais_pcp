// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class BaseStepperComponent extends StatelessWidget {
  final String content;
  final double radius;
  final double radiusSelected;
  final bool isValid;
  final bool isSelected;

  const BaseStepperComponent({
    Key? key,
    required this.content,
    this.radius = 30,
    this.radiusSelected = 36,
    required this.isValid,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    var color = colorTheme?.stepper;

    Widget contentWidget = Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(content, style: AnaTextStyles.boldWhite16Px),
    );

    if (isValid && !isSelected) {
      color = colorTheme?.success;
    }

    if (isValid && !isSelected) {
      contentWidget = const Icon(
        Icons.check,
        size: 20,
        color: Colors.white,
      );
    }

    return Container(
      key: key,
      width: isSelected ? radiusSelected : radius,
      height: isSelected ? radiusSelected : radius,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: contentWidget,
      ),
    );
  }
}
