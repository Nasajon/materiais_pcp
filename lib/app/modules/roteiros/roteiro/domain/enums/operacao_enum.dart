import 'package:pcp_flutter/app/core/localization/localizations.dart';

enum QuandoEnum {
  antesDaOperacao('tempo_antes_do_inicio_da_execucao'),
  duranteAOperacao('durante_toda_a_execucao'),
  aposAOperacao('tempo_apos_o_fim_da_execucao');

  final String value;

  const QuandoEnum(this.value);

  String get name {
    switch (this) {
      case QuandoEnum.antesDaOperacao:
        return translation.types.tipoQuandoAntesDaOperacao;
      case QuandoEnum.duranteAOperacao:
        return translation.types.tipoQuandoDuranteAOperacao;
      case QuandoEnum.aposAOperacao:
        return translation.types.tipoQuandoAposAOperacao;
    }
  }

  static QuandoEnum selectByValue(String value) => QuandoEnum.values.where((quando) => quando.value == value).first;
}
