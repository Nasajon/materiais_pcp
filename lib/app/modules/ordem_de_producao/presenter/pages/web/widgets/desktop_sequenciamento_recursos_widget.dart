// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/grupo_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_card_grupo_de_recurso_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';

class DesktopSequenciamentoRecursosWidget extends StatelessWidget {
  final GetOperacaoStore getOperacaoStore;
  final SequenciamentoController sequenciamentoController;

  const DesktopSequenciamentoRecursosWidget({
    super.key,
    required this.getOperacaoStore,
    required this.sequenciamentoController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
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
              final gruposDeRecursos = <GrupoDeRecursoEntity>[];

              for (var operacao in state) {
                for (var grupoDeRecurso in operacao.grupoDeRecursos) {
                  final temGrupoAdicionado = gruposDeRecursos.where((grupo) => grupo.codigo == grupoDeRecurso.codigo).toList().isNotEmpty;

                  if (!temGrupoAdicionado) {
                    gruposDeRecursos.add(grupoDeRecurso);
                  }
                }
              }

              return Column(
                children: [
                  ...gruposDeRecursos
                      .map(
                        (grupoDeRecurso) => DesktopCardGrupoDeRecursoWidget(
                          grupoDeRecurso: grupoDeRecurso,
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
