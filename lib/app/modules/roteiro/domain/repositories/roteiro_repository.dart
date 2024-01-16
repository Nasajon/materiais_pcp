import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/roteiro_entity.dart';

abstract class RoteiroRepository {
  Future<List<RoteiroEntity>> getRoteiroRecente();
  Future<List<RoteiroEntity>> getRoteiro(String search);
  Future<RoteiroAggregate> getRoteiroPorId(String roteiroId);
  Future<String> inserirRoteiro(RoteiroAggregate roteiro);
  Future<bool> editarRoteiro(RoteiroAggregate roteiro);
  Future<bool> deletarRoteiro(String roteiroId);
}
