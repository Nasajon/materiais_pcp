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
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_apontamento_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_apontamento_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_atividade_by_id_store.dart';

class DesktopApontarEvolucaoWidget extends StatefulWidget {
  final ChaoDeFabricaAtividadeAggregate atividade;
  final ChaoDeFabricaApontamentoStore apontamentoStore;
  final ChaoDeFabricaAtividadeByIdStore atividadeByIdStore;

  const DesktopApontarEvolucaoWidget({
    Key? key,
    required this.atividade,
    required this.apontamentoStore,
    required this.atividadeByIdStore,
  }) : super(key: key);

  @override
  State<DesktopApontarEvolucaoWidget> createState() => _DesktopApontarEvolucaoWidgetState();
}

class _DesktopApontarEvolucaoWidgetState extends State<DesktopApontarEvolucaoWidget> {
  ChaoDeFabricaAtividadeAggregate get atividade => widget.atividade;
  ChaoDeFabricaApontamentoStore get apontamentoStore => widget.apontamentoStore;
  ChaoDeFabricaAtividadeByIdStore get atividadeByIdStore => widget.atividadeByIdStore;

  late ChaoDeFabricaApontamentoEntity apontamento;

  late final Disposer apontamentoStoreDisposer;

  @override
  void initState() {
    super.initState();

    apontamento = ChaoDeFabricaApontamentoEntity(
      id: atividade.id,
      quantidade: DoubleVO(0),
      progresso: DoubleVO(0),
      unidade: atividade.unidade,
      data: DateVO.date(DateTime.now()),
      horario: TimeVO.time(TimeOfDay.now()),
      materiais: atividade.materiais
          .map(
            (material) => material.copyWith(
              quantidadeUtilizada: DoubleVO(null),
              quantidadePerda: DoubleVO(null),
            ),
          )
          .toList(),
    );

    apontamentoStore.setLoading(false, force: true);
    apontamentoStore.update(false, force: true);

    apontamentoStoreDisposer = apontamentoStore.observer(
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
    apontamentoStoreDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final dateNow = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd MMM yyyy', locale.languageCode).format(dateNow);
    String formattedTime = DateFormat('HH:mm').format(dateNow);
    String timeZone = dateNow.timeZoneOffset.toString().split('.').first.split(':').first;

    return NhidsScaffold.subtitle(
      title: translation.fields.apontarEvolucao,
      subtitle: '${translation.fields.atividade} #${atividade.codigo}',
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
                  type: NhidsTagChipType.outlined,
                ),
              ),
              const SizedBox(width: 24),
              NhidsTwoLine(
                title: translation.fields.recurso,
                child: NhidsTagChip(
                  label: atividade.recurso.nome,
                  type: NhidsTagChipType.outlined,
                ),
              ),
              const SizedBox(width: 24),
              NhidsTwoLineText(
                title: translation.fields.produtoResultante,
                subtitle: 'Teste',
                type: NhidsTextType.type2,
              ),
              const SizedBox(width: 24),
              NhidsTwoLineText(
                title: translation.fields.quantidade,
                subtitle:
                    '${atividade.quantidade.formatDoubleToString(decimalDigits: atividade.unidade.decimal)} ${atividade.unidade.nome.toLowerCase()}',
                type: NhidsTextType.type2,
              ),
              const SizedBox(width: 24),
              NhidsTwoLineText(
                title: translation.fields.produzido,
                subtitle:
                    '${atividade.produzida.formatDoubleToString(decimalDigits: atividade.unidade.decimal)} ${atividade.unidade.nome.toLowerCase()}',
                type: NhidsTextType.type2,
              ),
              const SizedBox(width: 24),
              NhidsTwoLineText(
                title: translation.fields.falta,
                subtitle: '${DoubleVO(atividade.quantidade.value - atividade.produzida.value) //
                    .formatDoubleToString(decimalDigits: atividade.unidade.decimal)} ${atividade.unidade.nome.toLowerCase()}',
                type: NhidsTextType.type2,
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: 130,
                child: NhidsTwoLine(
                  title: translation.fields.progresso,
                  child: NhidsLinearProgressIndicator(
                    value: atividade.progresso,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1124),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(translation.messages.mensagemApontamentoChaoDeFabrica),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: NhidsDecimalFormField(
                      label: translation.fields.quantidade,
                      initialValue: apontamento.quantidade.value,
                      decimalDigits: apontamento.unidade.decimal,
                      suffixSymbol: atividade.unidade.nome.toLowerCase(),
                      onChanged: (value) {
                        setState(() => apontamento = apontamento.copyWith(quantidade: DoubleVO(value)));
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: NhidsIntegerFormField(
                      label: translation.fields.progresso,
                      initialValue: (apontamento.progresso.value * 100).toInt(),
                      suffixSymbol: '%',
                      onChanged: (value) {
                        setState(() => apontamento = apontamento.copyWith(progresso: DoubleVO(value / 100)));
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: DateTextFormFieldWidget(
                      label: translation.fields.data,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: TimeTextFormFieldWidget(label: translation.fields.horario),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              NhidsTextTitle(
                text: translation.titles.materiais,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 16),
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
                        label: TextDataColumn(text: translation.fields.utilizadoParcial),
                      ),
                      DataColumn(
                        label: TextDataColumn(text: translation.fields.perdaAcumulado),
                      ),
                      DataColumn(
                        label: TextDataColumn(text: translation.fields.perdaParcial),
                      ),
                    ],
                    rows: apontamento.materiais.map(
                      (material) {
                        final materialAtividade = atividade.materiais.firstWhere((element) => element.id == material.id);

                        return DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width: (constraints.maxWidth / 6) - 48,
                                child: Text(material.produto.nome),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: (constraints.maxWidth / 6) - 48,
                                child: Text('${materialAtividade.quantidade.formatDoubleToString(
                                  decimalDigits: material.unidade.decimal,
                                )} ${apontamento.unidade.nome}'),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: (constraints.maxWidth / 6) - 48,
                                child: Text(
                                  '${materialAtividade.quantidadeUtilizada.formatDoubleToString(
                                    decimalDigits: material.unidade.decimal,
                                  )} ${apontamento.unidade.nome}',
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: (constraints.maxWidth / 6) - 48,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: NhidsDecimalFormField(
                                          label: '',
                                          initialValue: material.quantidadeUtilizada.valueOrNull,
                                          decimalDigits: material.unidade.decimal,
                                          onChanged: (value) {
                                            final index = apontamento.materiais.indexWhere((element) => element.id == material.id);

                                            apontamento.materiais.setAll(
                                              index,
                                              [material.copyWith(quantidadeUtilizada: DoubleVO(value))],
                                            );

                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(material.unidade.nome.toLowerCase()),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: (constraints.maxWidth / 6) - 48,
                                child: Text(
                                  '${materialAtividade.quantidadePerda.formatDoubleToString(
                                    decimalDigits: material.unidade.decimal,
                                  )} ${apontamento.unidade.nome}',
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: (constraints.maxWidth / 6) - 48,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: NhidsDecimalFormField(
                                          label: '',
                                          initialValue: material.quantidadePerda.valueOrNull,
                                          decimalDigits: material.unidade.decimal,
                                          onChanged: (value) {
                                            final index = apontamento.materiais.indexWhere((element) => element.id == material.id);

                                            apontamento.materiais.setAll(
                                              index,
                                              [material.copyWith(quantidadePerda: DoubleVO(value))],
                                            );

                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(material.unidade.nome.toLowerCase()),
                                    ],
                                  ),
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
      bottomNavigationBar: NhidsFooter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            NhidsTertiaryButton(
              title: translation.fields.cancelar,
              isEnabled: !apontamentoStore.isLoading,
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 10),
            NhidsPrimaryButton(
              title: translation.fields.fazerApontamento,
              isLoading: apontamentoStore.isLoading,
              onPressed: () {
                final materiais = apontamento.materiais
                    .where(
                      (material) => material.quantidadeUtilizada.value > 0 || material.quantidadePerda.value > 0,
                    )
                    .toList();

                apontamentoStore.apontar(apontamento.copyWith(materiais: materiais));
              },
            ),
          ],
        ),
      ),
    );
  }
}
