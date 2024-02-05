// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChaoDeFabricaOperacaoEntity {
  final String id;
  final String OperacaoOrdemId;
  final String codigo;
  final String nome;

  const ChaoDeFabricaOperacaoEntity({
    required this.id,
    required this.OperacaoOrdemId,
    required this.codigo,
    required this.nome,
  });

  ChaoDeFabricaOperacaoEntity copyWith({
    String? id,
    String? OperacaoOrdemId,
    String? codigo,
    String? nome,
  }) {
    return ChaoDeFabricaOperacaoEntity(
      id: id ?? this.id,
      OperacaoOrdemId: OperacaoOrdemId ?? this.OperacaoOrdemId,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaOperacaoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.OperacaoOrdemId == OperacaoOrdemId && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode {
    return id.hashCode ^ OperacaoOrdemId.hashCode ^ codigo.hashCode ^ nome.hashCode;
  }
}
