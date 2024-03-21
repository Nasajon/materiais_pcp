// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_material_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_unidade_entity.dart';

class ChaoDeFabricaFinalizarEntity {
  final String id;
  final DoubleVO quantidade;
  final ChaoDeFabricaUnidadeEntity unidade;
  final DateVO data;
  final TimeVO horario;
  final List<ChaoDeFabricaMaterialEntity> materiais;

  const ChaoDeFabricaFinalizarEntity({
    required this.id,
    required this.quantidade,
    required this.unidade,
    required this.data,
    required this.horario,
    required this.materiais,
  });

  ChaoDeFabricaFinalizarEntity copyWith({
    String? id,
    DoubleVO? quantidade,
    DoubleVO? progresso,
    ChaoDeFabricaUnidadeEntity? unidade,
    DateVO? data,
    TimeVO? horario,
    List<ChaoDeFabricaMaterialEntity>? materiais,
  }) {
    return ChaoDeFabricaFinalizarEntity(
      id: id ?? this.id,
      quantidade: quantidade ?? this.quantidade,
      unidade: unidade ?? this.unidade,
      data: data ?? this.data,
      horario: horario ?? this.horario,
      materiais: materiais ?? this.materiais,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaFinalizarEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.quantidade == quantidade &&
        other.unidade == unidade &&
        other.data == data &&
        other.horario == horario &&
        listEquals(other.materiais, materiais);
  }

  @override
  int get hashCode {
    return id.hashCode ^ quantidade.hashCode ^ unidade.hashCode ^ data.hashCode ^ horario.hashCode ^ materiais.hashCode;
  }
}
