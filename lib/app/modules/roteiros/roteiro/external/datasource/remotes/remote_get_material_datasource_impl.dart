import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_material_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_produto_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_unidade_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_material_datasource.dart';

class RemoteGetMaterialDatasourceImpl implements RemoteGetMaterialDatasource {
  final IClientService _clientService;

  RemoteGetMaterialDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<MaterialEntity>> call(String fichaTecnicaId) async {
    try {
      final responseMateriais = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/fichastecnicas/$fichaTecnicaId?fields=produtos,unidades',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );

      var materiais = List.from(responseMateriais.data).map((map) => RemoteMaterialMapper.fromMapToMaterialEntity(map)).toList();

      if (materiais.isNotEmpty) {
        materiais = await _getProdutosPorIds(materiais);
        materiais = await _getUnidadesPorIds(materiais);
      }

      return materiais;
    } on ClientError catch (e) {
      throw RemoteDatasourceRoteiroFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  Future<List<MaterialEntity>> _getProdutosPorIds(List<MaterialEntity> materiais) async {
    String produtosId = materiais.map((material) => material.produto.id).toList().join(',');

    final responseProduto = await _clientService.request(
      ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/4311/produtos?id=$produtosId',
        method: ClientRequestMethods.GET,
        interceptors: interceptors,
      ),
    );

    materiais
        .map(
          (material) => material.copyWith(
            produto: List.from(responseProduto.data['result'])
                .map((produtoMap) => RemoteProdutoMapper.fromMapToProdutoEntity(produtoMap))
                .toList()
                .where((produto) => material.produto.id == produto.id)
                .first,
          ),
        )
        .toList();

    return materiais;
  }

  Future<List<MaterialEntity>> _getUnidadesPorIds(List<MaterialEntity> materiais) async {
    String unidadesId = materiais.map((material) => material.unidade.id).toList().join(',');

    final responseUnidade = await _clientService.request(
      ClientRequestParams(
        selectedApi: APIEnum.dadosmestre,
        endPoint: '/4311/unidades?id=$unidadesId',
        method: ClientRequestMethods.GET,
        interceptors: interceptors,
      ),
    );

    materiais
        .map(
          (material) => material.copyWith(
            unidade: List.from(responseUnidade.data['result'])
                .map((unidadeMap) => RemoteUnidadeMapper.fromMapToUnidadeEntity(unidadeMap))
                .toList()
                .where((unidade) => material.unidade.id == unidade.id)
                .first,
          ),
        )
        .toList();

    return materiais;
  }
}
