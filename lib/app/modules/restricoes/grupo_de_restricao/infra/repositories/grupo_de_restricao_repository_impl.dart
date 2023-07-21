import 'package:flutter/foundation.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/repositories/grupo_de_restricao_repository.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/infra/datasources/local/grupo_de_restricao_local_datasource.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/infra/datasources/remote/grupo_de_restricao_datasource.dart';

class GrupoDeRestricaoRepositoryImpl implements GrupoDeRestricaoRepository {
  final GrupoDeRestricaoDatasource _grupoDeRestricaoDatasource;
  final GrupoDeRestricaoLocalDatasource _grupoDeRestricaoLocalDatasource;
  final InternetConnectionStore _connectionStore;

  const GrupoDeRestricaoRepositoryImpl(
    this._grupoDeRestricaoDatasource,
    this._grupoDeRestricaoLocalDatasource,
    this._connectionStore,
  );

  @override
  Future<List<GrupoDeRestricaoEntity>> getList(String? search) async {
    try {
      if (kIsWeb || _connectionStore.isOnline) {
        final gruposDeRestricao = await _grupoDeRestricaoDatasource.getList(search);

        if (search == null || search.isEmpty) {
          _grupoDeRestricaoLocalDatasource.clearList();
          _grupoDeRestricaoLocalDatasource.insertList(gruposDeRestricao);
        }

        return gruposDeRestricao;
      }

      return _grupoDeRestricaoLocalDatasource.getList(search);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRestricaoRepositoryImpl-getList'));
    }
  }

  @override
  Future<GrupoDeRestricaoEntity> getItem(String id) {
    try {
      return _grupoDeRestricaoDatasource.getItem(id);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRestricaoRepositoryImpl-getItem'));
    }
  }

  @override
  Future<GrupoDeRestricaoEntity> insertItem(GrupoDeRestricaoEntity grupoDeRestricao) async {
    try {
      if (kIsWeb || _connectionStore.isOnline) {
        return _grupoDeRestricaoDatasource.insertItem(grupoDeRestricao);
      }

      await _grupoDeRestricaoLocalDatasource.insertItem(grupoDeRestricao);

      return grupoDeRestricao;
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRestricaoRepositoryImpl-insertItem'));
    }
  }

  @override
  Future<GrupoDeRestricaoEntity> updateItem(GrupoDeRestricaoEntity grupoDeRestricao) {
    try {
      return _grupoDeRestricaoDatasource.updateItem(grupoDeRestricao);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRestricaoRepositoryImpl-updateItem'));
    }
  }

  @override
  Future<bool> deletarItem(String id) {
    return _grupoDeRestricaoDatasource.deletarItem(id);
  }
}
