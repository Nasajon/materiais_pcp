import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/recurso_entity.dart';

class RemoteRecursoMapper {
  const RemoteRecursoMapper._();

  static RecursoEntity fromMapToRecurso(Map<String, dynamic> map) {
    return RecursoEntity(
      id: map['recurso'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }
}
