// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_recurso_evento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/recurso_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/gerar_sequenciamento_store.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/recurso.dart';

class DesktopSequenciamentoPage extends StatelessWidget {
  final GerarSequenciamentoStore gerarSequenciamentoStore;
  final SequenciamentoController sequenciamentoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const DesktopSequenciamentoPage({
    Key? key,
    required this.gerarSequenciamentoStore,
    required this.sequenciamentoController,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final [sequenciamento] = context.select(() => [sequenciamentoController.sequenciamento]);

    return CustomScaffold.titleString(
      translation.titles.resultadoSequenciamento,
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: NhidsGantt<RecursoEntity, SequenciamentoRecursoEventoAggregate>(
          startDate: sequenciamento.tempoInicial.getDate() ?? DateTime.now(),
          endDate: sequenciamento.tempoFinal.getDate() ?? DateTime.now(),
          rowTextString: (recurso) => recurso.nome,
          eventTextString: (evento) => evento.operacaoRoteiro.codigo,
          dateDecoration: DateDecoration(type: DateType.hors),
          eventCallback: (recurso, evento) {},
          rows: sequenciamento.sequenciamentoRecursos
              .map(
                (sequenciamentoRecurso) => GanttRow(
                  value: sequenciamentoRecurso.recurso,
                  events: sequenciamentoRecurso.eventos
                      .map(
                        (evento) => GanttEvent(
                          event: evento,
                          eventKey: evento.id,
                          startDate: evento.inicioPlanejado.getDate() ?? DateTime.now(),
                          endDate: evento.fimPlanejado.getDate() ?? DateTime.now(),
                        ),
                      )
                      .toList(),
                ),
              )
              .toList(),
        ),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTextButton(
              title: translation.fields.cancelar,
              isEnabled: true,
              onPressed: () {
                gerarSequenciamentoStore.update(SequenciamentoAggregate.empty());
                sequenciamentoController.sequenciamento = SequenciamentoAggregate.empty();
              },
            ),
            const SizedBox(width: 10),
            CustomPrimaryButton(
              title: translation.fields.confirmarSequenciamento,
              isEnabled: true,
              isLoading: false,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
