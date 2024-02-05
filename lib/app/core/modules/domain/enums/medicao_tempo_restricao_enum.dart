import 'package:pcp_flutter/app/core/localization/localizations.dart';

enum MedicaoTempoRestricao {
  antesDaOperacao('tempo_antes_do_inicio_da_execucao'),
  duranteAOperacao('durante_toda_a_execucao'),
  aposAOperacao('tempo_apos_o_fim_da_execucao');

  final String value;

  const MedicaoTempoRestricao(this.value);

  String get name {
    switch (this) {
      case MedicaoTempoRestricao.antesDaOperacao:
        return translation.types.tipoQuandoAntesDaOperacao;
      case MedicaoTempoRestricao.duranteAOperacao:
        return translation.types.tipoQuandoDuranteAOperacao;
      case MedicaoTempoRestricao.aposAOperacao:
        return translation.types.tipoQuandoAposAOperacao;
    }
  }

  static MedicaoTempoRestricao selectByValue(String value) => MedicaoTempoRestricao.values.where((quando) => quando.value == value).first;
}
