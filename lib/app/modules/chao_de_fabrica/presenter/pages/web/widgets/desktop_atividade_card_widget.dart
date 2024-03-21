// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_atividade_acoes_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_visualizar_atividade_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_apontamento_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_atividade_by_id_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_finalizar_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';

class DesktopAtividadeCardWidget extends StatelessWidget {
  final ChaoDeFabricaAtividadeAggregate atividade;
  final ChaoDeFabricaListStore chaoDeFabricaListStore;
  final ChaoDeFabricaApontamentoStore apontamentoStore;
  final ChaoDeFabricaFinalizarStore finalizarStore;
  final ChaoDeFabricaAtividadeByIdStore atividadeByIdStore;

  const DesktopAtividadeCardWidget({
    Key? key,
    required this.atividade,
    required this.chaoDeFabricaListStore,
    required this.apontamentoStore,
    required this.finalizarStore,
    required this.atividadeByIdStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<NhidsColorTheme>();

    var horario = atividade.inicioPreparacaoPlanejado.dateFormat(format: 'HH:mm')?.replaceAll(':', 'h') ?? '';
    horario += ' ${translation.fields.as} ';
    horario += atividade.fimPreparacaoPlanejado.dateFormat(format: 'HH:mm')?.replaceAll(':', 'h') ?? '';

    var statusColor = Colors.transparent;

    switch (atividade.status) {
      case AtividadeStatusEnum.aberta:
        statusColor = colorTheme?.secondary ?? Colors.transparent;
      case AtividadeStatusEnum.emPreparacao:
        statusColor = colorTheme?.info ?? Colors.transparent;
      case AtividadeStatusEnum.iniciada:
        statusColor = colorTheme?.info ?? Colors.transparent;
      case AtividadeStatusEnum.encerrada:
        statusColor = colorTheme?.success ?? Colors.transparent;
      case AtividadeStatusEnum.pausada:
        statusColor = colorTheme?.warningText ?? Colors.transparent;
      case AtividadeStatusEnum.cancelada:
        statusColor = colorTheme?.danger ?? Colors.transparent;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            if (true) {
              await Modular.to.pushNamed(NavigationRouter.chaoDeFabricaModule.updatePath(atividade.id));

              if (atividadeByIdStore.state != ChaoDeFabricaAtividadeAggregate.empty()) {
                chaoDeFabricaListStore.atualizarAtividade(atividadeByIdStore.state);
              }
            } else {
              final atividadeNotifier = ValueNotifier(atividade);

              NhidsOverlay.showSideSheet(
                context: context,
                sideSheet: NhidsSideSheet(
                  bodyPadding: const EdgeInsets.all(0),
                  title: ValueListenableBuilder(
                      valueListenable: atividadeNotifier,
                      builder: (_, atividade, __) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NhidsTextTitle(text: '#${atividade.codigo}'),
                            SizedBox(width: 8.responsive),
                            NhidsTagChip(
                              label: atividade.status.name,
                              color: statusColor,
                              type: NhidsTagChipType.outlined,
                            ),
                            SizedBox(width: 8.responsive),
                            NhidsProfileChip(
                              label: atividade.inicioPlanejado.dateFormat() ?? '',
                              iconData: FontAwesomeIcons.calendar,
                              nhidsType: NhidsType.medium,
                            ),
                          ],
                        );
                      }),
                  body: ValueListenableBuilder(
                      valueListenable: atividadeNotifier,
                      builder: (_, atividade, __) {
                        return DesktopVisualizarAtividadeWidget(
                          atividade: atividade,
                          chaoDeFabricaListStore: chaoDeFabricaListStore,
                          apontamentoStore: apontamentoStore,
                          atividadeByIdStore: atividadeByIdStore,
                        );
                      }),
                  actions: [
                    DesktopAtividadeAcoesWidget(
                      atividadeNotifier: atividadeNotifier,
                      chaoDeFabricaListStore: chaoDeFabricaListStore,
                      apontamentoStore: apontamentoStore,
                      finalizarStore: finalizarStore,
                      atividadeByIdStore: atividadeByIdStore,
                    )
                  ],
                ),
              );
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.responsive,
              vertical: 16.responsive,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: colorTheme?.border ?? Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '#${atividade.codigo}',
                          style: themeData.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8.responsive),
                        NhidsTagChip(
                          label: atividade.status.name,
                          color: statusColor,
                          type: NhidsTagChipType.outlined,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.responsive),
                    Text(
                      atividade.operacao.nome,
                      style: themeData.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12.responsive),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NhidsTwoLineText(
                          title: translation.fields.data,
                          titleFontSize: 12,
                          subtitle: atividade.inicioPlanejado.dateFormat() ?? '',
                          type: NhidsTextType.type2,
                        ),
                        SizedBox(width: 20.responsive),
                        NhidsTwoLineText(
                          title: translation.fields.horarioPrevisto,
                          titleFontSize: 12,
                          subtitle: horario,
                          type: NhidsTextType.type2,
                        ),
                        SizedBox(width: 20.responsive),
                        NhidsTwoLineText(
                          title: translation.fields.preparacao,
                          titleFontSize: 12,
                          subtitle: TimeVO.calculateDateDifference(
                            atividade.inicioPreparacaoPlanejado.getDate() ?? DateTime.now(),
                            atividade.fimPreparacaoPlanejado.getDate() ?? DateTime.now(),
                          ),
                          type: NhidsTextType.type2,
                        ),
                        SizedBox(width: 20.responsive),
                        NhidsTwoLine(
                          title: translation.fields.recurso,
                          titleFontSize: 12,
                          child: NhidsTagChip(
                            label: atividade.recurso.nome,
                            type: NhidsTagChipType.outlined,
                          ),
                        ),
                        SizedBox(width: 20.responsive),
                        NhidsTwoLine(
                          title: translation.fields.ordemDeProducao,
                          titleFontSize: 12,
                          child: NhidsTagChip(
                            label: atividade.ordemDeProducao.codigo,
                            type: NhidsTagChipType.outlined,
                          ),
                        ),
                        SizedBox(width: 20.responsive),
                        NhidsTwoLine(
                          title: translation.fields.operacao,
                          titleFontSize: 12,
                          child: NhidsTagChip(
                            label: atividade.operacao.codigo,
                            type: NhidsTagChipType.outlined,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 20.responsive),
                SizedBox(
                  width: 50.responsive,
                  height: 50.responsive,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 50.responsive,
                        height: 50.responsive,
                        child: CircularProgressIndicator(
                          value: atividade.progresso,
                          backgroundColor: colorTheme?.border,
                          color: colorTheme?.info,
                          strokeWidth: 4.responsive,
                        ),
                      ),
                      Center(
                        child: Text(
                          '${DoubleVO(atividade.progresso * 100).formatDoubleToString(decimalDigits: 0)}%',
                          style: themeData.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 12.responsive),
      ],
    );
  }
}
