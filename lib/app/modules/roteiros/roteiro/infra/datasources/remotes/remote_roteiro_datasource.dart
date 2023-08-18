import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/roteiro_entity.dart';

abstract class RemoteRoteiroDatasource {
  Future<List<RoteiroEntity>> getRoteiroRecente();
  Future<List<RoteiroEntity>> getRoteiro(String search);
  Future<RoteiroAggregate> getRoteiroPeloId(String roteiroId);
  Future<String> inserirRoteiro(RoteiroAggregate roteiro);
  Future<bool> editarRoteiro(RoteiroAggregate roteiro);
  Future<bool> deletarRoteiro(String roteiroId);
}
