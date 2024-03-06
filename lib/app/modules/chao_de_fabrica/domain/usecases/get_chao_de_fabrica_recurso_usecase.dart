import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/get_chao_de_fabrica_recurso_repository.dart';

abstract class GetChaoDeFabricaRecursoUsecase {
  Future<List<ChaoDeFabricaRecursoEntity>> call({
    required String search,
    String? ultimoRecursoId,
  });
}

class GetChaoDeFabricaRecursoUsecaseImpl implements GetChaoDeFabricaRecursoUsecase {
  final GetChaoDeFabricaRecursoRepository _recursoRepository;

  const GetChaoDeFabricaRecursoUsecaseImpl({
    required GetChaoDeFabricaRecursoRepository recursoRepository,
  }) : _recursoRepository = recursoRepository;

  @override
  Future<List<ChaoDeFabricaRecursoEntity>> call({
    required String search,
    String? ultimoRecursoId,
  }) {
    return _recursoRepository(search: search, ultimoRecursoId: ultimoRecursoId);
  }
}
