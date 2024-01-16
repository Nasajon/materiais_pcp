import 'package:pcp_flutter/app/modules/restricao/domain/entities/restricao_centro_de_trabalho.dart';

class RemoteRestricaoCentroDeTrabalhoMapper {
  const RemoteRestricaoCentroDeTrabalhoMapper._();

  static RestricaoCentroDeTrabalho fromMapToRestricaoCentroDeTrabalho(Map<String, dynamic> map) {
    return RestricaoCentroDeTrabalho(
      id: map['centro_de_trabalho'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }
}
