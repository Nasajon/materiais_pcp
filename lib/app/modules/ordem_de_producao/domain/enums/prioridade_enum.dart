import 'package:pcp_flutter/app/core/localization/localizations.dart';

enum PrioridadeEnum {
  baixa(code: '1'),
  media(code: '2'),
  alta(code: '3');

  final String code;
  String get name {
    switch (this) {
      case PrioridadeEnum.baixa:
        return translation.types.prioridadeBaixa;
      case PrioridadeEnum.media:
        return translation.types.prioridadeMedia;
      case PrioridadeEnum.alta:
        return translation.types.prioridadeAlta;
    }
  }

  const PrioridadeEnum({required this.code});

  static PrioridadeEnum select(String code) {
    return PrioridadeEnum.values.where((element) => element.code == code).first;
  }
}
