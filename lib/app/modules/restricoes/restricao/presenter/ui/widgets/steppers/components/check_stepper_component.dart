import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CheckStepperComponent extends StatelessWidget {
  const CheckStepperComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AnaColors.green,
      ),
      child: const Icon(
        Icons.check,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}
