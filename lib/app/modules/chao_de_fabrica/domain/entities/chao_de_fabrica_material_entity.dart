// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_produto_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_unidade_entity.dart';

class ChaoDeFabricaMaterialEntity {
  final String id;
  final String atividadeRecursoId;
  final ChaoDeFabricaProdutoEntity produto;
  final ChaoDeFabricaUnidadeEntity unidade;
  final DoubleVO quantidade;
  final DoubleVO quantidadeUtilizada;
  final DoubleVO quantidadePerda;
  final DoubleVO quantidadeSobra;

  const ChaoDeFabricaMaterialEntity({
    required this.id,
    required this.atividadeRecursoId,
    required this.produto,
    required this.unidade,
    required this.quantidade,
    required this.quantidadeUtilizada,
    required this.quantidadePerda,
    required this.quantidadeSobra,
  });

  ChaoDeFabricaMaterialEntity copyWith({
    String? id,
    String? atividadeRecursoId,
    ChaoDeFabricaProdutoEntity? produto,
    ChaoDeFabricaUnidadeEntity? unidade,
    DoubleVO? quantidade,
    DoubleVO? quantidadeUtilizada,
    DoubleVO? quantidadePerda,
    DoubleVO? quantidadeSobra,
  }) {
    return ChaoDeFabricaMaterialEntity(
      id: id ?? this.id,
      atividadeRecursoId: atividadeRecursoId ?? this.atividadeRecursoId,
      produto: produto ?? this.produto,
      unidade: unidade ?? this.unidade,
      quantidade: quantidade ?? this.quantidade,
      quantidadeUtilizada: quantidadeUtilizada ?? this.quantidadeUtilizada,
      quantidadePerda: quantidadePerda ?? this.quantidadePerda,
      quantidadeSobra: quantidadeSobra ?? this.quantidadeSobra,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaMaterialEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.atividadeRecursoId == atividadeRecursoId &&
        other.produto == produto &&
        other.unidade == unidade &&
        other.quantidade == quantidade &&
        other.quantidadeUtilizada == quantidadeUtilizada &&
        other.quantidadePerda == quantidadePerda &&
        other.quantidadeSobra == quantidadeSobra;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        atividadeRecursoId.hashCode ^
        produto.hashCode ^
        unidade.hashCode ^
        quantidade.hashCode ^
        quantidadeUtilizada.hashCode ^
        quantidadePerda.hashCode ^
        quantidadeSobra.hashCode;
  }
}
