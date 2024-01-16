import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';

abstract class GetCentroTrabalhoRecenteUsecase {
  Future<List<CentroTrabalhoAggregate>> call();
}

class GetCentroTrabalhoRecenteUsecaseImpl implements GetCentroTrabalhoRecenteUsecase {
  final CentroTrabalhoRepository _centroTrabalhoRepository;

  const GetCentroTrabalhoRecenteUsecaseImpl(this._centroTrabalhoRepository);

  @override
  Future<List<CentroTrabalhoAggregate>> call() {
    return _centroTrabalhoRepository.getCentroTrabalhoRecentes();
  }
}
