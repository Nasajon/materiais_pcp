import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/restricao_centro_de_trabalho.dart';

abstract class GetCentroDeTrabalhoRepository {
  Future<List<RestricaoCentroDeTrabalho>> call({required String search, String? ultimoCentroDeTrabalhoId});
}
