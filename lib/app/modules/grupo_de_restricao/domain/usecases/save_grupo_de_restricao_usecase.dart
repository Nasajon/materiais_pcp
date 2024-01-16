import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/repositories/grupo_de_restricao_repository.dart';

abstract class SaveGrupoDeRestricaoUsecase {
  Future<GrupoDeRestricaoEntity> call(GrupoDeRestricaoEntity grupoDeRestricao);
}

class SaveGrupoDeRestricaoUsecaseImpl implements SaveGrupoDeRestricaoUsecase {
  final GrupoDeRestricaoRepository _grupoDeRestricaoRepository;

  SaveGrupoDeRestricaoUsecaseImpl(this._grupoDeRestricaoRepository);

  @override
  Future<GrupoDeRestricaoEntity> call(GrupoDeRestricaoEntity grupoDeRestricao) {
    if (grupoDeRestricao.id != null && grupoDeRestricao.id!.isNotEmpty) {
      return _grupoDeRestricaoRepository.updateItem(grupoDeRestricao);
    }

    return _grupoDeRestricaoRepository.insertItem(grupoDeRestricao);
  }
}
