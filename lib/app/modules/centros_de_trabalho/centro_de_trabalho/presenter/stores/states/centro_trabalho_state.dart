// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/presenter/stores/deletar_centro_trabalho_store.dart';

class CentroTrabalhoState {
  final CentroTrabalhoAggregate centroTrabalho;
  final DeletarCentroTrabalhoStore deletarStore;

  CentroTrabalhoState({
    required this.centroTrabalho,
    required this.deletarStore,
  });

  CentroTrabalhoState copyWith({
    CentroTrabalhoAggregate? centroTrabalho,
    DeletarCentroTrabalhoStore? deletarStore,
  }) {
    return CentroTrabalhoState(
      centroTrabalho: centroTrabalho ?? this.centroTrabalho,
      deletarStore: deletarStore ?? this.deletarStore,
    );
  }
}
