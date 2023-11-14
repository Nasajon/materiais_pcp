// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/constants/local_db_key.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/common/external/mapper/local/local_grupo_de_recurso_mapper.dart';
import 'package:pcp_flutter/app/modules/recursos/common/external/mapper/local/local_tipo_de_recurso_mapper.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/infra/datasources/local/grupo_de_recurso_local_datasource.dart';

class GrupoDeRecursoLocalDatasourceImpl implements GrupoDeRecursoLocalDatasource {
  final Database _database;

  GrupoDeRecursoLocalDatasourceImpl(this._database) {
    Hive
      ..resetAdapters()
      ..registerAdapter(LocalGrupoDeRecursoMapper())
      ..registerAdapter(LocalTipoDeRecursoMapper());
  }

  @override
  Future<List<GrupoDeRecurso>> getList(String? search) async {
    final decisions = await _database.get<List?>(LocalDBKeys.grupoDeRecursoKey);

    if (decisions == null) return <GrupoDeRecurso>[];

    final listGrupoDeRecurso = List<GrupoDeRecurso>.from(decisions);

    if (search != null && search.isNotEmpty) {
      return listGrupoDeRecurso
          .where((grupo) => grupo.codigo.toText == search || grupo.descricao.value.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }

    return listGrupoDeRecurso;
  }

  @override
  Future<void> insertList(List<GrupoDeRecurso> gruposDeRecurso) async {
    final requestsLocalDb = await _database.get(LocalDBKeys.grupoDeRecursoKey) ?? <GrupoDeRecurso>[];
    final requestList = List<GrupoDeRecurso>.from(requestsLocalDb);

    for (final grupo in gruposDeRecurso) {
      requestList.removeWhere((request) => request.id == grupo.id);
    }

    final updatedRequests = [...requestList, ...gruposDeRecurso];

    await _database.addUpdate<List<GrupoDeRecurso>>(LocalDBKeys.grupoDeRecursoKey, updatedRequests);
  }

  @override
  Future<void> clearList() async {
    await _database.deleteAll([LocalDBKeys.grupoDeRecursoKey]);
  }

  @override
  Future<void> insertItem(GrupoDeRecurso grupoDeRecurso) async {
    final requestsLocalDb = await _database.get(LocalDBKeys.grupoDeRecursoSyncKey) ?? <GrupoDeRecurso>[];
    final requestList = List<GrupoDeRecurso>.from(requestsLocalDb);

    final updatedRequests = [...requestList, grupoDeRecurso];

    await _database.addUpdate<List<GrupoDeRecurso>>(LocalDBKeys.grupoDeRecursoSyncKey, updatedRequests);
  }
}
