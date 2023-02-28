import 'package:flutter_core/ana_core.dart';

import '../../domain/entities/recurso.dart';
import '../../domain/repositories/recurso_repository.dart';
import '../datasources/recurso_datasource.dart';

class RecursoRepositoryImpl implements RecursoRepository {
  final RecursoDatasource _recursoDatasource;

  RecursoRepositoryImpl(this._recursoDatasource);

  @override
  Future<List<Recurso>> getList(String? search) {
    try {
      return _recursoDatasource.getList(search);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'RecursoRepositoryImpl-getList'));
    }
  }

  @override
  Future<Recurso> getItem(String id) {
    try {
      return _recursoDatasource.getItem(id);
    } on Failure catch (e) {
      return Future.error(e);
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'RecursoRepositoryImpl-getItem'));
    }
  }

  @override
  Future<Recurso> insertItem(Recurso recurso) {
    try {
      return _recursoDatasource.insertItem(recurso);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'RecursoRepositoryImpl-insertItem'));
    }
  }

  @override
  Future<Recurso> updateItem(Recurso recurso) {
    try {
      return _recursoDatasource.updateItem(recurso);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'RecursoRepositoryImpl-updateItem'));
    }
  }
}
