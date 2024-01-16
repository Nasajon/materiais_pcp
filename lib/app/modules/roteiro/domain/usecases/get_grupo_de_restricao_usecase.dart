import 'package:pcp_flutter/app/modules/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_grupo_de_restricao_repository.dart';

abstract class GetGrupoDeRestricaoUsecase {
  Future<List<GrupoDeRestricaoEntity>> call(String search);
}

class GetGrupoDeRestricaoUsecaseImpl implements GetGrupoDeRestricaoUsecase {
  final GetGrupoDeRestricaoRepository _getGrupoDeRestricaoRepository;

  const GetGrupoDeRestricaoUsecaseImpl(this._getGrupoDeRestricaoRepository);

  @override
  Future<List<GrupoDeRestricaoEntity>> call(String search) {
    return _getGrupoDeRestricaoRepository(search);
  }
}
