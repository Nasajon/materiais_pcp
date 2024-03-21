// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/core/widgets/table/pcp_table.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_finalizar_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_finalizar_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_atividade_by_id_store.dart';

class DesktopFinalizarAtividadeWidget extends StatefulWidget {
  final ChaoDeFabricaAtividadeAggregate atividade;
  final ChaoDeFabricaFinalizarStore finalizarStore;
  final ChaoDeFabricaAtividadeByIdStore atividadeByIdStore;

  const DesktopFinalizarAtividadeWidget({
    Key? key,
    required this.atividade,
    required this.finalizarStore,
    required this.atividadeByIdStore,
  }) : super(key: key);

  @override
  State<DesktopFinalizarAtividadeWidget> createState() => _DesktopFinalizarAtividadeWidgetState();
}

class _DesktopFinalizarAtividadeWidgetState extends State<DesktopFinalizarAtividadeWidget> {
  ChaoDeFabricaAtividadeAggregate get atividade => widget.atividade;
  ChaoDeFabricaFinalizarStore get finalizarStore => widget.finalizarStore;
  ChaoDeFabricaAtividadeByIdStore get atividadeByIdStore => widget.atividadeByIdStore;

  late ChaoDeFabricaFinalizarEntity finalizar;

  late final Disposer finalizarStoreDisposer;

  @override
  void initState() {
    super.initState();

    finalizar = ChaoDeFabricaFinalizarEntity(
      id: atividade.id,
      quantidade: atividade.quantidade,
      unidade: atividade.unidade,
      data: DateVO.date(DateTime.now()),
      horario: TimeVO.time(TimeOfDay.now()),
      materiais: atividade.materiais
          .map(
            (material) => material.copyWith(
              quantidadeUtilizada:
                  DoubleVO(material.quantidade.value - (material.quantidadeUtilizada.value + material.quantidadePerda.value)),
              quantidadePerda: DoubleVO(null),
            ),
          )
          .toList(),
    );

    finalizarStore.setLoading(false, force: true);
    finalizarStore.update(false, force: true);

    finalizarStoreDisposer = finalizarStore.observer(
      onLoading: (value) => setState(() {}),
      onError: (error) => setState(() {}),
      onState: (state) async {
        if (state) {
          await atividadeByIdStore.getAtividade(atividade.id);
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  void dispose() {
    finalizarStoreDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<NhidsColorTheme>();

    final size = MediaQuery.of(context).size;

    final dateNow = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd MMM yyyy', locale.languageCode).format(dateNow);
    String formattedTime = DateFormat('HH:mm').format(dateNow);
    String timeZone = dateNow.timeZoneOffset.toString().split('.').first.split(':').first;

    var horario = atividade.inicioPreparacaoPlanejado.dateFormat(format: 'HH:mm')?.replaceAll(':', 'h') ?? '';
    horario += ' - ';
    horario += atividade.fimPreparacaoPlanejado.dateFormat(format: 'HH:mm')?.replaceAll(':', 'h') ?? '';

    return NhidsScaffold.title(
      title: translation.fields.finalizarAtividade,
      onClosePressed: () => Navigator.of(context).pop(),
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
              NhidsTwoLine(
                title: translation.fields.ordemDeProducao,
                child: NhidsTagChip(
                  label: atividade.ordemDeProducao.codigo,
                  color: colorTheme?.primary,
                  type: NhidsTagChipType.outlined,
                ),
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
              SizedBox(width: 24.responsive),
              NhidsTwoLineText(
                title: translation.fields.centroDeTrabalho,
                subtitle: atividade.centroDeTrabalho.nome,
                type: NhidsTextType.type2,
              ),
              if (atividade.operacao.produtoResultante != null) ...[
                SizedBox(width: 24.responsive),
                NhidsTwoLineText(
                  title: translation.fields.produtoResultante,
                  subtitle: atividade.operacao.produtoResultante?.nome ?? '',
                  type: NhidsTextType.type2,
                ),
              ],
              SizedBox(width: 24.responsive),
              NhidsTwoLineText(
                title: translation.fields.quantidade,
                subtitle:
                    '${atividade.quantidade.formatDoubleToString(decimalDigits: atividade.unidade.decimal)} ${atividade.unidade.nome.toLowerCase()}',
                type: NhidsTextType.type2,
              ),
              SizedBox(width: 24.responsive),
              NhidsTwoLineText(
                title: translation.fields.horarioPrevisto,
                subtitle: horario,
                type: NhidsTextType.type2,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1225.responsive),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20.responsive),
                Text(translation.messages.mensagemFinalizarChaoDeFabrica),
                SizedBox(height: 20.responsive),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: NhidsDecimalFormField(
                        label: translation.fields.quantidadeTotalProduzida,
                        initialValue: finalizar.quantidade.value,
                        decimalDigits: finalizar.unidade.decimal,
                        suffixSymbol: atividade.unidade.nome.toLowerCase(),
                        onChanged: (value) {
                          setState(() => finalizar = finalizar.copyWith(quantidade: DoubleVO(value)));
                        },
                      ),
                    ),
                    SizedBox(width: 16.responsive),
                    Flexible(
                      child: NhidsDateFormField(
                        label: translation.fields.data,
                        initialValue: finalizar.data.getDate(),
                        onChanged: (value) {
                          setState(() => finalizar = finalizar.copyWith(data: DateVO.dateOrNull(value)));
                        },
                      ),
                    ),
                    SizedBox(width: 16.responsive),
                    Flexible(
                      child: TimeTextFormFieldWidget(
                        label: translation.fields.horario,
                        initTime: finalizar.horario.getTime(),
                        onChanged: (value) {
                          setState(() => finalizar = finalizar.copyWith(horario: TimeVO.timeOrNull(value)));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.responsive),
                NhidsTextTitle(
                  text: translation.titles.materiais,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 16.responsive),
                LayoutBuilder(
                  builder: (_, constraints) {
                    return PCPTable(
                      type: TypeTable.modelo3,
                      columns: [
                        DataColumn(
                          label: TextDataColumn(text: translation.fields.material),
                        ),
                        DataColumn(
                          label: TextDataColumn(text: translation.fields.roteiro),
                        ),
                        DataColumn(
                          label: TextDataColumn(text: translation.fields.utilizadoAcumulado),
                        ),
                        DataColumn(
                          label: TextDataColumn(text: translation.fields.utilizadoTotal),
                        ),
                        DataColumn(
                          label: TextDataColumn(text: translation.fields.perdaAcumulado),
                        ),
                        DataColumn(
                          label: TextDataColumn(text: translation.fields.perdaTotal),
                        ),
                        DataColumn(
                          label: TextDataColumn(text: translation.fields.sobra),
                        ),
                      ],
                      rows: finalizar.materiais.map(
                        (material) {
                          final materialAtividade = atividade.materiais.firstWhere((element) => element.id == material.id);

                          return DataRow(
                            cells: [
                              DataCell(
                                SizedBox(
                                  width: (constraints.maxWidth / 6) - 48.responsive,
                                  child: Text(material.produto.nome),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: (constraints.maxWidth / 6) - 48.responsive,
                                  child: Text('${materialAtividade.quantidade.formatDoubleToString(
                                    decimalDigits: material.unidade.decimal,
                                  )} ${finalizar.unidade.nome}'),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: (constraints.maxWidth / 6) - 48.responsive,
                                  child: Text(
                                    '${materialAtividade.quantidadeUtilizada.formatDoubleToString(
                                      decimalDigits: material.unidade.decimal,
                                    )} ${finalizar.unidade.nome}',
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: (constraints.maxWidth / 6) - 48.responsive,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.responsive),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: NhidsDecimalFormField(
                                            label: '',
                                            initialValue: material.quantidadeUtilizada.valueOrNull,
                                            decimalDigits: material.unidade.decimal,
                                            onChanged: (value) {
                                              final index = finalizar.materiais.indexWhere((element) => element.id == material.id);

                                              finalizar.materiais.setAll(
                                                index,
                                                [
                                                  material.copyWith(
                                                    quantidadeUtilizada: DoubleVO(value),
                                                    quantidadeSobra: DoubleVO(
                                                      materialAtividade.quantidade.value -
                                                          (value +
                                                              material.quantidadePerda.value +
                                                              materialAtividade.quantidadeUtilizada.value +
                                                              materialAtividade.quantidadePerda.value),
                                                    ),
                                                  ),
                                                ],
                                              );

                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 12.responsive),
                                        Text(material.unidade.nome.toLowerCase()),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: (constraints.maxWidth / 6) - 48.responsive,
                                  child: Text(
                                    '${materialAtividade.quantidadePerda.formatDoubleToString(
                                      decimalDigits: material.unidade.decimal,
                                    )} ${finalizar.unidade.nome}',
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: (constraints.maxWidth / 6) - 48.responsive,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.responsive),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: NhidsDecimalFormField(
                                            label: '',
                                            initialValue: material.quantidadePerda.valueOrNull,
                                            decimalDigits: material.unidade.decimal,
                                            onChanged: (value) {
                                              final index = finalizar.materiais.indexWhere((element) => element.id == material.id);

                                              finalizar.materiais.setAll(
                                                index,
                                                [
                                                  material.copyWith(
                                                    quantidadePerda: DoubleVO(value),
                                                    quantidadeSobra: DoubleVO(
                                                      materialAtividade.quantidade.value -
                                                          (value +
                                                              material.quantidadeUtilizada.value +
                                                              materialAtividade.quantidadeUtilizada.value +
                                                              materialAtividade.quantidadePerda.value),
                                                    ),
                                                  ),
                                                ],
                                              );

                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 12.responsive),
                                        Text(material.unidade.nome.toLowerCase()),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: (constraints.maxWidth / 6) - 100.responsive,
                                  child: Text(
                                    '${material.quantidadeSobra.formatDoubleToString(
                                      decimalDigits: material.unidade.decimal,
                                    )} ${finalizar.unidade.nome}',
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NhidsFooter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            NhidsTertiaryButton(
              label: translation.fields.cancelar,
              isEnabled: !finalizarStore.isLoading,
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(width: 10.responsive),
            NhidsPrimaryButton(
              label: translation.fields.finalizarAtividade,
              // isLoading: finalizarStore.isLoading, // TODO: verificar
              onPressed: () {
                final materiais = finalizar.materiais;

                finalizarStore.apontar(finalizar.copyWith(materiais: materiais));
              },
            ),
          ],
        ),
      ),
    );
  }
}
