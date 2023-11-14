import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/cliente_entity.dart';

abstract interface class RemoteGetClienteDatasource {
  Future<List<ClienteEntity>> call({String search = '', String ultimoId = ''});
}
