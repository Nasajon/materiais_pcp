import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/dto/filters/chao_de_fabrica_atividade_filter.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_continuar_atividade_usecase.dart';
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

  ChaoDeFabricaListStore({
    required GetChaoDeFabricaAtividadeUsecase getChaoDeFabricaAtividadeUsecase,
    required ChaoDeFabricaIniciarPreparacaoUsecase iniciarPreparacaoUsecase,
    required ChaoDeFabricaIniciarAtividadeUsecase iniciarAtividadeUsecase,
    required ChaoDeFabricaPausarAtividadeUsecase pausarAtividadeUsecase,
    required ChaoDeFabricaContinuarAtividadeUsecase continuarAtividadeUsecase,
  })  : _getChaoDeFabricaAtividadeUsecase = getChaoDeFabricaAtividadeUsecase,
        _iniciarPreparacaoUsecase = iniciarPreparacaoUsecase,
        _iniciarAtividadeUsecase = iniciarAtividadeUsecase,
        _pausarAtividadeUsecase = pausarAtividadeUsecase,
        _continuarAtividadeUsecase = continuarAtividadeUsecase,
        super(initialState: []);

  Future<void> getAtividades(
    ChaoDeFabricaAtividadeFilter atividadeFilter, {
    Duration delay = const Duration(milliseconds: 500),
  }) async {
    execute(
      () async {
        try {
          final response = await _getChaoDeFabricaAtividadeUsecase(atividadeFilter);
          return response;
        } on ChaoDeFabricaFailure catch (e) {
          NhidsOverlay.error(message: e.errorMessage ?? '');
          return [];
        }
      },
      delay: delay,
    );
  }

  Future<void> getProximaPaginaAtividade(ChaoDeFabricaAtividadeFilter atividadeFilter) async {
    final atividade = state.last;

    final response = await _getChaoDeFabricaAtividadeUsecase(atividadeFilter.copyWith(ultimaAtividadeId: atividade.id));

    update(List.from([...state, ...response]));
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
        case AtividadeStatusEnum.cancelada:
        case AtividadeStatusEnum.aberta:
      }

      final listAtividades = state;

      final index = listAtividades.indexWhere((element) => element.id == atividade.id);

      listAtividades[index] = atividade;

      update([...listAtividades]);
    } on ChaoDeFabricaFailure catch (e) {
      NhidsOverlay.error(message: e.errorMessage ?? '');
    }

    return atividade;
  }

  void atualizarAtividade(ChaoDeFabricaAtividadeAggregate atividade) {
    final listAtividades = state;

    final index = listAtividades.indexWhere((element) => element.id == atividade.id);

    listAtividades[index] = atividade;

    update([...listAtividades]);
  }
}
