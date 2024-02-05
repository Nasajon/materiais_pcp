import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/dto/filters/chao_de_fabrica_atividade_filter.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_continuar_atividade_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_encerrar_atividade_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_iniciar_atividade_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_iniciar_preparacao_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_pausar_atividade_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_atividade_usecase.dart';

class ChaoDeFabricaListStore extends NasajonStreamStore<List<ChaoDeFabricaAtividadeAggregate>> {
  final GetChaoDeFabricaAtividadeUsecase _getChaoDeFabricaAtividadeUsecase;
  final ChaoDeFabricaIniciarPreparacaoUsecase _iniciarPreparacaoUsecase;
  final ChaoDeFabricaIniciarAtividadeUsecase _iniciarAtividadeUsecase;
  final ChaoDeFabricaPausarAtividadeUsecase _pausarAtividadeUsecase;
  final ChaoDeFabricaContinuarAtividadeUsecase _continuarAtividadeUsecase;
  final ChaoDeFabricaEncerrarAtividadeUsecase _encerrarAtividadeUsecase;

  ChaoDeFabricaListStore({
    required GetChaoDeFabricaAtividadeUsecase getChaoDeFabricaAtividadeUsecase,
    required ChaoDeFabricaIniciarPreparacaoUsecase iniciarPreparacaoUsecase,
    required ChaoDeFabricaIniciarAtividadeUsecase iniciarAtividadeUsecase,
    required ChaoDeFabricaPausarAtividadeUsecase pausarAtividadeUsecase,
    required ChaoDeFabricaContinuarAtividadeUsecase continuarAtividadeUsecase,
    required ChaoDeFabricaEncerrarAtividadeUsecase encerrarAtividadeUsecase,
  })  : _getChaoDeFabricaAtividadeUsecase = getChaoDeFabricaAtividadeUsecase,
        _iniciarPreparacaoUsecase = iniciarPreparacaoUsecase,
        _iniciarAtividadeUsecase = iniciarAtividadeUsecase,
        _pausarAtividadeUsecase = pausarAtividadeUsecase,
        _continuarAtividadeUsecase = continuarAtividadeUsecase,
        _encerrarAtividadeUsecase = encerrarAtividadeUsecase,
        super(initialState: []);

  Future<void> getAtividades(
    ChaoDeFabricaAtividadeFilter atividadeFilter, {
    Duration delay = const Duration(milliseconds: 500),
  }) async {
    execute(
      () async {
        final response = await _getChaoDeFabricaAtividadeUsecase(atividadeFilter);
        return response;
      },
      delay: delay,
    );
  }

  Future<ChaoDeFabricaAtividadeAggregate> alterarStatusAtividade({
    required ChaoDeFabricaAtividadeAggregate atividade,
    required AtividadeStatusEnum novoStatus,
  }) async {
    try {
      switch (novoStatus) {
        case AtividadeStatusEnum.emPreparacao:
          atividade = await _iniciarPreparacaoUsecase(atividade);
        case AtividadeStatusEnum.iniciada:
          if (atividade.status == AtividadeStatusEnum.pausada) {
            atividade = await _continuarAtividadeUsecase(atividade);
          } else {
            atividade = await _iniciarAtividadeUsecase(atividade);
          }
        case AtividadeStatusEnum.pausada:
          atividade = await _pausarAtividadeUsecase(atividade);
        case AtividadeStatusEnum.encerrada:
          atividade = await _encerrarAtividadeUsecase(atividade);
        case AtividadeStatusEnum.cancelada:
        case AtividadeStatusEnum.aberta:
      }

      final listAtividades = state;

      final index = listAtividades.indexWhere((element) => element.id == atividade.id);

      listAtividades[index] = atividade;

      update([...listAtividades]);
    } on ChaoDeFabricaFailure catch (e) {}

    return atividade;
  }
}
