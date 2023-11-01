// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/cliente_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_cliente_usecase.dart';

class GetClienteStore extends NasajonNotifierStore<List<ClienteEntity>> {
  final GetClienteUsecase _getClienteUsecase;

  GetClienteStore(this._getClienteUsecase) : super(initialState: []);

  void getList({required search, Duration delay = const Duration(milliseconds: 500)}) {
    setLoading(true);
    execute(() async {
      final response = await _getClienteUsecase(search: search);

      return response;
    }, delay: delay);
  }

  Future<List<ClienteEntity>> getListClientes({required search}) {
    return _getClienteUsecase(search: search);
  }

  Future<List<ClienteEntity>> getListClientesProximaPagina({required search, required String ultimoId}) {
    return _getClienteUsecase(search: search, ultimoId: ultimoId);
  }
}
