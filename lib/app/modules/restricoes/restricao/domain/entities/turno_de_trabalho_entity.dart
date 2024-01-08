// ignore_for_file: public_member_api_docs, sort_constructors_first
class TurnoDeTrabalhoEntity {
  final String id;
  final String? turnoRestricao;
  final String codigo;
  final String nome;

  const TurnoDeTrabalhoEntity({
    required this.id,
    this.turnoRestricao,
    required this.codigo,
    required this.nome,
  });

  @override
  bool operator ==(covariant TurnoDeTrabalhoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.turnoRestricao == turnoRestricao && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode {
    return id.hashCode ^ turnoRestricao.hashCode ^ codigo.hashCode ^ nome.hashCode;
  }
}
