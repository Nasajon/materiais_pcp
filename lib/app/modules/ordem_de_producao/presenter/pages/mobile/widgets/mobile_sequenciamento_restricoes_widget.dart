// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/grupo_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/mobile/widgets/mobile_card_grupo_de_restricao_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';

class MobileSequenciamentoRestricoesWidget extends StatelessWidget {
  final GetOperacaoStore getOperacaoStore;
  final SequenciamentoController sequenciamentoController;

  const MobileSequenciamentoRestricoesWidget({
    super.key,
    required this.getOperacaoStore,
    required this.sequenciamentoController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScopedBuilder<GetOperacaoStore, List<OperacaoAggregate>>(
            store: getOperacaoStore,
            onLoading: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            onState: (context, state) {
              final gruposDeRestricoes = <GrupoDeRestricaoEntity>[];

              for (var operacao in state) {
                for (var grupoDeRecurso in operacao.grupoDeRecursos) {
                  for (var recurso in grupoDeRecurso.recursos) {
                    for (var grupoDeRestricao in recurso.grupoDeRestricoes) {
                      final temGrupoAdicionado =
                          gruposDeRestricoes.where((grupo) => grupo.codigo == grupoDeRestricao.codigo).toList().isNotEmpty;

                      if (!temGrupoAdicionado) {
                        gruposDeRestricoes.add(grupoDeRestricao);
                      }
                    }
                  }
                }
              }

              return Column(
                children: [
                  ...gruposDeRestricoes
                      .map(
                        (grupoDeRestricao) => MobileCardGrupoDeRestricoeWidget(
                          grupoDeRestricao: grupoDeRestricao,
                          sequenciamentoController: sequenciamentoController,
                        ),
                      )
                      .toList(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
