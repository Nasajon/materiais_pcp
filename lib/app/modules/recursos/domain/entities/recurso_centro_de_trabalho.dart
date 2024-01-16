// ignore_for_file: public_member_api_docs, sort_constructors_first
class RecursoCentroDeTrabalho {
  final String id;
  final String nome;

  const RecursoCentroDeTrabalho({
    required this.id,
    required this.nome,
  });

  factory RecursoCentroDeTrabalho.empty() {
    return const RecursoCentroDeTrabalho(
      id: '',
      nome: '',
    );
  }

  @override
  bool operator ==(covariant RecursoCentroDeTrabalho other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode;
}
