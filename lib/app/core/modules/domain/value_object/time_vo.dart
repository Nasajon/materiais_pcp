import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';

class TimeVO extends TextVO {
  TimeVO(super.value) {
    _validate();
  }

  factory TimeVO.time(TimeOfDay time) {
    return TimeVO('${time.hour}:${time.minute}');
  }

  _validate() {}

  TimeOfDay? getTime() {
    try {
      List<String> parts = value.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);

      return TimeOfDay(hour: hour, minute: minute);
    } on FormatException catch (_) {
      return null;
    }
  }

  String? timeFormat({String format = ':'}) {
    try {
      final time = getTime();
      if (time != null) {
        return '${time.hour}$format${time.minute.toString().padLeft(2, '0')}';
      }
      return null;
    } on FormatException catch (_) {
      return null;
    }
  }
}
