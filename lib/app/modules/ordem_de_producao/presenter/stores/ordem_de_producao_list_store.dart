import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/aprovar_ordem_de_producao_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/deletar_ordem_de_producao_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_ordem_de_producao_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/aprovar_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/deletar_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/states/ordem_de_producao_state.dart';

class OrdemDeProducaoListStore extends NasajonNotifierStore<List<OrdemDeProducaoState>> {
  final GetOrdemDeProducaoUsecase _getOrdemDeProducaoUsecase;
  // final GetOrdemDeProducaoRecenteUsecase _getOrdemDeProducaoRecenteUsecase;
  final DeletarOrdemDeProducaoUsecase _deletarOrdemDeProducaoUsecase;
  final AprovarOrdemDeProducaoUsecase _aprovarOrdemDeProducaoUsecase;

  OrdemDeProducaoListStore(
    this._getOrdemDeProducaoUsecase,
    // this._getOrdemDeProducaoRecenteUsecase,
    this._deletarOrdemDeProducaoUsecase,
    this._aprovarOrdemDeProducaoUsecase,
  ) : super(initialState: []);

  String search = '';

  Future<void> getOrdemDeProducaos({String search = '', Duration delay = const Duration(milliseconds: 500)}) async {
    this.search = search;

    try {
      execute(
        delay: delay,
        () async {
          setLoading(true);

          // if (search.isEmpty) {
          //   final listOrdemDeProducao = await _getOrdemDeProducaoRecenteUsecase();
          //   final ordemDeProducaoState = listOrdemDeProducao
          //       .map(
          //         (ordemDeProducao) => OrdemDeProducaoState(
          //           ordemDeProducao: ordemDeProducao,
          //           deletarOrdemDeProducaoStore: DeletarOrdemDeProducaoStore(_deletarOrdemDeProducaoUsecase),
          //         ),
          //       )
          //       .toList();

          //   return ordemDeProducaoState;
          // }

          final listOrdemDeProducao = await _getOrdemDeProducaoUsecase(search: search);
          final ordemDeProducaoState = listOrdemDeProducao
              .map(
                (ordemDeProducao) => OrdemDeProducaoState(
                  ordemDeProducao: ordemDeProducao,
                  deletarOrdemDeProducaoStore: DeletarOrdemDeProducaoStore(_deletarOrdemDeProducaoUsecase),
                  aprovarOrdemDeProducaoStore: AprovarOrdemDeProducaoStore(_aprovarOrdemDeProducaoUsecase),
                ),
              )
              .toList();
          return ordemDeProducaoState;
        },
      );
    } on OrdemDeProducaoFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }

  void adicionarOrdemDeProducao(OrdemDeProducaoAggregate ordemDeProducao) {
    state.add(
      OrdemDeProducaoState(
        ordemDeProducao: ordemDeProducao,
        deletarOrdemDeProducaoStore: DeletarOrdemDeProducaoStore(_deletarOrdemDeProducaoUsecase),
        aprovarOrdemDeProducaoStore: AprovarOrdemDeProducaoStore(_aprovarOrdemDeProducaoUsecase),
      ),
    );

    update(state, force: true);
  }

  void editarOrdemDeProducao(OrdemDeProducaoAggregate ordemDeProducao) {
    if (state.where((state) => state.ordemDeProducao.id == ordemDeProducao.id).isEmpty) return;

    final index = state.indexWhere((state) => state.ordemDeProducao.id == ordemDeProducao.id);

    state.setAll(index, [
      OrdemDeProducaoState(
        ordemDeProducao: ordemDeProducao,
        deletarOrdemDeProducaoStore: DeletarOrdemDeProducaoStore(_deletarOrdemDeProducaoUsecase),
        aprovarOrdemDeProducaoStore: AprovarOrdemDeProducaoStore(_aprovarOrdemDeProducaoUsecase),
      ),
    ]);

    update(state, force: true);
  }

  Future<void> deletarOrdemDeProducao(String id) async {
    state.removeWhere((ordemDeProducao) => ordemDeProducao.ordemDeProducao.id == id);

    update(state, force: true);
  }
}
