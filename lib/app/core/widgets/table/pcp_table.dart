// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

enum TypeTable { modelo1, modelo2, modelo3 }

class PCPTable extends StatefulWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final List<Widget> actions;
  final TypeTable type;

  const PCPTable({
    Key? key,
    required this.columns,
    required this.rows,
    this.actions = const [],
    this.type = TypeTable.modelo1,
  }) : super(key: key);

  @override
  State<PCPTable> createState() => _PCPTableState();
}

class _PCPTableState extends State<PCPTable> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    var color = Colors.transparent;

    if (widget.type == TypeTable.modelo3) {
      color = colorTheme?.border ?? color;
    }

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
                border: widget.type == TypeTable.modelo2
                    ? Border.all(
                        color: colorTheme?.border ?? Colors.transparent,
                      )
                    : null,
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
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: colorTheme?.border,
                              dividerTheme: const DividerThemeData(
                                thickness: 1.0,
                              ),
                              dataTableTheme: DataTableThemeData(
                                dataRowMaxHeight: widget.type == TypeTable.modelo3 ? 61 : 54,
                                columnSpacing: 32,
                              ),
                            ),
                            child: DataTable(
                              headingRowColor: MaterialStateColor.resolveWith((states) => color),
                              border: widget.type == TypeTable.modelo1 || widget.type == TypeTable.modelo3
                                  ? TableBorder.all(
                                      color: colorTheme?.border ?? Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                  : null,
                              columns: widget.columns,
                              rows: widget.rows,
                            ),
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
  final double? width;
  final double? height;
  final AlignmentGeometry alignment;
  final Color? color;

  const TextDataColumn({
    Key? key,
    required this.text,
    this.width,
    this.height,
    this.alignment = Alignment.centerLeft,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Expanded(
      child: Container(
        width: width,
        height: height,
        color: color,
        child: Align(
          alignment: alignment,
          child: Text(
            text,
            style: themeData.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  TextDataColumn copyWith({
    String? text,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
    Color? color,
  }) {
    return TextDataColumn(
      text: text ?? this.text,
      width: width ?? this.width,
      height: height ?? this.height,
      alignment: alignment ?? this.alignment,
      color: color ?? this.color,
    );
  }
}

class TextRow extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final AlignmentGeometry alignment;

  const TextRow({
    Key? key,
    required this.text,
    this.width,
    this.height,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      width: width,
      height: height,
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          style: themeData.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
