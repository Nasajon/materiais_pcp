import 'package:flutter_core/ana_core.dart';

import '../../domain/entities/grupo_de_recurso.dart';
import '../../domain/repositories/grupo_de_recursos_repository.dart';
import '../datasources/grupo_de_recurso_datasource.dart';

class GrupoDeRecursoRepositoryImpl implements GrupoDeRecursosRepository {
  final GrupoDeRecursoDatasource datasource;

  GrupoDeRecursoRepositoryImpl(this.datasource);

  @override
  Future<List<GrupoDeRecurso>> getList(String? search) {
    try {
      return datasource.getList(search);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'GrupoDeRecursoRepositoryImpl-getList'));
    }
  }

  @override
  Future<GrupoDeRecurso> getItem(String id) {
    try {
      return datasource.getItem(id);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'GrupoDeRecursoRepositoryImpl-getItem'));
    }
  }

  @override
  Future<GrupoDeRecurso> insertItem(GrupoDeRecurso grupoDeRecurso) {
    try {
      return datasource.insertItem(grupoDeRecurso);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'GrupoDeRecursoRepositoryImpl-insertItem'));
    }
  }

  @override
  Future<GrupoDeRecurso> updateItem(GrupoDeRecurso grupoDeRecurso) {
    try {
      return datasource.updateItem(grupoDeRecurso);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'GrupoDeRecursoRepositoryImpl-updateItem'));
    }
  }
}
