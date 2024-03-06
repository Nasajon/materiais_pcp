// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChaoDeFabricaOperacaoEntity {
  final String id;
  final String operacaoOrdemId;
  final String codigo;
  final String nome;

  const ChaoDeFabricaOperacaoEntity({
    required this.id,
    required this.operacaoOrdemId,
    required this.codigo,
    required this.nome,
  });

  factory ChaoDeFabricaOperacaoEntity.empty() {
    return const ChaoDeFabricaOperacaoEntity(
      id: '',
      operacaoOrdemId: '',
      codigo: '',
      nome: '',
    );
  }

  ChaoDeFabricaOperacaoEntity copyWith({
    String? id,
    String? operacaoOrdemId,
    String? codigo,
    String? nome,
  }) {
    return ChaoDeFabricaOperacaoEntity(
      id: id ?? this.id,
      operacaoOrdemId: operacaoOrdemId ?? this.operacaoOrdemId,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaOperacaoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.operacaoOrdemId == operacaoOrdemId && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode {
    return id.hashCode ^ operacaoOrdemId.hashCode ^ codigo.hashCode ^ nome.hashCode;
  }
}
