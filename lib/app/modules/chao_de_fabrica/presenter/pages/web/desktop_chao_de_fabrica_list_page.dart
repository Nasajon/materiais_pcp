import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/core/widgets/table/pcp_table.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/controllers/chao_de_fabrica_filter_controller.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_selecionar_centro_de_trabalho_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_selecionar_data_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_selecionar_recurso_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_selecionar_situacao_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_visualizar_atividade_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_recurso_store.dart';

class DesktopChaoDeFabricaListPage extends StatelessWidget {
  final ChaoDeFabricaListStore chaoDeFabricaListStore;
  final ChaoDeFabricaCentroDeTrabalhoStore centroDeTrabalhoStore;
  final ChaoDeFabricaRecursoStore recursoStore;
  final ChaoDeFabricaFilterController chaoDeFabricaFilterController;

  const DesktopChaoDeFabricaListPage({
    Key? key,
    required this.chaoDeFabricaListStore,
    required this.centroDeTrabalhoStore,
    required this.recursoStore,
    required this.chaoDeFabricaFilterController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return CustomScaffold.titleString(
      translation.titles.minhasAtividades,
      controller: CustomScaffoldController(),
      alignment: Alignment.centerLeft,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.appModule.path),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          RxBuilder(builder: (context) {
            final atividadeFilter = chaoDeFabricaFilterController.atividadeFilter;
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 679),
                child: Column(
                  children: [
                    PesquisaFormFieldWidget(
                      label: translation.messages.pesquisarNomeOuPalavraChave,
                      initialValue: chaoDeFabricaFilterController.atividadeFilter.search,
                      onChanged: (value) {
                        chaoDeFabricaFilterController.atividadeFilter =
                            chaoDeFabricaFilterController.atividadeFilter.copyWith(search: value);
                        chaoDeFabricaListStore.getAtividades(chaoDeFabricaFilterController.atividadeFilter);
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomChip(
                          text: atividadeFilter.centrosDeTrabalhos.isNotEmpty
                              ? atividadeFilter.centrosDeTrabalhos.map((centroDeTrabalho) => centroDeTrabalho.nome).toList().join(', ')
                              : translation.fields.centroDeTrabalho,
                          onPressed: () {
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
                          onClear: atividadeFilter.centrosDeTrabalhos.isNotEmpty
                              ? () {
                                  chaoDeFabricaFilterController.atividadeFilter = atividadeFilter.copyWith(
                                    centrosDeTrabalhos: [],
                                  );
                                }
                              : null,
                        ),
                        const SizedBox(width: 10),
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
            );
          }),
          const SizedBox(height: 16),
          ScopedBuilder<ChaoDeFabricaListStore, List<ChaoDeFabricaAtividadeAggregate>>(
            store: chaoDeFabricaListStore,
            onLoading: (context) => const Center(child: CircularProgressIndicator()),
            onState: (context, atividades) {
              return Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 987, minHeight: 330),
                  child: PCPTable(
                    type: TypeTable.modelo2,
                    columns: [
                      DataColumn(
                        label: TextDataColumn(text: translation.fields.codigo),
                      ),
                      DataColumn(
                        label: TextDataColumn(text: translation.fields.data),
                      ),
                      DataColumn(
                        label: TextDataColumn(text: translation.fields.horarioPrevisto),
                      ),
                      DataColumn(
                        label: TextDataColumn(text: translation.fields.preparacao),
                      ),
                      DataColumn(
                        label: TextDataColumn(text: translation.fields.ordemDeProducao),
                      ),
                      DataColumn(
                        label: TextDataColumn(text: translation.fields.recurso),
                      ),
                      DataColumn(
                        label: TextDataColumn(text: translation.fields.situacao),
                      ),
                      DataColumn(
                        label: TextDataColumn(text: translation.fields.progresso, width: 120),
                      ),
                      const DataColumn(
                        label: TextDataColumn(text: ''),
                      ),
                    ],
                    rows: atividades.map(
                      (atividade) {
                        var horario = atividade.inicioPreparacaoPlanejado.dateFormat(format: 'HH:mm')?.replaceAll(':', 'h') ?? '';
                        horario += ' - ';
                        horario += atividade.fimPreparacaoPlanejado.dateFormat(format: 'HH:mm')?.replaceAll(':', 'h') ?? '';
                        return DataRow(
                          cells: [
                            DataCell(TextRow(text: atividade.operacao.codigo)),
                            DataCell(TextRow(text: atividade.fimPreparacaoPlanejado.dateFormat() ?? '')),
                            DataCell(TextRow(text: horario)),
                            DataCell(
                              TextRow(
                                text: TimeVO.calculateDateDifference(
                                  atividade.inicioPreparacaoPlanejado.getDate() ?? DateTime.now(),
                                  atividade.fimPreparacaoPlanejado.getDate() ?? DateTime.now(),
                                ),
                              ),
                            ),
                            DataCell(
                              CustomChip(
                                text: atividade.ordemDeProducao.codigo,
                                height: 22,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                backgroundColor: colorTheme?.background,
                                borderColor: colorTheme?.text,
                                textStyle: themeData.textTheme.labelMedium?.copyWith(
                                  color: colorTheme?.text,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            DataCell(
                              CustomChip(
                                text: atividade.recurso.nome,
                                height: 22,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                backgroundColor: colorTheme?.background,
                                borderColor: colorTheme?.text,
                                textStyle: themeData.textTheme.labelMedium?.copyWith(
                                  color: colorTheme?.text,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            DataCell(
                              CustomChip(
                                text: atividade.status.name,
                                height: 22,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                backgroundColor: colorTheme?.background,
                                borderColor: colorTheme?.text,
                                textStyle: themeData.textTheme.labelMedium?.copyWith(
                                  color: colorTheme?.text,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                height: 18,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: colorTheme?.text ?? Colors.transparent),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: LinearProgressIndicator(
                                          value: atividade.progresso,
                                          minHeight: 18,
                                          backgroundColor: colorTheme?.background,
                                          borderRadius: atividade.progresso >= 1
                                              ? BorderRadius.circular(12)
                                              : const BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  bottomLeft: Radius.circular(12),
                                                ),
                                          color: colorTheme?.info,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${DoubleVO(atividade.progresso * 100).formatDoubleToString(decimalDigits: 0)}%',
                                        style: themeData.textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DataCell(
                              PopupMenuButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: colorTheme?.icons,
                                ),
                                padding: const EdgeInsets.all(0),
                                itemBuilder: (_) {
                                  return [
                                    PopupMenuItem<String>(
                                      value: translation.fields.visualizar,
                                      child: Text(translation.fields.visualizar),
                                      onTap: () async {
                                        Asuka.showDialog(builder: (_) {
                                          return Dialog(
                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                                            child: DesktopVisualizarAtividadeWidget(
                                              atividade: atividade,
                                              chaoDeFabricaListStore: chaoDeFabricaListStore,
                                            ),
                                          );
                                        });
                                      },
                                    ),
                                  ];
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
