// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:design_system/design_system.dart';

class PCPTable extends StatefulWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final List<Widget> actions;

  const PCPTable({
    Key? key,
    required this.columns,
    required this.rows,
    this.actions = const [],
  }) : super(key: key);

  @override
  State<PCPTable> createState() => _PCPTableState();
}

class _PCPTableState extends State<PCPTable> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return LayoutBuilder(
      builder: (_, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                color: GanttEvent.makeColorLighter(colorTheme?.primary ?? Colors.transparent, factor: 0.95),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (widget.actions.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: widget.actions,
                      ),
                    ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      child: SizedBox(
                        width: constraints.maxWidth,
                        child: SingleChildScrollView(
                          child: DataTable(
                            border: TableBorder.all(
                              color: colorTheme?.border ?? Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            columns: widget.columns,
                            rows: widget.rows,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class TextDataColumn extends StatelessWidget {
  final String text;

  const TextDataColumn({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Text(
      text,
      style: themeData.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
