// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/controllers/chao_de_fabrica_filter_controller.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_selecionar_centro_de_trabalho_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_selecionar_data_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_selecionar_recurso_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_selecionar_situacao_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_visualizar_atividade_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_apontamento_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_atividade_by_id_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_recurso_store.dart';

class DesktopChaoDeFabricaListPage extends StatelessWidget {
  final ChaoDeFabricaListStore chaoDeFabricaListStore;
  final ChaoDeFabricaCentroDeTrabalhoStore centroDeTrabalhoStore;
  final ChaoDeFabricaRecursoStore recursoStore;
  final ChaoDeFabricaApontamentoStore apontamentoStore;
  final ChaoDeFabricaAtividadeByIdStore atividadeByIdStore;
  final ChaoDeFabricaFilterController chaoDeFabricaFilterController;

  const DesktopChaoDeFabricaListPage({
    Key? key,
    required this.chaoDeFabricaListStore,
    required this.centroDeTrabalhoStore,
    required this.recursoStore,
    required this.apontamentoStore,
    required this.atividadeByIdStore,
    required this.chaoDeFabricaFilterController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<NhidsColorTheme>();
    final size = MediaQuery.of(context).size;

    final [atividadeFilter] = context.select(() => [chaoDeFabricaFilterController.atividadeFilter]);

    final dateNow = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd MMM yyyy', locale.languageCode).format(dateNow);
    String formattedTime = DateFormat('HH:mm').format(dateNow);
    String timeZone = dateNow.timeZoneOffset.toString().split('.').first.split(':').first;

    return NhidsScaffold.title(
      title: translation.titles.minhasAtividades,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.appModule.path),
      bottom: PreferredSize(
        preferredSize: Size(size.width, 80),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 19).copyWith(top: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NhidsTwoLineText(
                type: NhidsTextType.type2,
                title: translation.fields.dataEHoraAtual,
                subtitle:
                    '${formattedDate.substring(0, 1).toUpperCase()}${formattedDate.substring(1)} \n$formattedTime (GMT$timeZone - ${translation.fields.brasilia})',
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NhidsTwoLineText(
                    type: NhidsTextType.type2,
                    title: translation.fields.centroDeTrabalho,
                    subtitle: atividadeFilter.centrosDeTrabalhos.map((centroDeTrabalho) => centroDeTrabalho.nome).toList().join(', '),
                  ),
                  NhidsTextSpan(
                    texts: [
                      NhidsSpan(
                        translation.fields.mudarCentroDeTrabalho,
                        fontWeight: FontWeight.w700,
                        onTap: () {
                          Asuka.showDialog(builder: (context) {
                            return Dialog(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: DesktopSelecionarCentroDeTrabalhoWidget(
                                centroDeTrabalhoStore: centroDeTrabalhoStore,
                                chaoDeFabricaFilterController: chaoDeFabricaFilterController,
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 679),
              child: Column(
                children: [
                  NhidsSearchFormField(
                    initialValue: chaoDeFabricaFilterController.atividadeFilter.search,
                    onChanged: (value) {
                      chaoDeFabricaFilterController.atividadeFilter = chaoDeFabricaFilterController.atividadeFilter.copyWith(search: value);
                      chaoDeFabricaListStore.getAtividades(chaoDeFabricaFilterController.atividadeFilter);
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomChip(
                        text: atividadeFilter.recursos.isNotEmpty
                            ? atividadeFilter.recursos.map((recurso) => recurso.nome).toList().join(', ')
                            : translation.fields.recurso,
                        onPressed: () {
                          Asuka.showDialog(builder: (context) {
                            return Dialog(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: DesktopSelecionarRecursoWidget(
                                recursoStore: recursoStore,
                                chaoDeFabricaFilterController: chaoDeFabricaFilterController,
                              ),
                            );
                          });
                        },
                        onClear: atividadeFilter.recursos.isNotEmpty
                            ? () {
                                chaoDeFabricaFilterController.atividadeFilter = atividadeFilter.copyWith(
                                  recursos: [],
                                );
                              }
                            : null,
                      ),
                      const SizedBox(width: 10),
                      CustomChip(
                        text: atividadeFilter.atividadeStatus.isNotEmpty
                            ? atividadeFilter.atividadeStatus.map((status) => status.name).toList().join(', ')
                            : translation.fields.situacao,
                        onPressed: () {
                          Asuka.showDialog(builder: (context) {
                            return Dialog(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: DesktopSelecionarSituacaoWidget(
                                chaoDeFabricaFilterController: chaoDeFabricaFilterController,
                              ),
                            );
                          });
                        },
                        onClear: atividadeFilter.atividadeStatus.isNotEmpty
                            ? () {
                                chaoDeFabricaFilterController.atividadeFilter = atividadeFilter.copyWith(
                                  atividadeStatus: [],
                                );
                              }
                            : null,
                      ),
                      const SizedBox(width: 10),
                      CustomChip(
                        text: atividadeFilter.dataInicial.isNotEmpty && atividadeFilter.dataFinal.isNotEmpty
                            ? '${atividadeFilter.dataInicial.dateFormat()} - ${atividadeFilter.dataFinal.dateFormat()}'
                            : translation.fields.data,
                        onPressed: () {
                          Asuka.showDialog(builder: (context) {
                            return Dialog(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: DesktopSelecionarDataWidget(
                                chaoDeFabricaFilterController: chaoDeFabricaFilterController,
                              ),
                            );
                          });
                        },
                        onClear: atividadeFilter.dataInicial.isNotEmpty && atividadeFilter.dataFinal.isNotEmpty
                            ? () {
                                chaoDeFabricaFilterController.atividadeFilter = atividadeFilter.copyWith(
                                  dataInicial: DateVO(''),
                                  dataFinal: DateVO(''),
                                );
                              }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ScopedBuilder<ChaoDeFabricaListStore, List<ChaoDeFabricaAtividadeAggregate>>(
              store: chaoDeFabricaListStore,
              onLoading: (context) => const Center(child: CircularProgressIndicator()),
              onState: (context, atividades) {
                return Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 720, minHeight: 330),
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: atividades.map((atividade) {
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
                                onTap: () {
                                  Asuka.showDialog(builder: (_) {
                                    return Dialog(
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                                      child: DesktopVisualizarAtividadeWidget(
                                        atividade: atividade,
                                        chaoDeFabricaListStore: chaoDeFabricaListStore,
                                        apontamentoStore: apontamentoStore,
                                        atividadeByIdStore: atividadeByIdStore,
                                      ),
                                    );
                                  });
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
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
                                              const SizedBox(width: 8),
                                              NhidsTagChip(
                                                label: atividade.status.name,
                                                color: statusColor,
                                                type: NhidsTagChipType.outlined,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            atividade.operacao.nome,
                                            style: themeData.textTheme.titleSmall?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              NhidsTwoLineText(
                                                title: translation.fields.data,
                                                titleFontSize: 12,
                                                subtitle: atividade.inicioPlanejado.dateFormat() ?? '',
                                                type: NhidsTextType.type2,
                                              ),
                                              const SizedBox(width: 20),
                                              NhidsTwoLineText(
                                                title: translation.fields.horarioPrevisto,
                                                titleFontSize: 12,
                                                subtitle: horario,
                                                type: NhidsTextType.type2,
                                              ),
                                              const SizedBox(width: 20),
                                              NhidsTwoLineText(
                                                title: translation.fields.preparacao,
                                                titleFontSize: 12,
                                                subtitle: TimeVO.calculateDateDifference(
                                                  atividade.inicioPreparacaoPlanejado.getDate() ?? DateTime.now(),
                                                  atividade.fimPreparacaoPlanejado.getDate() ?? DateTime.now(),
                                                ),
                                                type: NhidsTextType.type2,
                                              ),
                                              const SizedBox(width: 20),
                                              NhidsTwoLine(
                                                title: translation.fields.recurso,
                                                titleFontSize: 12,
                                                child: NhidsTagChip(
                                                  label: atividade.recurso.nome,
                                                  type: NhidsTagChipType.outlined,
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              NhidsTwoLine(
                                                title: translation.fields.ordemDeProducao,
                                                titleFontSize: 12,
                                                child: NhidsTagChip(
                                                  label: atividade.ordemDeProducao.codigo,
                                                  type: NhidsTagChipType.outlined,
                                                ),
                                              ),
                                              const SizedBox(width: 20),
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
                                      const SizedBox(width: 20),
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: CircularProgressIndicator(
                                                value: atividade.progresso,
                                                backgroundColor: colorTheme?.border,
                                                color: colorTheme?.info,
                                                strokeWidth: 4,
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
                              const SizedBox(height: 12),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
