import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/mappers/remotes/remote_ficha_tecnica_mapper.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_ficha_tecnica_datasource.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_produto_datasource%20copy.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_unidade_datasource.dart';

class RemoteFichaTecnicaDatasourceImpl implements RemoteFichaTecnicaDatasource {
  final IClientService clientService;

  final RemoteUnidadeDatasource remoteUnidadeDatasource;
  final RemoteProdutoDatasource remoteProdutoDatasource;

  RemoteFichaTecnicaDatasourceImpl(
    this.clientService,
    this.remoteUnidadeDatasource,
    this.remoteProdutoDatasource,
  );

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<bool> atualizarFichaTecnica(FichaTecnicaAggregate fichaTecnica) async {
    try {
      await clientService.request(
        ClientRequestParams(
            selectedApi: APIEnum.pcp,
            endPoint: '/fichastecnicas/${fichaTecnica.id}',
            method: ClientRequestMethods.PUT,
            interceptors: interceptors,
            body: RemoteFichaTecnicaMapper.fromFichaTecnicaToMap(fichaTecnica)),
      );

      return true;
    } on ClientError catch (e) {
      throw DatasourceFichaTecnicaFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<bool> deletarFichaTecnica(String id) async {
    try {
      await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/fichastecnicas/$id',
          method: ClientRequestMethods.DELETE,
          interceptors: interceptors,
        ),
      );
      return true;
    } on ClientError catch (e) {
      throw DatasourceFichaTecnicaFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<FichaTecnicaAggregate> getFichaTecnicaPorId(String id) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/fichastecnicas/$id?fields=produtos.unidade, produtos.produto, produto, unidade',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );
      var data = RemoteFichaTecnicaMapper.fromMapToFichaTecnica(response.data);
      return data;
    } on ClientError catch (e) {
      throw DatasourceFichaTecnicaFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<List<FichaTecnicaAggregate>> getFichaTecnicaRecentes() async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/fichastecnicas?fields=produto, unidade',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );

      var data = List.from(response.data).map((map) => RemoteFichaTecnicaMapper.fromMapToFichaTecnica(map)).toList();
      // data = await preencherProdutosEUnidades(data);
      return data;
    } on ClientError catch (e) {
      throw DatasourceFichaTecnicaFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<List<FichaTecnicaAggregate>> getTodosFichaTecnica(String search) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/fichastecnicas${search.trim() == '' ? '' : '?search=$search'}',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );

      var data = List.from(response.data).map((map) => RemoteFichaTecnicaMapper.fromMapToFichaTecnica(map)).toList();
      data = await preencherProdutosEUnidades(data);
      return data;
    } on ClientError catch (e) {
      throw DatasourceFichaTecnicaFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<FichaTecnicaAggregate> inserirFichaTecnica(FichaTecnicaAggregate fichaTecnica) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/fichastecnicas',
          method: ClientRequestMethods.POST,
          interceptors: interceptors,
          body: RemoteFichaTecnicaMapper.fromFichaTecnicaToMap(fichaTecnica),
        ),
      );

      fichaTecnica = fichaTecnica.copyWith(id: response.data['ficha_tecnica']);

      return fichaTecnica;
    } on ClientError catch (e) {
      throw DatasourceFichaTecnicaFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  // TODO: Verificar essa parte
  Future<List<FichaTecnicaAggregate>> preencherProdutosEUnidades(List<FichaTecnicaAggregate> fichasTecnicas) async {
    var setIdProduto = <String>{};
    var setIdUnidade = <String>{};
    if (fichasTecnicas.isEmpty) {
      return fichasTecnicas;
    }
    for (var ficha in fichasTecnicas) {
      if (ficha.produto != ProdutoEntity.empty()) {
        setIdProduto.add(ficha.produto.id);
      }
      if (ficha.unidade != UnidadeEntity.empty()) {
        setIdUnidade.add(ficha.unidade.id);
      }

      for (var material in ficha.materiais) {
        if (material.produto != ProdutoEntity.empty() && !setIdProduto.contains(material.produto.id)) {
          setIdProduto.add(material.produto.id);
        }
        if (material.unidade != UnidadeEntity.empty() && !setIdUnidade.contains(material.unidade.id)) {
          setIdUnidade.add(material.unidade.id);
        }
      }
    }
    var produtos = await remoteProdutoDatasource.getTodosProdutosPorIds(setIdProduto.toList());
    var unidades = await remoteUnidadeDatasource.getTodasUnidadesPorIds(setIdUnidade.toList());
    return fichasTecnicas.map((ficha) {
      return ficha.copyWith(
        produto: (produtos.containsKey(ficha.produto.id)) ? produtos[ficha.produto.id] : ficha.produto,
        unidade: (unidades.containsKey(ficha.unidade.id)) ? unidades[ficha.unidade.id] : ficha.unidade,
        materiais: ficha.materiais.map((material) {
          return material.copyWith(
            produto: (material.produto != ProdutoEntity.empty() && produtos.containsKey(material.produto.id))
                ? produtos[material.produto.id]
                : material.produto,
            unidade: (material.unidade != UnidadeEntity.empty() && unidades.containsKey(material.unidade.id))
                ? unidades[material.unidade.id]
                : material.unidade,
          );
        }).toList(),
      );
    }).toList();
  }
}
