// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/core/widgets/table/pcp_table.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_apontamento_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_atividade_by_id_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';

class DesktopVisualizarAtividadeWidget extends StatefulWidget {
  final ChaoDeFabricaAtividadeAggregate atividade;
  final ChaoDeFabricaListStore chaoDeFabricaListStore;
  final ChaoDeFabricaApontamentoStore apontamentoStore;
  final ChaoDeFabricaAtividadeByIdStore atividadeByIdStore;

  const DesktopVisualizarAtividadeWidget({
    Key? key,
    required this.atividade,
    required this.chaoDeFabricaListStore,
    required this.apontamentoStore,
    required this.atividadeByIdStore,
  }) : super(key: key);

  @override
  State<DesktopVisualizarAtividadeWidget> createState() => _DesktopVisualizarAtividadeWidgetState();
}

class _DesktopVisualizarAtividadeWidgetState extends State<DesktopVisualizarAtividadeWidget> {
  ChaoDeFabricaListStore get chaoDeFabricaListStore => widget.chaoDeFabricaListStore;
  ChaoDeFabricaApontamentoStore get apontamentoStore => widget.apontamentoStore;
  ChaoDeFabricaAtividadeByIdStore get atividadeByIdStore => widget.atividadeByIdStore;

  late final RxNotifier<ChaoDeFabricaAtividadeAggregate> atividadeNotifier;

  late final Disposer atividadeByIdStoreDisposer;

  @override
  void initState() {
    super.initState();

    atividadeNotifier = RxNotifier(widget.atividade);

    atividadeByIdStoreDisposer = atividadeByIdStore.observer(
      onState: (state) {
        atividadeNotifier.value = state;
        chaoDeFabricaListStore.atualizarAtividade(state);
      },
    );
  }

  @override
  void dispose() {
    atividadeByIdStoreDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<NhidsColorTheme>();

    return RxBuilder(
      builder: (_) {
        final atividade = atividadeNotifier.value;

        var horario = atividade.inicioPreparacaoPlanejado.dateFormat(format: 'HH:mm')?.replaceAll(':', 'h') ?? '';
        horario += ' - ';
        horario += atividade.fimPreparacaoPlanejado.dateFormat(format: 'HH:mm')?.replaceAll(':', 'h') ?? '';

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 12.responsive,
            vertical: 12.responsive,
          ).copyWith(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: NhidsTwoLine(
                      title: translation.fields.ordemDeProducao,
                      child: NhidsTagChip(
                        label: atividade.ordemDeProducao.codigo,
                        type: NhidsTagChipType.outlined,
                        color: colorTheme?.primary,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.responsive),
                  Expanded(
                    child: NhidsTwoLine(
                      title: translation.fields.recurso,
                      child: NhidsTagChip(
                        label: atividade.recurso.nome,
                        type: NhidsTagChipType.outlined,
                        color: colorTheme?.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.responsive),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: NhidsTwoLine(
                      title: translation.fields.operacao,
                      child: NhidsTagChip(
                        label: atividade.operacao.nome,
                        type: NhidsTagChipType.outlined,
                        color: colorTheme?.primary,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.responsive),
                  Expanded(
                    child: NhidsTwoLineText(
                      title: translation.fields.horarioPrevisto,
                      subtitle: horario,
                      type: NhidsTextType.type2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.responsive),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: NhidsTwoLineText(
                      title: translation.fields.preparacao,
                      subtitle: TimeVO.calculateDateDifference(
                        atividade.inicioPreparacaoPlanejado.getDate() ?? DateTime.now(),
                        atividade.fimPreparacaoPlanejado.getDate() ?? DateTime.now(),
                      ),
                      type: NhidsTextType.type2,
                    ),
                  ),
                  SizedBox(width: 16.responsive),
                  Expanded(
                    child: NhidsTwoLineText(
                      title: translation.fields.produtoResultante,
                      subtitle: 'ddfs',
                      type: NhidsTextType.type2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.responsive),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: NhidsTwoLineText(
                      title: translation.fields.quantidade,
                      subtitle:
                          '${atividade.quantidade.formatDoubleToString(decimalDigits: atividade.unidade.decimal)} ${atividade.unidade.nome}',
                      type: NhidsTextType.type2,
                    ),
                  ),
                  SizedBox(width: 16.responsive),
                  Expanded(
                    child: NhidsTwoLineText(
                      title: translation.fields.produzido,
                      subtitle:
                          '${atividade.produzida.formatDoubleToString(decimalDigits: atividade.unidade.decimal)} ${atividade.unidade.nome}',
                      type: NhidsTextType.type2,
                    ),
                  ),
                ],
              ),
              if (atividade.status != AtividadeStatusEnum.aberta && atividade.status != AtividadeStatusEnum.emPreparacao) ...[
                SizedBox(height: 16.responsive),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          NhidsTwoLine(
                            title: translation.fields.progresso,
                            child: NhidsLinearProgressIndicator(
                              value: atividade.progresso,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.responsive),
                    const Expanded(
                      child: SizedBox.shrink(),
                    ),
                  ],
                ),
              ],
              if (atividade.restricoes.isNotEmpty) ...[
                ExpansionTile(
                  title: Text(
                    translation.fields.restricoes,
                    style: themeData.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  collapsedTextColor: colorTheme?.text,
                  textColor: colorTheme?.text,
                  iconColor: colorTheme?.text,
                  collapsedIconColor: colorTheme?.text,
                  backgroundColor: colorTheme?.background,
                  tilePadding: const EdgeInsets.all(0),
                  shape: Border.all(color: colorTheme?.background ?? Colors.transparent),
                  children: [
                    SizedBox(height: 12.responsive),
                    PCPTable(
                      type: TypeTable.modelo3,
                      columns: [
                        DataColumn(
                          label: TextDataColumn(
                            text: translation.fields.restricao,
                            style: themeData.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: TextDataColumn(
                            text: translation.fields.quando,
                            style: themeData.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                      rows: atividade.restricoes.map((restricao) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(restricao.nome),
                            ),
                            DataCell(
                              Text(
                                TimeVO.calculateDateDifference(
                                  restricao.inicioPlanejado.getDate() ?? DateTime.now(),
                                  restricao.fimPlanejado.getDate() ?? DateTime.now(),
                                ),
                              ),
                            )
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
              ExpansionTile(
                title: Text(
                  translation.fields.materiais,
                  style: themeData.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                collapsedTextColor: colorTheme?.text,
                textColor: colorTheme?.text,
                iconColor: colorTheme?.text,
                collapsedIconColor: colorTheme?.text,
                backgroundColor: colorTheme?.background,
                tilePadding: const EdgeInsets.all(0),
                shape: Border.all(color: colorTheme?.background ?? Colors.transparent),
                children: [
                  SizedBox(height: 12.responsive),
                  PCPTable(
                    type: TypeTable.modelo3,
                    columns: [
                      DataColumn(
                        label: TextDataColumn(
                          text: translation.fields.materiais,
                          style: themeData.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: TextDataColumn(
                          text: translation.fields.quantidade,
                          style: themeData.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                    rows: atividade.materiais.map((material) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(material.produto.nome),
                          ),
                          DataCell(
                            Text(
                                '${material.quantidade.formatDoubleToString(decimalDigits: material.unidade.decimal)} ${material.unidade.nome}'),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
