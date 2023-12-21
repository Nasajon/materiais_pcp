import 'package:pcp_flutter/app/core/localization/localizations.dart';

enum StatusOrdemDeProducaoEnum {
  aberta('aberta'),
  aprovada('aprovada'),
  planejada('planejada'),
  emProducao('em_producao'),
  produzida('produzida'),
  cancelada('cancelada');

  final String code;

  const StatusOrdemDeProducaoEnum(this.code);

  String get name {
    switch (this) {
      case StatusOrdemDeProducaoEnum.aberta:
        return translation.types.statusOrdemDeProducaoAberta;
      case StatusOrdemDeProducaoEnum.aprovada:
        return translation.types.statusOrdemDeProducaoAprovada;
      case StatusOrdemDeProducaoEnum.planejada:
        return translation.types.statusOrdemDeProducaoPlanejada;
      case StatusOrdemDeProducaoEnum.emProducao:
        return translation.types.statusOrdemDeProducaoEmProducao;
      case StatusOrdemDeProducaoEnum.produzida:
        return translation.types.statusOrdemDeProducaoProduzida;
      case StatusOrdemDeProducaoEnum.cancelada:
        return translation.types.statusOrdemDeProducaoCancelada;
    }
  }

  static StatusOrdemDeProducaoEnum select(String code) {
    return StatusOrdemDeProducaoEnum.values.where((value) => value.code == code).first;
  }
}
