import 'package:pcp_flutter/app/modules/roteiro/domain/entities/centro_de_trabalho_entity.dart';

class RemoteCentroDeTrabalhoMapper {
  const RemoteCentroDeTrabalhoMapper._();

  static CentroDeTrabalhoEntity fromMapToCentroDeTrabalho(Map<String, dynamic> map) {
    return CentroDeTrabalhoEntity(
      id: map['centro_de_trabalho'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }
}
