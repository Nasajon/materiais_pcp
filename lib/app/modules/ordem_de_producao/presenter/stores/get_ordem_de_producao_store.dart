import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/enums/status_ordem_de_producao_enum.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_ordem_de_producao_usecase.dart';

class GetOrdemDeProducaoStore extends NasajonNotifierStore<List<OrdemDeProducaoAggregate>> {
  final GetOrdemDeProducaoUsecase _getOrdemDeProducaoUsecase;

  GetOrdemDeProducaoStore(
    this._getOrdemDeProducaoUsecase,
  ) : super(initialState: []);

  String search = '';

  Future<void> searchOrdensDeProducoes({String search = '', Duration delay = const Duration(milliseconds: 500)}) async {
    this.search = search;

    try {
      execute(
        delay: delay,
        () async {
          setLoading(true);

          final listOrdemDeProducao = await _getOrdemDeProducaoUsecase(
            search: search,
            status: StatusOrdemDeProducaoEnum.aprovada.code,
          );

          return listOrdemDeProducao;
        },
      );
    } on OrdemDeProducaoFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }
}
