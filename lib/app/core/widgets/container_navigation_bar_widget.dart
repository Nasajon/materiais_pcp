import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ContainerNavigationBarWidget extends StatelessWidget {
  final Widget? child;

  const ContainerNavigationBarWidget({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      decoration: BoxDecoration(
        color: colorTheme?.background,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            spreadRadius: 3,
            blurRadius: 5,
          )
        ],
      ),
      child: child,
    );
  }
}
