import 'package:flutter/foundation.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/infra/datasources/local/grupo_de_recurso_local_datasource.dart';

import '../../domain/repositories/grupo_de_recursos_repository.dart';
import '../datasources/remote/grupo_de_recurso_datasource.dart';

class GrupoDeRecursoRepositoryImpl implements GrupoDeRecursosRepository {
  final GrupoDeRecursoDatasource _grupoDeRecursoDatasource;
  final GrupoDeRecursoLocalDatasource _grupoDeRecursoLocalDatasource;
  final InternetConnectionStore _connectionStore;

  const GrupoDeRecursoRepositoryImpl(
    this._grupoDeRecursoDatasource,
    this._grupoDeRecursoLocalDatasource,
    this._connectionStore,
  );

  @override
  Future<List<GrupoDeRecurso>> getList(String? search) async {
    try {
      if (kIsWeb || _connectionStore.isOnline) {
        final gruposDeRecurso = await _grupoDeRecursoDatasource.getList(search);

        if (search == null || search.isEmpty) {
          _grupoDeRecursoLocalDatasource.clearList();
          _grupoDeRecursoLocalDatasource.insertList(gruposDeRecurso);
        }

        return gruposDeRecurso;
      }

      return _grupoDeRecursoLocalDatasource.getList(search);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRecursoRepositoryImpl-getList'));
    }
  }

  @override
  Future<GrupoDeRecurso> getItem(String id) {
    try {
      return _grupoDeRecursoDatasource.getItem(id);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRecursoRepositoryImpl-getItem'));
    }
  }

  @override
  Future<GrupoDeRecurso> insertItem(GrupoDeRecurso grupoDeRecurso) async {
    try {
      if (kIsWeb || _connectionStore.isOnline) {
        return _grupoDeRecursoDatasource.insertItem(grupoDeRecurso);
      }

      await _grupoDeRecursoLocalDatasource.insertItem(grupoDeRecurso);

      return grupoDeRecurso;
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRecursoRepositoryImpl-insertItem'));
    }
  }

  @override
  Future<GrupoDeRecurso> updateItem(GrupoDeRecurso grupoDeRecurso) {
    try {
      return _grupoDeRecursoDatasource.updateItem(grupoDeRecurso);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRecursoRepositoryImpl-updateItem'));
    }
  }

  @override
  Future<bool> deleteItem(String id) {
    return _grupoDeRecursoDatasource.deleteItem(id);
  }
}
