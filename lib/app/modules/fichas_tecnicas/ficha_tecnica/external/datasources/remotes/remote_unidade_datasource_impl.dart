import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/mappers/remotes/remote_unidade_mapper.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_unidade_datasource.dart';

class RemoteUnidadeDatasourceImpl implements RemoteUnidadeDatasource {
  final IClientService clientService;

  RemoteUnidadeDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];
  var unidadesMock = [
    {"unidade": "e9bc4ce7-fa34-4d93-86f7-a9a34d4bf68e", "codigo": "GR", "nome": "Grama"},
    {"unidade": "482cb303-0a84-46a6-a8e6-5345fd655c70", "codigo": "KG", "nome": "Kilo"},
    {"unidade": "8ae427ed-c32b-4bb8-b0cd-1cfed48c309b", "codigo": "T", "nome": "Tonelada"},
    {"unidade": "fca69f81-ddd6-47ff-ade7-c516488e90ad", "codigo": "LT", "nome": "unidade"},
    {"unidade": "2ad0f887-f9f5-469f-83f4-6f7acf4de211", "codigo": "ML", "nome": "unidade 4"},
    {"unidade": "ec870668-fb64-495c-a7ac-abfeb64bd3c9", "codigo": "CM", "nome": "unidade 6"},
    {"unidade": "edcb6c5b-8cd4-48e5-b098-98814835b2cd", "codigo": "KM", "nome": "unidade 7"},
  ];

  @override
  Future<UnidadeEntity> getUnidadePorId(String id) {
    var res = unidadesMock.where((el) => el['unidade'] == id).toList().map((map) => RemoteUnidadeMapper.fromMapToUnidade(map)).toList();
    if (res.length == 1) {
      return Future.value(res[0]);
    }
    throw ClientError(message: "Unidade Not found");
  }

  @override
  Future<List<UnidadeEntity>> getTodasUnidades(String search) async {
    return unidadesMock
        .where((el) =>
            (search == '') ||
            (el['codigo']?.toLowerCase() != null && el['codigo']!.toLowerCase().contains(search.toLowerCase().trim())) ||
            (el['nome']?.toLowerCase() != null && el['nome']!.toLowerCase().contains(search.toLowerCase().trim())))
        .toList()
        .map((map) => RemoteUnidadeMapper.fromMapToUnidade(map))
        .toList();
  }

  @override
  Future<Map<String, UnidadeEntity>> getTodasUnidadesPorIds(List<String> ids) {
    var idSet = ids.toSet();
    var unidadesList =
        unidadesMock.where((el) => idSet.contains(el['unidade'])).toList().map((map) => RemoteUnidadeMapper.fromMapToUnidade(map)).toList();
    var unidadesMap = {for (var u in unidadesList) u.id: u};

    if (unidadesMap.isNotEmpty) {
      return Future.value(unidadesMap);
    }
    throw ClientError(message: "Unidades Not found");
  }
}
