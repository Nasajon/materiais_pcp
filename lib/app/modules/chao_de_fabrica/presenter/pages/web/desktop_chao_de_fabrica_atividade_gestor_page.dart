// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/paginator_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_atividade_acoes_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_card_atividade_materiais_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_card_atividade_restricoes_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_apontamento_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_atividade_by_id_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_finalizar_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';

class DesktopChaoDeFabricaAtividadeGestorPage extends StatefulWidget {
  final ChaoDeFabricaAtividadeAggregate atividade;
  final ChaoDeFabricaListStore chaoDeFabricaListStore;
  final ChaoDeFabricaAtividadeByIdStore atividadeByIdStore;
  final ChaoDeFabricaApontamentoStore apontamentoStore;
  final ChaoDeFabricaFinalizarStore finalizarStore;

  const DesktopChaoDeFabricaAtividadeGestorPage({
    Key? key,
    required this.atividade,
    required this.chaoDeFabricaListStore,
    required this.apontamentoStore,
    required this.finalizarStore,
    required this.atividadeByIdStore,
  }) : super(key: key);

  @override
  State<DesktopChaoDeFabricaAtividadeGestorPage> createState() => _DesktopChaoDeFabricaAtividadeGestorPageState();
}

class _DesktopChaoDeFabricaAtividadeGestorPageState extends State<DesktopChaoDeFabricaAtividadeGestorPage> {
  ChaoDeFabricaListStore get chaoDeFabricaListStore => widget.chaoDeFabricaListStore;
  ChaoDeFabricaAtividadeByIdStore get atividadeByIdStore => widget.atividadeByIdStore;
  ChaoDeFabricaApontamentoStore get apontamentoStore => widget.apontamentoStore;
  ChaoDeFabricaFinalizarStore get finalizarStore => widget.finalizarStore;

  late final ValueNotifier<ChaoDeFabricaAtividadeAggregate> atividadeNotifier;

  @override
  void initState() {
    super.initState();

    atividadeNotifier = ValueNotifier(widget.atividade);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<NhidsColorTheme>();
    final size = MediaQuery.of(context).size;

    return NhidsValueListenableBuilder(
        valuesListenable: [atividadeNotifier],
        builder: (_, values, __) {
          final [atividade as ChaoDeFabricaAtividadeAggregate] = values;

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

          final dateNow = DateTime.now();
          String formattedDate = DateFormat('EEEE, dd MMM yyyy', locale.languageCode).format(dateNow);
          String formattedTime = DateFormat('HH:mm').format(dateNow);
          String timeZone = dateNow.timeZoneOffset.toString().split('.').first.split(':').first;

          var horario = atividade.inicioPreparacaoPlanejado.dateFormat(format: 'HH:mm')?.replaceAll(':', 'h') ?? '';
          horario += ' - ';
          horario += atividade.fimPreparacaoPlanejado.dateFormat(format: 'HH:mm')?.replaceAll(':', 'h') ?? '';
          horario += ' (${atividade.fimPreparacaoPlanejado.dateFormat()})';

          var ultmaAtualizacao = atividade.ultimaAtualizacao.dateFormat() ?? '';
          ultmaAtualizacao += ' ${translation.fields.as} ';
          ultmaAtualizacao += atividade.ultimaAtualizacao.dateFormat(format: 'HH:mm')?.replaceAll(':', 'h') ?? '';

          return NhidsScaffold(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  atividade.operacao.nome,
                  style: themeData.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 12.responsive),
                NhidsTagChip(
                  label: atividade.status.name,
                  color: statusColor,
                  type: NhidsTagChipType.outlined,
                ),
              ],
            ),
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
                    SizedBox(width: 24.responsive),
                    NhidsTwoLineText(
                      title: translation.fields.centroDeTrabalho,
                      subtitle: atividade.centroDeTrabalho.nome,
                      type: NhidsTextType.type2,
                    ),
                    SizedBox(width: 24.responsive),
                    NhidsTwoLine(
                      title: translation.fields.recurso,
                      child: NhidsTagChip(
                        label: atividade.recurso.nome,
                        color: colorTheme?.primary,
                        type: NhidsTagChipType.outlined,
                      ),
                    ),
                    const SizedBox(width: 24),
                    NhidsTwoLine(
                      title: translation.fields.ordemDeProducao,
                      child: NhidsTagChip(
                        label: atividade.ordemDeProducao.codigo,
                        color: colorTheme?.primary,
                        type: NhidsTagChipType.outlined,
                      ),
                    ),
                    const SizedBox(width: 24),
                    NhidsTwoLine(
                      title: translation.fields.operacao,
                      child: NhidsTagChip(
                        label: atividade.operacao.nome,
                        color: colorTheme?.primary,
                        type: NhidsTagChipType.outlined,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1000.responsive),
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(20.responsive),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LayoutBuilder(
                              builder: (_, constraints) {
                                return Container(
                                  width: constraints.maxWidth,
                                  padding: EdgeInsets.all(20.responsive),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: colorTheme?.border ?? Colors.grey),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        translation.titles.acompanhamentoDaAtividade,
                                        style: themeData.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 12.responsive),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 90.responsive,
                                            height: 90.responsive,
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  width: 90.responsive,
                                                  height: 90.responsive,
                                                  child: CircularProgressIndicator(
                                                    value: atividade.progresso,
                                                    backgroundColor: colorTheme?.border,
                                                    color: colorTheme?.info,
                                                    strokeWidth: 10.responsive,
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    '${DoubleVO(atividade.progresso * 100).formatDoubleToString(decimalDigits: 0)}%',
                                                    style: themeData.textTheme.titleLarge?.copyWith(
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (atividade.operacao.produtoResultante != null) ...[
                                                  SizedBox(width: 16.responsive),
                                                  Flexible(
                                                    child: NhidsTwoLineText(
                                                      title: translation.fields.produtoResultante,
                                                      subtitle: atividade.operacao.produtoResultante?.nome ?? '',
                                                      type: NhidsTextType.type2,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                ],
                                                SizedBox(width: 16.responsive),
                                                Flexible(
                                                  child: NhidsTwoLineText(
                                                    title: translation.fields.produzidoAteOMomento,
                                                    subtitle:
                                                        '${atividade.produzida.formatDoubleToString(decimalDigits: atividade.unidade.decimal)} ${atividade.unidade.nome.toLowerCase()}',
                                                    type: NhidsTextType.type2,
                                                  ),
                                                ),
                                                const Spacer(),
                                                SizedBox(width: 16.responsive),
                                                Flexible(
                                                  child: NhidsTwoLineText(
                                                    title: translation.fields.horarioPrevisto,
                                                    subtitle: horario,
                                                    type: NhidsTextType.type2,
                                                  ),
                                                ),
                                                const Spacer(),
                                                SizedBox(width: 16.responsive),
                                                Flexible(
                                                  child: NhidsTwoLineText(
                                                    title: translation.fields.ultimaAtualizacao,
                                                    subtitle: ultmaAtualizacao,
                                                    type: NhidsTextType.type2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20.responsive),
                            Row(
                              children: [
                                DesktopCardAtividadeRestricoesWidget(paginator: PaginatorVO(atividade.restricoes)),
                                SizedBox(width: 16.responsive),
                                DesktopCardAtividadeMateriaisWidget(paginator: PaginatorVO(atividade.materiais)),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            bottomNavigationBar: NhidsFooter(
              child: DesktopAtividadeAcoesWidget(
                atividadeNotifier: atividadeNotifier,
                chaoDeFabricaListStore: chaoDeFabricaListStore,
                apontamentoStore: apontamentoStore,
                finalizarStore: finalizarStore,
                atividadeByIdStore: atividadeByIdStore,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ),
          );
        });
  }
}
