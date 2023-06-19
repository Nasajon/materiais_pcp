import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

var _selectedDaysOfWeek = <int>[];

class WeekToggleButtonsWidget extends StatefulWidget {
  final List<int>? initialValue;
  final double radius;
  final DescriptionOfDayType descriptionOfDayType;
  final void Function(List<int> days)? onSelectedDaysOfWeek;

  const WeekToggleButtonsWidget({
    Key? key,
    this.initialValue,
    this.radius = 30,
    this.descriptionOfDayType = DescriptionOfDayType.firstLetter,
    this.onSelectedDaysOfWeek,
  }) : super(key: key);

  @override
  State<WeekToggleButtonsWidget> createState() => _WeekToggleButtonsWidgetState();
}

class _WeekToggleButtonsWidgetState extends State<WeekToggleButtonsWidget> {
  @override
  void initState() {
    super.initState();

    _selectedDaysOfWeek = widget.initialValue ?? [];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> contents = [];

    for (int index = 0; index < DaysOfWeekEnum.values.length; index++) {
      contents.add(_WeekWidget(
        isSelected: _selectedDaysOfWeek.where((element) => element == DaysOfWeekEnum.values[index].code).isNotEmpty,
        radius: widget.radius,
        daysOfWeek: DaysOfWeekEnum.values[index],
        descriptionOfDayType: widget.descriptionOfDayType,
        onSelected: (selected) {
          if (selected) {
            _selectedDaysOfWeek.add(DaysOfWeekEnum.values[index].code);
          } else {
            _selectedDaysOfWeek.removeWhere((element) => element == DaysOfWeekEnum.values[index].code);
          }
          widget.onSelectedDaysOfWeek?.call(_selectedDaysOfWeek);
          setState(() {});
        },
      ));

      if (index < DaysOfWeekEnum.values.length - 1) {
        contents.add(const SizedBox(width: 16));
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: contents,
            ),
          ),
        );
      },
    );
  }
}

class _WeekWidget extends StatelessWidget {
  final bool isSelected;
  final double radius;
  final DaysOfWeekEnum daysOfWeek;
  final DescriptionOfDayType descriptionOfDayType;
  final void Function(bool selected) onSelected;

  const _WeekWidget({
    Key? key,
    this.isSelected = false,
    required this.radius,
    required this.daysOfWeek,
    required this.descriptionOfDayType,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    var textContent = '';

    switch (descriptionOfDayType) {
      case DescriptionOfDayType.fullName:
        textContent = daysOfWeek.name;
        break;
      case DescriptionOfDayType.firstLetter:
        textContent = daysOfWeek.firstLetter;
        break;
      case DescriptionOfDayType.threeLetters:
        textContent = daysOfWeek.threeLetters;
        break;
    }

    return Container(
      padding: descriptionOfDayType != DescriptionOfDayType.firstLetter ? const EdgeInsets.symmetric(horizontal: 12) : null,
      constraints: BoxConstraints(
        maxHeight: radius,
        minWidth: radius,
        minHeight: radius,
      ),
      decoration: BoxDecoration(
        color: isSelected ? colorTheme?.primary : colorTheme?.border,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: InkWell(
        onTap: () => onSelected.call(!isSelected),
        child: Center(
          child: Text(
            textContent,
            style: themeData.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : colorTheme?.text,
            ),
          ),
        ),
      ),
    );
  }
}

enum DescriptionOfDayType { fullName, firstLetter, threeLetters }

enum DaysOfWeekEnum {
  sunday(code: 1, name: 'Domingo'),
  monday(code: 2, name: 'Segunda'),
  tuesday(code: 3, name: 'Terça'),
  wednesday(code: 4, name: 'Quarta'),
  thursday(code: 5, name: 'Quinta'),
  friday(code: 6, name: 'Sexta'),
  saturday(code: 7, name: 'Sábado');

  final int code;
  final String name;

  const DaysOfWeekEnum({required this.code, required this.name});

  String get firstLetter => name.substring(0, 1);
  String get threeLetters => name.substring(0, 3);
}
