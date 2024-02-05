import 'package:pcp_flutter/app/core/localization/localizations.dart';

enum AtividadeStatusEnum {
  aberta('aberta'),
  emPreparacao('em_preparacao'),
  iniciada('iniciada'),
  encerrada('encerrada'),
  pausada('pausada'),
  cancelada('cancelada');

  final String value;

  const AtividadeStatusEnum(this.value);

  String get name {
    switch (this) {
      case AtividadeStatusEnum.aberta:
        return translation.types.statusAtividadeAberta;
      case AtividadeStatusEnum.emPreparacao:
        return translation.types.statusAtividadeEmPreparacao;
      case AtividadeStatusEnum.iniciada:
        return translation.types.statusAtividadeIniciada;
      case AtividadeStatusEnum.encerrada:
        return translation.types.statusAtividadeEncerrada;
      case AtividadeStatusEnum.pausada:
        return translation.types.statusAtividadePausada;
      case AtividadeStatusEnum.cancelada:
        return translation.types.statusAtividadeCancelada;
    }
  }

  static AtividadeStatusEnum selectByValue(String value) => AtividadeStatusEnum.values.where((quando) => quando.value == value).first;
}
