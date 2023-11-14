import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/ficha_tecnica_entity.dart';

class RemoteFichaTecnicaMapper {
  const RemoteFichaTecnicaMapper._();

  static FichaTecnicaEntity fromMapToFichaTecnicaEntity(Map<String, dynamic> map) {
    return FichaTecnicaEntity(
      id: map['ficha_tecnica'],
      codigo: map['codigo'],
      descricao: map['descricao'],
    );
  }
}
