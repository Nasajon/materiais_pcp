import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';

import '../../domain/repositories/grupo_de_recursos_repository.dart';
import '../datasources/remote/grupo_de_recurso_datasource.dart';

class GrupoDeRecursoRepositoryImpl implements GrupoDeRecursosRepository {
  final GrupoDeRecursoDatasource _grupoDeRecursoDatasource;

  const GrupoDeRecursoRepositoryImpl(this._grupoDeRecursoDatasource);

  @override
  Future<List<GrupoDeRecurso>> getList(String? search) async {
    return _grupoDeRecursoDatasource.getList(search);
  }

  @override
  Future<List<GrupoDeRecurso>> getGrupoDeRecursoRecente() async {
    return _grupoDeRecursoDatasource.getGrupoDeRecursoRecente();
  }

  @override
  Future<GrupoDeRecurso> getItem(String id) {
    return _grupoDeRecursoDatasource.getItem(id);
  }

  @override
  Future<GrupoDeRecurso> insertItem(GrupoDeRecurso grupoDeRecurso) async {
    return _grupoDeRecursoDatasource.insertItem(grupoDeRecurso);
  }

  @override
  Future<GrupoDeRecurso> updateItem(GrupoDeRecurso grupoDeRecurso) {
    return _grupoDeRecursoDatasource.updateItem(grupoDeRecurso);
  }

  @override
  Future<bool> deleteItem(String id) {
    return _grupoDeRecursoDatasource.deleteItem(id);
  }
}
