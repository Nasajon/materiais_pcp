
import 'package:flutter/cupertino.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';

class GrupoDeRestricaoFormState {
  final GrupoDeRestricaoEntity? grupoDeRestricao;

  GrupoDeRestricaoFormState({this.grupoDeRestricao});

  factory GrupoDeRestricaoFormState.empty() => GrupoDeRestricaoFormState(grupoDeRestricao: null);

  GrupoDeRestricaoFormState copyWith({
    ValueGetter<GrupoDeRestricaoEntity?>? grupoDeRestricao,
  }) {
    return GrupoDeRestricaoFormState(
      grupoDeRestricao: grupoDeRestricao != null ? grupoDeRestricao() : this.grupoDeRestricao,
    );
  }
}
