// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import 'components/base_stepper_component.dart';
import 'components/check_stepper_component.dart';

class StepperComponent extends StatefulWidget {
  final String textInfo;
  final int stepNumber;
  final bool isValid;
  final bool isSelected;
  final bool isOptional;
  final VoidCallback? onTap;

  const StepperComponent({
    Key? key,
    required this.textInfo,
    this.stepNumber = 0,
    this.isValid = false,
    this.isSelected = false,
    this.isOptional = false,
    this.onTap,
  }) : super(key: key);

  StepperComponent copyWith({
    String? textInfo,
    bool? isValid,
    bool? isSelected,
    int? stepNumber,
    VoidCallback? onTap,
  }) {
    return StepperComponent(
      textInfo: textInfo ?? this.textInfo,
      isValid: isValid ?? this.isValid,
      isSelected: isSelected ?? this.isSelected,
      stepNumber: stepNumber ?? this.stepNumber,
      onTap: onTap ?? this.onTap,
    );
  }

  @override
  State<StepperComponent> createState() => _StepperComponentState();
}

class _StepperComponentState extends State<StepperComponent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        children: [
          Builder(
            builder: (_) {
              return BaseStepperComponent(
                content: widget.stepNumber.toString(),
                isValid: widget.isValid,
                isSelected: widget.isSelected,
              );
            },
          ),
          const SizedBox(width: 16),
          if (screenWidth > 1100) ...[
            AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                widget.textInfo,
                style: widget.isSelected ? AnaTextStyles.boldDarkGrey16Px : AnaTextStyles.boldLightGrey16Px,
                textAlign: TextAlign.center,
              ),
            ),
          ] else ...[
            ClipRRect(
              child: AnimatedSwitcher(
                switchInCurve: Curves.ease,
                duration: const Duration(milliseconds: 200),
                reverseDuration: Duration.zero,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
                child: widget.isSelected
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          widget.textInfo,
                          style: AnaTextStyles.boldDarkGrey16Px,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : null,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
