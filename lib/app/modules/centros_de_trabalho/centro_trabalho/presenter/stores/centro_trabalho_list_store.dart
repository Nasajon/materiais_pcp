// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/deletar_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/get_centro_trabalho_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/get_todos_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/presenter/stores/deletar_centro_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/presenter/stores/states/centro_trabalho_state.dart';

class CentroTrabalhoListStore extends NasajonStreamStore<List<CentroTrabalhoState>> {
  final GetTodosCentroTrabalhoUsecase _getTodosCentroTrabalhoUsecase;
  final GetCentroTrabalhoRecenteUsecase _getCentroTrabalhoRecenteUsecase;
  final DeletarCentroTrabalhoUsecase _deletarCentroTrabalhoUsecase;

  CentroTrabalhoListStore(
    this._getTodosCentroTrabalhoUsecase,
    this._getCentroTrabalhoRecenteUsecase,
    this._deletarCentroTrabalhoUsecase,
  ) : super(initialState: []);

  @override
  void initStore() {
    super.initStore();

    getListCentroTrabalho(delay: Duration.zero);
  }

  final _searchNotifier = RxNotifier<String>('');
  String get search => _searchNotifier.value;
  set search(String value) => _searchNotifier.value = value;

  final List<CentroTrabalhoState> _listCentroTrabalho = [];

  Future<void> getListCentroTrabalho({Duration delay = const Duration(milliseconds: 500)}) async {
    try {
      execute(() async {
        setLoading(true);

        if (search.isEmpty) {
          final response = await _getCentroTrabalhoRecenteUsecase();
          _listCentroTrabalho
            ..clear()
            ..addAll(response
                .map(
                  (centroTrabalho) => CentroTrabalhoState(
                    centroTrabalho: centroTrabalho,
                    deletarStore: DeletarCentroTrabalhoStore(_deletarCentroTrabalhoUsecase),
                  ),
                )
                .toList());
          return _listCentroTrabalho;
        }

        final response = await _getTodosCentroTrabalhoUsecase(search);
        _listCentroTrabalho
          ..clear()
          ..addAll(response
              .map(
                (centroTrabalho) => CentroTrabalhoState(
                  centroTrabalho: centroTrabalho,
                  deletarStore: DeletarCentroTrabalhoStore(_deletarCentroTrabalhoUsecase),
                ),
              )
              .toList());
        return _listCentroTrabalho;
      }, delay: delay);
    } on Failure catch (e) {
      setError(e);
    }
  }

  Future<void> addCentroTrabalho(CentroTrabalhoAggregate centroTrabalho) async {
    _listCentroTrabalho.add(
      CentroTrabalhoState(
        centroTrabalho: centroTrabalho,
        deletarStore: DeletarCentroTrabalhoStore(_deletarCentroTrabalhoUsecase),
      ),
    );

    update(_listCentroTrabalho, force: true);
  }

  Future<void> updateCentroTrabalho(CentroTrabalhoAggregate centroTrabalho) async {
    for (var i = 0; i < _listCentroTrabalho.length; i++) {
      if (_listCentroTrabalho[i].centroTrabalho.id == centroTrabalho.id) {
        _listCentroTrabalho.setAll(i, [
          CentroTrabalhoState(
            centroTrabalho: centroTrabalho,
            deletarStore: DeletarCentroTrabalhoStore(_deletarCentroTrabalhoUsecase),
          )
        ]);
        break;
      }
    }

    update(_listCentroTrabalho, force: true);
  }

  Future<void> deleteCentroTrabalho(String id) async {
    _listCentroTrabalho.removeWhere((element) => element.centroTrabalho.id == id);

    update(_listCentroTrabalho, force: true);
  }
}
