import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/localization/fields.dart';
import 'package:pcp_flutter/app/core/localization/messages.dart';
import 'package:pcp_flutter/app/core/localization/titles.dart';
import 'package:pcp_flutter/app/core/localization/types.dart';
import 'package:pcp_flutter/app/core/localization/pt/localization_pt.dart';

abstract class Localization {
  Fields get fields;

  Messages get messages;

  Titles get titles;

  Types get types;
}

Localization get translation {
  switch (locale.languageCode) {
    case 'pt':
      return LocalizationPt();
    default:
      return LocalizationPt();
  }
}
