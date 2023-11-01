import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/cliente_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/enums/origem_ordem_enum.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/enums/prioridade_enum.dart';

class OrdemDeProducaoAggregate {
  final String id;
  final CodigoVO codigo;
  final ProdutoEntity produto;
  final RoteiroEntity roteiro;
  final ClienteEntity? cliente;
  final DoubleVO quantidade;
  final DateVO previsaoDeEntrega;
  final PrioridadeEnum prioridade;
  final OrigemOrdemEnum origem;

  const OrdemDeProducaoAggregate({
    required this.id,
    required this.codigo,
    required this.produto,
    required this.roteiro,
    this.cliente,
    required this.quantidade,
    required this.previsaoDeEntrega,
    this.prioridade = PrioridadeEnum.baixa,
    this.origem = OrigemOrdemEnum.pcp,
  });

  factory OrdemDeProducaoAggregate.empty() {
    return OrdemDeProducaoAggregate(
      id: '',
      codigo: CodigoVO(null),
      produto: ProdutoEntity.empty(),
      roteiro: RoteiroEntity.empty(),
      quantidade: DoubleVO(null),
      previsaoDeEntrega: DateVO(''),
    );
  }

  OrdemDeProducaoAggregate copyWith({
    String? id,
    CodigoVO? codigo,
    ProdutoEntity? produto,
    RoteiroEntity? roteiro,
    ClienteEntity? cliente,
    DoubleVO? quantidade,
    DateVO? previsaoDeEntrega,
    PrioridadeEnum? prioridade,
    OrigemOrdemEnum? origem,
  }) {
    return OrdemDeProducaoAggregate(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      produto: produto ?? this.produto,
      roteiro: roteiro ?? this.roteiro,
      cliente: cliente ?? this.cliente,
      quantidade: quantidade ?? this.quantidade,
      previsaoDeEntrega: previsaoDeEntrega ?? this.previsaoDeEntrega,
      prioridade: prioridade ?? this.prioridade,
      origem: origem ?? this.origem,
    );
  }

  @override
  bool operator ==(covariant OrdemDeProducaoAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.codigo == codigo &&
        other.produto == produto &&
        other.roteiro == roteiro &&
        other.cliente == cliente &&
        other.quantidade == quantidade &&
        other.previsaoDeEntrega == previsaoDeEntrega &&
        other.prioridade == prioridade &&
        other.origem == origem;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        codigo.hashCode ^
        produto.hashCode ^
        roteiro.hashCode ^
        cliente.hashCode ^
        quantidade.hashCode ^
        previsaoDeEntrega.hashCode ^
        prioridade.hashCode ^
        origem.hashCode;
  }

  bool get isValid =>
      codigo.isValid &&
      produto != ProdutoEntity.empty() &&
      roteiro != RoteiroEntity.empty() &&
      quantidade.isValid &&
      previsaoDeEntrega.isValid;
}
