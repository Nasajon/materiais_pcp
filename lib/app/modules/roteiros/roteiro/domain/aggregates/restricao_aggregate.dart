import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/dtos/restricao_capacidade_dto.dart';

class RestricaoAggregate {
  final String id;
  final String codigo;
  final String nome;
  final RestricaoCapacidadeDTO restricaoCapacidade;

  const RestricaoAggregate({
    required this.id,
    required this.codigo,
    required this.nome,
    required this.restricaoCapacidade,
  });

  RestricaoAggregate copyWith({
    String? id,
    String? codigo,
    String? nome,
    RestricaoCapacidadeDTO? restricaoCapacidade,
  }) {
    return RestricaoAggregate(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      restricaoCapacidade: restricaoCapacidade ?? this.restricaoCapacidade,
    );
  }

  @override
  bool operator ==(covariant RestricaoAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome && other.restricaoCapacidade == restricaoCapacidade;
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ restricaoCapacidade.hashCode;
  }

  bool get isValid => id.isNotEmpty && restricaoCapacidade.isValid;
}
