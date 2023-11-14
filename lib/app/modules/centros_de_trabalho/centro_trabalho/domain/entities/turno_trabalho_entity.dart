import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';

class TurnoTrabalhoEntity {
  final String id;
  final CodigoVO codigo;
  final String nome;

  const TurnoTrabalhoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  @override
  bool operator ==(covariant TurnoTrabalhoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
