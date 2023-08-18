import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_restricao_controller.dart';

class RestricaoController {
  late final RestricaoAggregate _restricao;
  List<GrupoDeRestricaoController> listGrupoDeRestricaoController = [];

  RestricaoController({
    required RestricaoAggregate restricao,
  }) {
    _restricao = restricao;
  }

  RestricaoAggregate get restricao {
    return _restricao;
  }
}
