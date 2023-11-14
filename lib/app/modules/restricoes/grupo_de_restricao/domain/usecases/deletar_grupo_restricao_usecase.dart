import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/errors/grupo_de_restricao_failures.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/repositories/grupo_de_restricao_repository.dart';

abstract class DeletarGrupoDeRestricaoUsecase {
  Future<bool> call(String id);
}

class DeletarGrupoDeRestricaoUsecaseImpl implements DeletarGrupoDeRestricaoUsecase {
  final GrupoDeRestricaoRepository _grupoDeRestricaoRepository;

  const DeletarGrupoDeRestricaoUsecaseImpl(this._grupoDeRestricaoRepository);

  @override
  Future<bool> call(String id) {
    if (id.isEmpty) {
      throw GrupoDeRestricaoInvalidIdError();
    }

    return _grupoDeRestricaoRepository.deletarItem(id);
  }
}
