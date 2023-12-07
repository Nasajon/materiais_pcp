import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/cliente_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_cliente_repository.dart';

abstract interface class GetClienteUsecase {
  Future<List<ClienteEntity>> call({String search = '', String ultimoId = ''});
}

class GetClienteUsecaseImpl implements GetClienteUsecase {
  final GetClienteRepository _getClienteRepository;

  const GetClienteUsecaseImpl({required GetClienteRepository getClienteRepository}) : _getClienteRepository = getClienteRepository;

  @override
  Future<List<ClienteEntity>> call({String search = '', String ultimoId = ''}) {
    return _getClienteRepository(search: search, ultimoId: ultimoId);
  }
}
