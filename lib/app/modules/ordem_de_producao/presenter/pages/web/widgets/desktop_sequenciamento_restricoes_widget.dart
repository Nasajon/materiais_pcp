// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/grupo_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_card_grupo_de_restricao_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';

class DesktopSequenciamentoRestricoesWidget extends StatelessWidget {
  final GetOperacaoStore getOperacaoStore;
  final SequenciamentoController sequenciamentoController;

  const DesktopSequenciamentoRestricoesWidget({
    super.key,
    required this.getOperacaoStore,
    required this.sequenciamentoController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: RxBuilder(
        builder: (_) {
          final gruposDeRestricoes = <GrupoDeRestricaoEntity>[];

          for (var operacao in sequenciamentoController.listOperacoes) {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...gruposDeRestricoes
                  .map(
                    (grupoDeRestricao) => DesktopCardGrupoDeRestricoeWidget(
                      grupoDeRestricao: grupoDeRestricao,
                      sequenciamentoController: sequenciamentoController,
                    ),
                  )
                  .toList(),
            ],
          );
        },
      ),
    );
  }
}
