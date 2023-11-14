// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/deletar_grupo_de_restricao_store.dart';

class GrupoDeRestricaoState {
  final GrupoDeRestricaoEntity grupoDeRestricao;
  final DeletarGrupoDeRestricaoStore deletarStore;

  GrupoDeRestricaoState({
    required this.grupoDeRestricao,
    required this.deletarStore,
  });

  GrupoDeRestricaoState copyWith({
    GrupoDeRestricaoEntity? grupoDeRestricao,
    DeletarGrupoDeRestricaoStore? deletarStore,
  }) {
    return GrupoDeRestricaoState(
      grupoDeRestricao: grupoDeRestricao ?? this.grupoDeRestricao,
      deletarStore: deletarStore ?? this.deletarStore,
    );
  }
}
