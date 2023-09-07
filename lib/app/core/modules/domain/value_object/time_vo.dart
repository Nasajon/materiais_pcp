import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
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

  String? timeFormat({String format = ':', bool shouldAddSeconds = false}) {
    try {
      final time = getTime();
      if (time != null) {
        return '${time.hour.toString().padLeft(2, '0')}$format${time.minute.toString().padLeft(2, '0')}${shouldAddSeconds ? ':00' : ''}';
      }
      return null;
    } on FormatException catch (_) {
      return null;
    }
  }

  String timeFormatToStringWithoutSeconds() {
    final time = getTime();

    if (time == null) {
      return '';
    }

    final int hours = time.hour;
    final int minutes = time.minute;

    if (hours > 0 && minutes == 0) {
      return '${hours}h';
    } else if (hours == 0 && minutes > 0) {
      return '${minutes}m';
    } else if (hours > 0 && minutes > 0) {
      return '${hours}h$minutes';
    }

    return '';
  }

  String formatDuration() {
    final time = getTime();

    if (time == null) {
      return '';
    }

    final int hours = time.hour;
    final int minutes = time.minute;

    if (hours > 0 && minutes == 0) {
      return _formatQuantityHour(hours);
    } else if (hours == 0 && minutes > 0) {
      return _formatQuantityMinute(minutes);
    } else if (hours > 0 && minutes > 0) {
      final formattedHours = _formatQuantityHour(hours);
      final formattedMinutes = _formatQuantityMinute(minutes);
      return '$formattedHours e $formattedMinutes';
    }

    return '';
  }

  String _formatQuantityHour(int quantity) {
    return quantity == 1 ? '1 ${translation.fields.hora.toLowerCase()}' : '$quantity ${translation.fields.horas.toLowerCase()}';
  }

  String _formatQuantityMinute(int quantity) {
    return quantity == 1 ? '1 ${translation.fields.minuto.toLowerCase()}' : '$quantity ${translation.fields.minutos.toLowerCase()}';
  }
}
