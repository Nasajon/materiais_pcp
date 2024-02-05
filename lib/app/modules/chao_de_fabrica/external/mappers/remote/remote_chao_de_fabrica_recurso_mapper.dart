import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';

class RemoteChaoDeFabricaRecursoMapper {
  const RemoteChaoDeFabricaRecursoMapper._();

  static ChaoDeFabricaRecursoEntity fromMapToRecurso(Map<String, dynamic> map) {
    try {
      return ChaoDeFabricaRecursoEntity(
        id: map['recurso'],
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
