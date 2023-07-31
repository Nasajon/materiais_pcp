import 'package:pcp_flutter/app/core/localization/fields.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/localization/messages.dart';
import 'package:pcp_flutter/app/core/localization/pt/fields_pt.dart';
import 'package:pcp_flutter/app/core/localization/pt/messages_pt.dart';
import 'package:pcp_flutter/app/core/localization/pt/titles_pt.dart';
import 'package:pcp_flutter/app/core/localization/pt/types_pt.dart';
import 'package:pcp_flutter/app/core/localization/titles.dart';
import 'package:pcp_flutter/app/core/localization/types.dart';

class LocalizationPt extends Localization {
  LocalizationPt() : super();

  @override
  Fields get fields => FieldsPt();

  @override
  Messages get messages => MessagesPt();

  @override
  Types get types => TypesPt();

  @override
  Titles get titles => TitlesPt();
}
