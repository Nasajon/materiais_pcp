import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/get_chao_de_fabrica_centro_de_trabalho_repository.dart';

abstract class GetChaoDeFabricaCentroDeTrabalhoUsecase {
  Future<List<ChaoDeFabricaCentroDeTrabalhoEntity>> call({
    required String search,
    String? ultimoCentroDeTrabalhoId,
  });
}

class GetChaoDeFabricaCentroDeTrabalhoUsecaseImpl implements GetChaoDeFabricaCentroDeTrabalhoUsecase {
  final GetChaoDeFabricaCentroDeTrabalhoRepository _centroDeTrabalhoRepository;

  const GetChaoDeFabricaCentroDeTrabalhoUsecaseImpl({
    required GetChaoDeFabricaCentroDeTrabalhoRepository centroDeTrabalhoRepository,
  }) : _centroDeTrabalhoRepository = centroDeTrabalhoRepository;

  @override
  Future<List<ChaoDeFabricaCentroDeTrabalhoEntity>> call({
    required String search,
    String? ultimoCentroDeTrabalhoId,
  }) {
    return _centroDeTrabalhoRepository(search: search, ultimoCentroDeTrabalhoId: ultimoCentroDeTrabalhoId);
  }
}
