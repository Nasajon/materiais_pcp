import 'package:flutter/material.dart';

import 'stepper_component.dart';

class HorizontalStepperWidget extends StatefulWidget {
  final ScrollController scrollController;
  final List<StepperComponent> steppers;

  const HorizontalStepperWidget({
    super.key,
    required this.steppers,
    required this.scrollController,
  });

  @override
  State<HorizontalStepperWidget> createState() => _HorizontalStepperWidgetState();
}

class _HorizontalStepperWidgetState extends State<HorizontalStepperWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 595,
          minWidth: 100,
          minHeight: 80,
          maxHeight: 130,
        ),
        child: AspectRatio(
          aspectRatio: 328 / 68,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: Center(
                child: ListView(
                  controller: widget.scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  children: widget.steppers,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
