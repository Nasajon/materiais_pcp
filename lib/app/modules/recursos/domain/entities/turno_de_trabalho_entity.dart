// ignore_for_file: public_member_api_docs, sort_constructors_first
class TurnoDeTrabalhoEntity {
  final String id;
  final String? turnoRecurso;
  final String codigo;
  final String nome;

  const TurnoDeTrabalhoEntity({
    required this.id,
    required this.turnoRecurso,
    required this.codigo,
    required this.nome,
  });

  @override
  bool operator ==(covariant TurnoDeTrabalhoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.turnoRecurso == turnoRecurso && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode {
    return id.hashCode ^ turnoRecurso.hashCode ^ codigo.hashCode ^ nome.hashCode;
  }
}
