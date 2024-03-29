import 'package:pcp_flutter/app/modules/restricao/domain/entities/restricao_centro_de_trabalho.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/repositories/get_centro_de_trabalho_repository.dart';

abstract class GetCentroDeTrabalhoUsecase {
  Future<List<RestricaoCentroDeTrabalho>> call({required String search, String? ultimoCentroDeTrabalhoId});
}

class GetCentroDeTrabalhoUsecaseImpl implements GetCentroDeTrabalhoUsecase {
  final GetCentroDeTrabalhoRepository _getCentroDeTrabalhoRepository;

  const GetCentroDeTrabalhoUsecaseImpl(this._getCentroDeTrabalhoRepository);

  @override
  Future<List<RestricaoCentroDeTrabalho>> call({required String search, String? ultimoCentroDeTrabalhoId}) {
    return _getCentroDeTrabalhoRepository(search: search, ultimoCentroDeTrabalhoId: ultimoCentroDeTrabalhoId);
  }
}
