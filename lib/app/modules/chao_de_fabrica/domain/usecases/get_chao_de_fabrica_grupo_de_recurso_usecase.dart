import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/get_chao_de_fabrica_grupo_de_recurso_repository.dart';

abstract class GetChaoDeFabricaGrupoDeRecursoUsecase {
  Future<List<ChaoDeFabricaGrupoDeRecursoEntity>> call({
    String? ultimoGrupoDeRecursoId,
  });
}

class GetChaoDeFabricaGrupoDeRecursoUsecaseImpl implements GetChaoDeFabricaGrupoDeRecursoUsecase {
  final GetChaoDeFabricaGrupoDeRecursoRepository _grupoDeRecursoRepository;

  const GetChaoDeFabricaGrupoDeRecursoUsecaseImpl({
    required GetChaoDeFabricaGrupoDeRecursoRepository grupoDeRecursoRepository,
  }) : _grupoDeRecursoRepository = grupoDeRecursoRepository;

  @override
  Future<List<ChaoDeFabricaGrupoDeRecursoEntity>> call({
    String? ultimoGrupoDeRecursoId,
  }) {
    return _grupoDeRecursoRepository(ultimoGrupoDeRecursoId: ultimoGrupoDeRecursoId);
  }
}
