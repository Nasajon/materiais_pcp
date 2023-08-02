import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/produto_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_ficha_tecnica_datasource.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_produto_datasource%20copy.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_unidade_datasource.dart';

class FichaTecnicaRepositoryImpl implements FichaTecnicaRepository {
  final RemoteFichaTecnicaDatasource remoteFichaTecnicaDatasource;
  final RemoteProdutoDatasource remoteProdutoDatasource;
  final RemoteUnidadeDatasource remoteUnidadeDatasource;

  FichaTecnicaRepositoryImpl(
    this.remoteFichaTecnicaDatasource,
    this.remoteProdutoDatasource,
    this.remoteUnidadeDatasource,
  );

  @override
  Future<bool> atualizarFichaTecnica(FichaTecnicaAggregate fichaTecnica) {
    return remoteFichaTecnicaDatasource.atualizarFichaTecnica(fichaTecnica);
  }

  @override
  Future<bool> deletarFichaTecnica(String id) {
    return remoteFichaTecnicaDatasource.deletarFichaTecnica(id);
  }

  @override
  Future<FichaTecnicaAggregate> getFichaTecnicaPorId(String id) async {
    var data = await remoteFichaTecnicaDatasource.getFichaTecnicaPorId(id);
    var setIdProduto = <String>{};
    var setIdUnidade = <String>{};

    setIdProduto.add(data.produto!.id);
    setIdUnidade.add(data.unidade!.id);

    for (var element in data.materiais) {
      if (!setIdProduto.contains(element.produto!.id)) {
        setIdProduto.add(element.produto!.id);
      }
      if (!setIdUnidade.contains(element.unidade!.id)) {
        setIdUnidade.add(element.unidade!.id);
      }
    }

    var produtos = await remoteProdutoDatasource.getTodosProdutosPorIds(setIdProduto.toList());
    var unidades = await remoteUnidadeDatasource.getTodasUnidadesPorIds(setIdUnidade.toList());

    data = data.copyWith(
        unidade: unidades[data.unidade!.id],
        produto: produtos[data.produto!.id],
        materiais: data.materiais
            .map((material) => material.copyWith(unidade: unidades[material.unidade!.id], produto: produtos[material.produto!.id]))
            .toList());
    return data;
  }

  @override
  Future<List<FichaTecnicaAggregate>> getFichaTecnicaRecentes() async {
    var fichasTecnicas = await remoteFichaTecnicaDatasource.getFichaTecnicaRecentes();
    return await preencherProdutosEUnidades(fichasTecnicas);
  }

  Future<List<FichaTecnicaAggregate>> preencherProdutosEUnidades(List<FichaTecnicaAggregate> fichasTecnicas) async {
    var setIdProduto = <String>{};
    var setIdUnidade = <String>{};
    if (fichasTecnicas.isEmpty) {
      return fichasTecnicas;
    }
    for (var ficha in fichasTecnicas) {
      setIdProduto.add(ficha.produto!.id);
      setIdUnidade.add(ficha.unidade!.id);
      for (var material in ficha.materiais) {
        setIdProduto.add(material.produto!.id);
        setIdUnidade.add(material.unidade!.id);
      }
    }
    var produtos = await remoteProdutoDatasource.getTodosProdutosPorIds(setIdProduto.toList());
    var unidades = await remoteUnidadeDatasource.getTodasUnidadesPorIds(setIdUnidade.toList());
    return fichasTecnicas.map((ficha) {
      return ficha.copyWith(
        produto: produtos.containsKey(ficha.produto!.id) ? produtos[ficha.produto!.id] : ficha.produto,
        unidade: unidades.containsKey(ficha.unidade!.id) ? unidades[ficha.unidade!.id] : ficha.unidade,
        materiais: ficha.materiais.map((material) {
          return material.copyWith(
            produto: produtos.containsKey(material.produto!.id) ? produtos[material.produto!.id] : material.produto,
            unidade: unidades.containsKey(material.unidade!.id) ? unidades[material.unidade!.id] : material.unidade,
          );
        }).toList(),
      );
    }).toList();
  }

  @override
  Future<List<FichaTecnicaAggregate>> getTodosFichaTecnica(String search) async {
    var fichasTecnicas = await remoteFichaTecnicaDatasource.getTodosFichaTecnica(search);
    return preencherProdutosEUnidades(fichasTecnicas);
  }

  @override
  Future<FichaTecnicaAggregate> inserirFichaTecnica(FichaTecnicaAggregate fichaTecnica) {
    return remoteFichaTecnicaDatasource.inserirFichaTecnica(fichaTecnica);
  }
}
