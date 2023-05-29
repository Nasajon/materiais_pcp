import 'package:ana_l10n/ana_localization.dart';

enum TipoDeRecursoEnum {
  equipamento(value: 'equipamento'),
  maoDeObra(value: 'mao_de_obra'),
  postoDeTrabalho(value: 'posto_de_trabalho'),
  outros(value: 'outros');

  final String value;

  const TipoDeRecursoEnum({required this.value});

  String name(Localization localization) {
    switch (this) {
      case TipoDeRecursoEnum.equipamento:
        return localization.types.pcpTipoRecursoEquipamento;
      case TipoDeRecursoEnum.maoDeObra:
        return localization.types.pcpTipoRecursoMaoDeObra;
      case TipoDeRecursoEnum.postoDeTrabalho:
        return localization.types.pcpTipoRecursoPostoDeTrabalho;
      case TipoDeRecursoEnum.outros:
        return localization.types.pcpTipoRecursoOutros;
    }
  }

  static TipoDeRecursoEnum selecTipoDeRecurso(String value) {
    return TipoDeRecursoEnum.values.where((tipo) => tipo.value == value).first;
  }
}
