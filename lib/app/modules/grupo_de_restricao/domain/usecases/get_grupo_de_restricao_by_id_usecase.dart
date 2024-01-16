import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/errors/grupo_de_restricao_failures.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/repositories/grupo_de_restricao_repository.dart';

abstract class GetGrupoDeRestricaoByIdUsecase {
  Future<GrupoDeRestricaoEntity> call(String id);
}

class GetGrupoDeRestricaoByIdUsecaseImpl implements GetGrupoDeRestricaoByIdUsecase {
  final GrupoDeRestricaoRepository _grupoDeRestricaoRepository;

  const GetGrupoDeRestricaoByIdUsecaseImpl(this._grupoDeRestricaoRepository);

  @override
  Future<GrupoDeRestricaoEntity> call(String id) {
    if (id.isEmpty) {
      return Future.error(GrupoDeRestricaoInvalidIdError());
    }

    return _grupoDeRestricaoRepository.getItem(id);
  }
}
