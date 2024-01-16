import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso_centro_de_trabalho.dart';

class RecursoCentroDeTrabalhoMapper {
  const RecursoCentroDeTrabalhoMapper._();

  static RecursoCentroDeTrabalho fromMapToRecursoCentroDeTrabalho(Map<String, dynamic> map) {
    return RecursoCentroDeTrabalho(
      id: map['centro_de_trabalho'],
      nome: map['nome'],
    );
  }
}
