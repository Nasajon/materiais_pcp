import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
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
      final response = await clientService.request(
        ClientRequestParams(
            selectedApi: APIEnum.pcp,
            endPoint: '/1234/fichastecnicas/${fichaTecnica.id}',
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
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/fichastecnicas/$id',
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
          endPoint: '/1234/fichastecnicas/$id?fields=produtos',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );
      var data = RemoteFichaTecnicaMapper.fromMapToFichaTecnica(response.data);
      var setIdProduto = <String>{};
      var setIdUnidade = <String>{};

      if (data.produto != null) {
        setIdProduto.add(data.produto!.id);
      }
      if (data.unidade != null) {
        setIdUnidade.add(data.unidade!.id);
      }

      for (var material in data.materiais) {
        if (material.produto != null && !setIdProduto.contains(material.produto!.id)) {
          setIdProduto.add(material.produto!.id);
        }
        if (material.unidade != null && !setIdUnidade.contains(material.unidade!.id)) {
          setIdUnidade.add(material.unidade!.id);
        }
      }

      var produtos = await remoteProdutoDatasource.getTodosProdutosPorIds(setIdProduto.toList());
      var unidades = await remoteUnidadeDatasource.getTodasUnidadesPorIds(setIdUnidade.toList());

      data = data.copyWith(
          unidade: (data.unidade != null && unidades.containsKey(data.unidade!.id)) ? unidades[data.unidade!.id] : data.unidade,
          produto: (data.produto != null && produtos.containsKey(data.produto!.id)) ? produtos[data.produto!.id] : data.produto,
          materiais: data.materiais
              .map((material) => material.copyWith(
                    unidade: (material.unidade != null && unidades.containsKey(material.unidade!.id))
                        ? unidades[material.unidade!.id]
                        : material.unidade,
                    produto: (material.produto != null && produtos.containsKey(material.produto!.id))
                        ? produtos[material.produto!.id]
                        : material.produto,
                  ))
              .toList());
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
          endPoint: '/1234/fichastecnicas',
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
  Future<List<FichaTecnicaAggregate>> getTodosFichaTecnica(String search) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/fichastecnicas${search.trim() == '' ? '' : '?search=$search'}',
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
          endPoint: '/1234/fichastecnicas',
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

  Future<List<FichaTecnicaAggregate>> preencherProdutosEUnidades(List<FichaTecnicaAggregate> fichasTecnicas) async {
    var setIdProduto = <String>{};
    var setIdUnidade = <String>{};
    if (fichasTecnicas.isEmpty) {
      return fichasTecnicas;
    }
    for (var ficha in fichasTecnicas) {
      if (ficha.produto != null) {
        setIdProduto.add(ficha.produto!.id);
      }
      if (ficha.unidade != null) {
        setIdUnidade.add(ficha.unidade!.id);
      }

      for (var material in ficha.materiais) {
        if (material.produto != null && !setIdProduto.contains(material.produto!.id)) {
          setIdProduto.add(material.produto!.id);
        }
        if (material.unidade != null && !setIdUnidade.contains(material.unidade!.id)) {
          setIdUnidade.add(material.unidade!.id);
        }
      }
    }
    var produtos = await remoteProdutoDatasource.getTodosProdutosPorIds(setIdProduto.toList());
    var unidades = await remoteUnidadeDatasource.getTodasUnidadesPorIds(setIdUnidade.toList());
    return fichasTecnicas.map((ficha) {
      return ficha.copyWith(
        produto: (ficha.produto != null && produtos.containsKey(ficha.produto!.id)) ? produtos[ficha.produto!.id] : ficha.produto,
        unidade: (ficha.unidade != null && unidades.containsKey(ficha.unidade!.id)) ? unidades[ficha.unidade!.id] : ficha.unidade,
        materiais: ficha.materiais.map((material) {
          return material.copyWith(
            produto: (material.produto != null && produtos.containsKey(material.produto!.id))
                ? produtos[material.produto!.id]
                : material.produto,
            unidade: (material.unidade != null && unidades.containsKey(material.unidade!.id))
                ? unidades[material.unidade!.id]
                : material.unidade,
          );
        }).toList(),
      );
    }).toList();
  }
}
