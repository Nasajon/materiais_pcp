import 'package:flutter/material.dart';

import 'stepper_component.dart';

class HorizontalStepperWidget extends StatefulWidget {
  final ScrollController scrollController;
  final PageController pageController;
  final List<StepperComponent> steppers;
  final bool isStepperClickable;
  final bool shouldDeselectSteps;

  const HorizontalStepperWidget({
    super.key,
    required this.scrollController,
    required this.pageController,
    required this.steppers,
    this.isStepperClickable = false,
    this.shouldDeselectSteps = true,
  });

  @override
  State<HorizontalStepperWidget> createState() => _HorizontalStepperWidgetState();
}

class _HorizontalStepperWidgetState extends State<HorizontalStepperWidget> {
  @override
  Widget build(BuildContext context) {
    for (var index = 0; index < widget.steppers.length; index++) {
      var stepper = widget.steppers[index].copyWith(
        stepNumber: index + 1,
      );

      var valuePage = 0;

      if (widget.pageController.positions.isNotEmpty && widget.pageController.page != null) {
        valuePage = widget.pageController.page?.round() ?? 0;
      } else {
        valuePage = widget.pageController.initialPage;
      }

      if (widget.shouldDeselectSteps &&
          widget.isStepperClickable &&
          stepper.isValid &&
          valuePage + 1 >= stepper.stepNumber &&
          (valuePage > 0 && widget.steppers[valuePage - 1].isValid)) {
        stepper = stepper.copyWith(
          onTap: stepper.isValid ? () => widget.pageController.jumpToPage(index) : null,
        );
      } else if (widget.shouldDeselectSteps) {
        stepper = stepper.copyWith(
          isValid: index < valuePage || (index == valuePage && stepper.isValid),
        );
      }

      stepper = stepper.copyWith(
        isSelected: index == valuePage,
        onTap: !widget.shouldDeselectSteps && widget.isStepperClickable ? () => widget.pageController.jumpToPage(index) : null,
      );

      widget.steppers[index] = stepper;
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(16),
          child: Container(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth - 32,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.steppers.length == 2) ...[
                  widget.steppers.first,
                  widget.steppers.last
                ] else ...[
                  widget.steppers.first,
                  if (widget.steppers.length > 2) ...[
                    ...widget.steppers.sublist(1, widget.steppers.length).map(
                      (stepper) {
                        return stepper;
                      },
                    )
                  ],
                ]
              ],
            ),
          ),
        ),
      );
    });
  }
}
