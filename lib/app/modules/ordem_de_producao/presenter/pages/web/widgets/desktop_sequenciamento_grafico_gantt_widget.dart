// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_evento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/sequenciamento_objetct_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';

class DesktopSequenciamentoGraficoGantt extends StatelessWidget {
  final SequenciamentoController sequenciamentoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const DesktopSequenciamentoGraficoGantt({
    Key? key,
    required this.sequenciamentoController,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    final [sequenciamento] = context.select(() => [sequenciamentoController.sequenciamento]);

    return CustomScaffold.titleString(
      translation.titles.resultadoSequenciamento,
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      closeIcon: Icon(FontAwesomeIcons.xmark, color: colorTheme?.text),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: NhidsGantt<SequenciamentoObjectEntity, SequenciamentoEventoAggregate>(
          startDate: sequenciamento.tempoInicial.getDate() ?? DateTime.now(),
          endDate: sequenciamento.tempoFinal.getDate() ?? DateTime.now(),
          rowTextString: (recurso) => recurso.nome,
          eventTextString: (evento) => evento.operacaoRoteiro.codigo,
          dateDecoration: DateDecoration(type: DateType.hors),
          eventCallback: (recurso, evento) {},
          eventPopupCardCallback: (evento, closePopup) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorTheme?.background,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(15, 0, 0, 0),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    evento.operacaoRoteiro.nome,
                    style: themeData.textTheme.titleMedium?.copyWith(
                      color: colorTheme?.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    translation.fields.inicioPlanejado,
                    style: themeData.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    evento.inicioPlanejado.dateFormat(format: 'dd/MM/yyyy HH:mm') ?? '',
                    style: themeData.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    translation.fields.fimPlanejado,
                    style: themeData.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    evento.fimPlanejado.dateFormat(format: 'dd/MM/yyyy HH:mm') ?? '',
                    style: themeData.textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          },
          rows: [
            ...sequenciamento.sequenciamentoRecursos
                .map(
                  (sequenciamentoObject) => GanttRow(
                    value: sequenciamentoObject.eventObject,
                    events: sequenciamentoObject.eventos
                        .map(
                          (evento) => GanttEvent(
                            event: evento,
                            eventKey: evento.eventoRecursoId,
                            startDate: evento.inicioPlanejado.getDate() ?? DateTime.now(),
                            endDate: evento.fimPlanejado.getDate() ?? DateTime.now(),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
            ...sequenciamento.sequenciamentoRestricoes
                .map(
                  (sequenciamentoObject) => GanttRow(
                    value: sequenciamentoObject.eventObject,
                    events: sequenciamentoObject.eventos
                        .map(
                          (evento) => GanttEvent<SequenciamentoEventoAggregate>.colorLighter(
                            event: evento,
                            eventKey: evento.eventoRestricaoId ?? '',
                            color: colorTheme?.danger ?? Colors.red,
                            startDate: evento.inicioPlanejado.getDate() ?? DateTime.now(),
                            endDate: evento.fimPlanejado.getDate() ?? DateTime.now(),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
