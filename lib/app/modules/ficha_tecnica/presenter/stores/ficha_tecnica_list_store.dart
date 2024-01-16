// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/deletar_ficha_tecnica_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_ficha_tecnica_recentes_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_todos_ficha_tecnica_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/deletar_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/states/ficha_tecnica_state.dart';

class FichaTecnicaListStore extends NasajonStreamStore<List<FichaTecnicaState>> {
  final GetFichaTecnicaRecenteUsecase _getFichaTecnicaRecenteUsecase;
  final GetTodosFichaTecnicaUsecase _getTodosFichaTecnicaUsecase;
  final DeletarFichaTecnicaUsecase _deletarFichaTecnicaUsecase;

  FichaTecnicaListStore(
    this._getFichaTecnicaRecenteUsecase,
    this._deletarFichaTecnicaUsecase,
    this._getTodosFichaTecnicaUsecase,
  ) : super(initialState: []);

  @override
  void initStore() {
    super.initStore();

    getListFichaTecnica(delay: Duration.zero);
  }

  final _searchNotifier = RxNotifier<String>('');
  String get search => _searchNotifier.value;
  set search(String value) => _searchNotifier.value = value;

  final List<FichaTecnicaState> _listFichaTecnica = [];

  Future<void> getListFichaTecnica({Duration delay = const Duration(milliseconds: 500), String search = ''}) async {
    setLoading(true);

    try {
      execute(() async {
        List<FichaTecnicaAggregate> response;
        _listFichaTecnica.clear();
        if (search.trim() == '') {
          response = await _getFichaTecnicaRecenteUsecase();
        } else {
          response = await _getTodosFichaTecnicaUsecase(search);
        }
        _listFichaTecnica.addAll(response
            .map(
              (fichaTecnica) => FichaTecnicaState(
                fichaTecnica: fichaTecnica,
                deletarStore: DeletarFichaTecnicaStore(_deletarFichaTecnicaUsecase),
              ),
            )
            .toList());
        return _listFichaTecnica;
      }, delay: delay);
    } on Failure catch (e) {
      setError(e);
    }
  }

  Future<void> addFichaTecnica(FichaTecnicaAggregate fichaTecnica) async {
    _listFichaTecnica.add(
      FichaTecnicaState(
        fichaTecnica: fichaTecnica,
        deletarStore: DeletarFichaTecnicaStore(_deletarFichaTecnicaUsecase),
      ),
    );

    update(_listFichaTecnica, force: true);
  }

  Future<void> updateFichaTecnica(FichaTecnicaAggregate fichaTecnica) async {
    for (var i = 0; i < _listFichaTecnica.length; i++) {
      if (_listFichaTecnica[i].fichaTecnica.id == fichaTecnica.id) {
        _listFichaTecnica.setAll(i, [
          FichaTecnicaState(
            fichaTecnica: fichaTecnica,
            deletarStore: DeletarFichaTecnicaStore(_deletarFichaTecnicaUsecase),
          )
        ]);
        break;
      }
    }

    update(_listFichaTecnica, force: true);
  }

  Future<void> deleteFichaTecnica(String id) async {
    _listFichaTecnica.removeWhere((element) => element.fichaTecnica.id == id);

    update(_listFichaTecnica, force: true);
  }
}
