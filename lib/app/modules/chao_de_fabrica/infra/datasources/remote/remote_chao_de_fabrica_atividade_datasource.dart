import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/dto/filters/chao_de_fabrica_atividade_filter.dart';

abstract interface class RemoteChaoDeFabricaAtividadeDatasource {
  Future<List<ChaoDeFabricaAtividadeAggregate>> getAtividades(ChaoDeFabricaAtividadeFilter filter);

  Future<ChaoDeFabricaAtividadeAggregate> iniciarPreparacao(ChaoDeFabricaAtividadeAggregate atividade);

  Future<ChaoDeFabricaAtividadeAggregate> iniciarAtividade(ChaoDeFabricaAtividadeAggregate atividade);

  Future<ChaoDeFabricaAtividadeAggregate> pausarAtividade(ChaoDeFabricaAtividadeAggregate atividade);

  Future<ChaoDeFabricaAtividadeAggregate> continuarAtividade(ChaoDeFabricaAtividadeAggregate atividade);

  Future<ChaoDeFabricaAtividadeAggregate> encerrarAtividade(ChaoDeFabricaAtividadeAggregate atividade);
}
