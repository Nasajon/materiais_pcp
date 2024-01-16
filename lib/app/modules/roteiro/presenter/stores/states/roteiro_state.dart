// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/deletar_roteiro_store.dart';

class RoteiroState {
  final RoteiroEntity roteiro;
  final DeletarRoteiroStore deletarRoteiroStore;

  const RoteiroState({
    required this.roteiro,
    required this.deletarRoteiroStore,
  });
}
