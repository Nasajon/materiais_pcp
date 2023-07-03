import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/repositories/get_grupo_de_restricao_repository.dart';

abstract class GetGrupoDeRestricaoUsecase {
  Future<List<GrupoDeRestricaoEntity>> call();
}

class GetGrupoDeRestricaoUsecaseImpl implements GetGrupoDeRestricaoUsecase {
  final GetGrupoDeRestricaoRepository _getGrupoDeRestricaoRepository;

  const GetGrupoDeRestricaoUsecaseImpl(this._getGrupoDeRestricaoRepository);

  @override
  Future<List<GrupoDeRestricaoEntity>> call() {
    return _getGrupoDeRestricaoRepository();
  }
}