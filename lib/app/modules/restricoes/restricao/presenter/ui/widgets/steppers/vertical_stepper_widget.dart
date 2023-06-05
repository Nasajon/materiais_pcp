// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'stepper_component.dart';

class VerticalStepperWidget extends StatefulWidget {
  final ScrollController scrollController;
  final PageController pageController;
  final List<StepperComponent> steppers;
  final bool isStepperClickable;
  final bool shouldDeselectSteps;

  const VerticalStepperWidget({
    Key? key,
    required this.scrollController,
    required this.pageController,
    required this.steppers,
    this.isStepperClickable = false,
    this.shouldDeselectSteps = true,
  }) : super(key: key);

  @override
  State<VerticalStepperWidget> createState() => _VerticalStepperWidgetState();
}

class _VerticalStepperWidgetState extends State<VerticalStepperWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.pageController.addListener(() {
        setState(() {});
      });
    });
  }

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

    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.steppers.length == 2) ...[
                        widget.steppers.first,
                        const SizedBox(height: 32),
                        widget.steppers.last
                      ] else ...[
                        widget.steppers.first,
                        if (widget.steppers.length > 2) ...[
                          ...widget.steppers.sublist(1, widget.steppers.length - 1).map(
                            (stepper) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 32),
                                child: stepper,
                              );
                            },
                          )
                        ],
                        if (widget.steppers.length > 1) widget.steppers.last,
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
