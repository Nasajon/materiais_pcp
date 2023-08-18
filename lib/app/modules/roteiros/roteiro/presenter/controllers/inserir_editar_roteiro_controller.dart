import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_recurso_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';

class InserirEditarRoteiroController {
  final GetRecursoPorGrupoUsecase _getRecursoPorGrupoUsecase;
  final GetRestricaoPorGrupoUsecase _getRestricaoPorGrupoUsecase;

  InserirEditarRoteiroController(this._getRecursoPorGrupoUsecase, this._getRestricaoPorGrupoUsecase);

  final _roteiroNotifier = RxNotifier(RoteiroAggregate.empty());
  RoteiroAggregate get roteiro => _roteiroNotifier.value;
  set roteiro(RoteiroAggregate value) => _roteiroNotifier.value = value;
}
