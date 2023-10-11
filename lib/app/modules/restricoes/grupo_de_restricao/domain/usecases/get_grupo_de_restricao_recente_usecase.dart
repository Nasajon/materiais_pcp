import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/repositories/grupo_de_restricao_repository.dart';

abstract class GetGrupoDeRestricaoRecenteUsecase {
  Future<List<GrupoDeRestricaoEntity>> call();
}

class GetGrupoDeRestricaoRecenteUsecaseImpl implements GetGrupoDeRestricaoRecenteUsecase {
  final GrupoDeRestricaoRepository _grupoDeRestricaoRepository;

  const GetGrupoDeRestricaoRecenteUsecaseImpl(this._grupoDeRestricaoRepository);

  @override
  Future<List<GrupoDeRestricaoEntity>> call() async {
    return _grupoDeRestricaoRepository.getGrupoDeRestricaoRecente();
  }
}
