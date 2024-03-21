import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';

class RemoteChaoDeFabricaGrupoDeRecursoMapper {
  const RemoteChaoDeFabricaGrupoDeRecursoMapper._();

  static ChaoDeFabricaGrupoDeRecursoEntity fromMapToGrupoDeRecurso(Map<String, dynamic> map) {
    try {
      return ChaoDeFabricaGrupoDeRecursoEntity(
        id: map['grupo_de_recurso'],
        codigo: map['codigo'],
        nome: map['nome'],
      );
    } catch (e) {
      throw MapperChaoDeFabricaFailure(
        errorMessage: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }
}
