import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/repositories/grupo_de_restricao_repository.dart';

abstract class GetGrupoDeRestricaoListUsecase {
  Future<List<GrupoDeRestricaoEntity>> call([String? search]);
}

class GetGrupoDeRestricaoListUsecaseImpl implements GetGrupoDeRestricaoListUsecase {
  final GrupoDeRestricaoRepository _grupoDeRestricaoRepository;

  const GetGrupoDeRestricaoListUsecaseImpl(this._grupoDeRestricaoRepository);

  @override
  Future<List<GrupoDeRestricaoEntity>> call([String? search]) async {
    return _grupoDeRestricaoRepository.getList(search);
  }
}
