import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/recurso_centro_de_trabalho.dart';

abstract class GetCentroDeTrabalhoRepository {
  Future<List<RecursoCentroDeTrabalho>> call({required String search, String? ultimoCentroDeTrabalhoId});
}
