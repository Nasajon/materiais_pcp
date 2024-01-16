import 'package:pcp_flutter/app/modules/restricao/domain/entities/restricao_grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/repositories/get_grupo_de_restricao_repository.dart';

abstract class GetGrupoDeRestricaoUsecase {
  Future<List<RestricaoGrupoDeRestricaoEntity>> call(String search, {String? ultimoGrupoDeRestricaoId});
}

class GetGrupoDeRestricaoUsecaseImpl implements GetGrupoDeRestricaoUsecase {
  final GetGrupoDeRestricaoRepository _getGrupoDeRestricaoRepository;

  const GetGrupoDeRestricaoUsecaseImpl(this._getGrupoDeRestricaoRepository);

  @override
  Future<List<RestricaoGrupoDeRestricaoEntity>> call(String search, {String? ultimoGrupoDeRestricaoId}) {
    return _getGrupoDeRestricaoRepository(search, ultimoGrupoDeRestricaoId: ultimoGrupoDeRestricaoId);
  }
}
