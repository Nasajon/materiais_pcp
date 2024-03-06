import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_apontamento_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_apontamento_mapper.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_chao_de_fabrica_apontamento_datasource.dart';

class RemoteChaoDeFabricaApontamentoDatasourceImpl implements RemoteChaoDeFabricaApontamentoDatasource {
  final IClientService _clientService;

  RemoteChaoDeFabricaApontamentoDatasourceImpl({required IClientService clientService}) : _clientService = clientService;

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<void> call(ChaoDeFabricaApontamentoEntity apontamento) async {
    try {
      await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/apontamentosatividades',
          method: ClientRequestMethods.POST,
          interceptors: interceptors,
          body: RemoteChaoDeFabricaApontamentoMapper.fromChaoDeFabricaApontamentoToMap(apontamento),
        ),
      );
    } on ClientError catch (e) {
      throw DatasourceChaoDeFabricaFailure(
        errorMessage: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }
}
