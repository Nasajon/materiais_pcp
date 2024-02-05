import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';

class RemoteChaoDeFabricaCentroDeTrabalhoMapper {
  const RemoteChaoDeFabricaCentroDeTrabalhoMapper._();

  static ChaoDeFabricaCentroDeTrabalhoEntity fromMapToCentroDeTrabalho(Map<String, dynamic> map) {
    try {
      return ChaoDeFabricaCentroDeTrabalhoEntity(
        id: map['centro_de_trabalho'],
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
