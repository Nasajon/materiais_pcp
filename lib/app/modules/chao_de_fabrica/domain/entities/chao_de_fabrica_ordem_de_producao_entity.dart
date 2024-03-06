// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';

class ChaoDeFabricaOrdemDeProducaoEntity {
  final String id;
  final String codigo;
  final DoubleVO quantidade;

  const ChaoDeFabricaOrdemDeProducaoEntity({
    required this.id,
    required this.codigo,
    required this.quantidade,
  });

  factory ChaoDeFabricaOrdemDeProducaoEntity.empty() {
    return ChaoDeFabricaOrdemDeProducaoEntity(
      id: '',
      codigo: '',
      quantidade: DoubleVO(null),
    );
  }

  ChaoDeFabricaOrdemDeProducaoEntity copyWith({
    String? id,
    String? codigo,
    DoubleVO? quantidade,
  }) {
    return ChaoDeFabricaOrdemDeProducaoEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      quantidade: quantidade ?? this.quantidade,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaOrdemDeProducaoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.quantidade == quantidade;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ quantidade.hashCode;
}
