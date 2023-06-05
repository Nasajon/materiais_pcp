import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/external/mapper/local/local_grupo_de_restricao_mapper.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/external/mapper/local/local_tipo_de_restricao_mapper.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/infra/datasources/local/grupo_de_restricao_local_datasource.dart';
import 'package:pcp_flutter/app/core/constants/local_db_key.dart';

class GrupoDeRestricaoLocalDatasourceImpl implements GrupoDeRestricaoLocalDatasource {
  final Database _database;

  GrupoDeRestricaoLocalDatasourceImpl(this._database) {
    Hive
      ..resetAdapters()
      ..registerAdapter(LocalGrupoDeRestricaoMapper())
      ..registerAdapter(LocalTipoDeRestricaoMapper());
  }

  @override
  Future<List<GrupoDeRestricaoEntity>> getList(String? search) async {
    final decisions = await _database.get<List?>(LocalDBKeys.grupoDeRestricaoKey);

    if (decisions == null) return <GrupoDeRestricaoEntity>[];

    final list = List<GrupoDeRestricaoEntity>.from(decisions);

    if (search != null && search.isNotEmpty) {
      return list
          .where((grupo) =>
              grupo.codigo == search ||
              grupo.descricao.value.toLowerCase().contains(search.toLowerCase()) ||
              (grupo.tipo != null && grupo.tipo.name.toLowerCase().contains(search.toLowerCase())))
          .toList();
    }

    return list;
  }

  @override
  Future<void> insertList(List<GrupoDeRestricaoEntity> gruposDeRestricao) async {
    final requestsLocalDb = await _database.get(LocalDBKeys.grupoDeRestricaoKey) ?? <GrupoDeRestricaoEntity>[];
    final requestList = List<GrupoDeRestricaoEntity>.from(requestsLocalDb);

    for (final grupo in gruposDeRestricao) {
      requestList.removeWhere((request) => request.id == grupo.id);
    }

    final updatedRequests = [...requestList, ...gruposDeRestricao];

    await _database.addUpdate<List<GrupoDeRestricaoEntity>>(LocalDBKeys.grupoDeRestricaoKey, updatedRequests);
  }

  @override
  Future<void> clearList() async {
    await _database.deleteAll([LocalDBKeys.grupoDeRestricaoKey]);
  }

  @override
  Future<void> insertItem(GrupoDeRestricaoEntity grupoDeRestricao) async {
    final requestsLocalDb = await _database.get(LocalDBKeys.grupoDeRestricaoSyncKey) ?? <GrupoDeRestricaoEntity>[];
    final requestList = List<GrupoDeRestricaoEntity>.from(requestsLocalDb);

    final updatedRequests = [...requestList, grupoDeRestricao];

    await _database.addUpdate<List<GrupoDeRestricaoEntity>>(LocalDBKeys.grupoDeRestricaoSyncKey, updatedRequests);
  }
}
