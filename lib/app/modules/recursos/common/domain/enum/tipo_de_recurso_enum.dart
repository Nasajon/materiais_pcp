import 'package:pcp_flutter/app/core/localization/localizations.dart';

enum TipoDeRecursoEnum {
  equipamento(value: 'equipamento'),
  maoDeObra(value: 'mao_de_obra'),
  postoDeTrabalho(value: 'posto_de_trabalho'),
  outros(value: 'outros');

  final String value;

  const TipoDeRecursoEnum({required this.value});

  String get name {
    switch (this) {
      case TipoDeRecursoEnum.equipamento:
        return translation.types.pcpTipoRecursoEquipamento;
      case TipoDeRecursoEnum.maoDeObra:
        return translation.types.pcpTipoRecursoMaoDeObra;
      case TipoDeRecursoEnum.postoDeTrabalho:
        return translation.types.pcpTipoRecursoPostoDeTrabalho;
      case TipoDeRecursoEnum.outros:
        return translation.types.pcpTipoRecursoOutros;
    }
  }

  static TipoDeRecursoEnum selecTipoDeRecurso(String value) {
    return TipoDeRecursoEnum.values.where((tipo) => tipo.value == value).first;
  }
}
