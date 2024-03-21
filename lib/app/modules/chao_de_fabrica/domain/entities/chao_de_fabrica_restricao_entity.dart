// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_unidade_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/enums/medicao_tempo_restricao_enum.dart';

class ChaoDeFabricaRestricaoEntity {
  final String id;
  final String atividadeRestricaoId;
  final String codigo;
  final String nome;
  final DateVO inicioPlanejado;
  final DateVO fimPlanejado;
  final DoubleVO usar;
  final DoubleVO capacidade;
  final MedicaoTempoRestricao medicaoTempo;
  final ChaoDeFabricaUnidadeEntity unidade;

  const ChaoDeFabricaRestricaoEntity({
    required this.id,
    required this.atividadeRestricaoId,
    required this.codigo,
    required this.nome,
    required this.inicioPlanejado,
    required this.fimPlanejado,
    required this.usar,
    required this.capacidade,
    required this.medicaoTempo,
    required this.unidade,
  });

  ChaoDeFabricaRestricaoEntity copyWith({
    String? id,
    String? atividadeRestricaoId,
    String? codigo,
    String? nome,
    DateVO? inicioPlanejado,
    DateVO? fimPlanejado,
    DoubleVO? usar,
    DoubleVO? capacidade,
    MedicaoTempoRestricao? medicaoTempo,
    ChaoDeFabricaUnidadeEntity? unidade,
  }) {
    return ChaoDeFabricaRestricaoEntity(
      id: id ?? this.id,
      atividadeRestricaoId: atividadeRestricaoId ?? this.atividadeRestricaoId,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      inicioPlanejado: inicioPlanejado ?? this.inicioPlanejado,
      fimPlanejado: fimPlanejado ?? this.fimPlanejado,
      usar: usar ?? this.usar,
      capacidade: capacidade ?? this.capacidade,
      medicaoTempo: medicaoTempo ?? this.medicaoTempo,
      unidade: unidade ?? this.unidade,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaRestricaoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.atividadeRestricaoId == atividadeRestricaoId &&
        other.codigo == codigo &&
        other.nome == nome &&
        other.inicioPlanejado == inicioPlanejado &&
        other.fimPlanejado == fimPlanejado &&
        other.usar == usar &&
        other.capacidade == capacidade &&
        other.medicaoTempo == medicaoTempo &&
        other.unidade == unidade;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        atividadeRestricaoId.hashCode ^
        codigo.hashCode ^
        nome.hashCode ^
        inicioPlanejado.hashCode ^
        fimPlanejado.hashCode ^
        usar.hashCode ^
        capacidade.hashCode ^
        medicaoTempo.hashCode ^
        unidade.hashCode;
  }
}
