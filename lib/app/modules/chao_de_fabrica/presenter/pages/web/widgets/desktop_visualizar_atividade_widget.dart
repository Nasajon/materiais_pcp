// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_atividade_acoes_widget.dart';
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

    return RxBuilder(builder: (_) {
      final atividade = atividadeNotifier.value;

      var horario = atividade.inicioPreparacaoPlanejado.dateFormat(format: 'HH:mm')?.replaceAll(':', 'h') ?? '';
      horario += ' - ';
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

      return Container(
        constraints: const BoxConstraints(minWidth: 769, maxWidth: 769),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorTheme?.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  atividade.operacao.nome,
                  style: themeData.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 12),
                NhidsTagChip(
                  label: atividade.status.name,
                  color: statusColor,
                  type: NhidsTagChipType.outlined,
                )
              ],
            ),
            const SizedBox(height: 24),
            Visibility(
              visible: atividade.status != AtividadeStatusEnum.aberta && atividade.status != AtividadeStatusEnum.emPreparacao,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      translation.fields.recurso,
                      style: themeData.textTheme.labelLarge,
                    ),
                    const SizedBox(height: 4),
                    NhidsTagChip(
                      label: atividade.recurso.nome,
                      type: NhidsTagChipType.outlined,
                    ),
                  ],
                ),
                const SizedBox(width: 28),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      translation.fields.ordemDeProducao,
                      style: themeData.textTheme.labelLarge,
                    ),
                    const SizedBox(height: 4),
                    NhidsTagChip(
                      label: atividade.ordemDeProducao.codigo,
                      type: NhidsTagChipType.outlined,
                    ),
                  ],
                ),
                const SizedBox(width: 28),
                NhidsTwoLineText(
                  title: translation.fields.data,
                  subtitle: atividade.inicioPreparacaoPlanejado.dateFormat() ?? '',
                  type: NhidsTextType.type2,
                  reverse: true,
                ),
                const SizedBox(width: 28),
                NhidsTwoLineText(
                  title: translation.fields.horarioPrevisto,
                  subtitle: horario,
                  type: NhidsTextType.type2,
                  reverse: true,
                ),
                const SizedBox(width: 28),
                NhidsTwoLineText(
                  title: translation.fields.preparacao,
                  subtitle: TimeVO.calculateDateDifference(
                    atividade.inicioPreparacaoPlanejado.getDate() ?? DateTime.now(),
                    atividade.fimPreparacaoPlanejado.getDate() ?? DateTime.now(),
                  ),
                  type: NhidsTextType.type2,
                  reverse: true,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: atividade.restricoes.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translation.fields.restricoes,
                    style: themeData.textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: atividade.restricoes.map((restricao) {
                      return Container(
                        width: 171,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: colorTheme?.border ?? Colors.transparent,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restricao.codigo,
                              maxLines: 1,
                              style: themeData.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              TimeVO.calculateDateDifference(
                                restricao.inicioPlanejado.getDate() ?? DateTime.now(),
                                restricao.fimPlanejado.getDate() ?? DateTime.now(),
                              ),
                              style: themeData.textTheme.labelSmall,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translation.fields.materiais,
                  style: themeData.textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: atividade.materiais.map(
                    (material) {
                      var quantidade = material.quantidade.formatDoubleToString(decimalDigits: material.unidade.decimal);
                      quantidade += ' ${material.unidade.nome}';

                      return Container(
                        width: 171,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: colorTheme?.border ?? Colors.transparent,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              material.produto.nome,
                              maxLines: 1,
                              style: themeData.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              quantidade,
                              style: themeData.textTheme.labelSmall,
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                )
              ],
            ),
            const SizedBox(height: 24),
            DesktopAtividadeAcoesWidget(
              atividadeNotifier: atividadeNotifier,
              chaoDeFabricaListStore: widget.chaoDeFabricaListStore,
              apontamentoStore: apontamentoStore,
              atividadeByIdStore: atividadeByIdStore,
            ),
          ],
        ),
      );
    });
  }
}
