import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';

class DateVO extends TextVO {
  DateVO(super.value) {
    _validate();
  }

  factory DateVO.date(DateTime date) {
    return DateVO(DateFormat('dd/MM/yyyy HH:mm:ss').format(date));
  }

  factory DateVO.empty() {
    return DateVO.date(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  _validate() {}

  DateTime? getDate({String format = 'dd/MM/yyyy HH:mm:ss'}) {
    try {
      return DateFormat(format).parse(value);
    } on FormatException {
      return null;
    }
  }

  String? dateFormat({String format = 'dd/MM/yyyy'}) {
    try {
      final date = getDate();
      if (date != null) {
        return DateFormat(format).format(date);
      }
      return null;
    } on FormatException {
      return null;
    }
  }
}
