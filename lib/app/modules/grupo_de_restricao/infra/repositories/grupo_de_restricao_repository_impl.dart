import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/repositories/grupo_de_restricao_repository.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/infra/datasources/remote/grupo_de_restricao_datasource.dart';

class GrupoDeRestricaoRepositoryImpl implements GrupoDeRestricaoRepository {
  final GrupoDeRestricaoDatasource _grupoDeRestricaoDatasource;

  const GrupoDeRestricaoRepositoryImpl(this._grupoDeRestricaoDatasource);

  @override
  Future<List<GrupoDeRestricaoEntity>> getGrupoDeRestricaoRecente() {
    return _grupoDeRestricaoDatasource.getGrupoDeRestricaoRecente();
  }

  @override
  Future<List<GrupoDeRestricaoEntity>> getList(String? search) {
    return _grupoDeRestricaoDatasource.getList(search);
  }

  @override
  Future<GrupoDeRestricaoEntity> getItem(String id) {
    return _grupoDeRestricaoDatasource.getItem(id);
  }

  @override
  Future<GrupoDeRestricaoEntity> insertItem(GrupoDeRestricaoEntity grupoDeRestricao) async {
    return _grupoDeRestricaoDatasource.insertItem(grupoDeRestricao);
  }

  @override
  Future<GrupoDeRestricaoEntity> updateItem(GrupoDeRestricaoEntity grupoDeRestricao) {
    return _grupoDeRestricaoDatasource.updateItem(grupoDeRestricao);
  }

  @override
  Future<bool> deletarItem(String id) {
    return _grupoDeRestricaoDatasource.deletarItem(id);
  }
}
