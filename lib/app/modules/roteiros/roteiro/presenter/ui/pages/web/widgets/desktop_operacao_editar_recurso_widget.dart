// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showDialog;
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_restricao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/recurso_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_adicionar_grupo_de_restriao_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_grupo_de_restricao.dart';

class DesktopOperacaoEditarRecursoWidget extends StatefulWidget {
  final ValueNotifier isEdit;
  final UnidadeEntity unidade;
  final RecursoController recursoController;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetUnidadeStore getUnidadeStore;

  const DesktopOperacaoEditarRecursoWidget({
    Key? key,
    required this.isEdit,
    required this.unidade,
    required this.recursoController,
    required this.getGrupoDeRestricaoStore,
    required this.getUnidadeStore,
  }) : super(key: key);

  @override
  State<DesktopOperacaoEditarRecursoWidget> createState() => _DesktopOperacaoEditarRecursoWidgetState();
}

class _DesktopOperacaoEditarRecursoWidgetState extends State<DesktopOperacaoEditarRecursoWidget> {
  late final RxNotifier<RecursoAggregate> novoRecurso;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    novoRecurso = RxNotifier(widget.recursoController.recurso.copyWith());
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [novoRecurso.value]);

    final recurso = novoRecurso.value;

    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: colorTheme?.border ?? Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  translation.titles.editarEntidade(translation.fields.recurso),
                  style: themeData.textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  recurso.nome,
                  style: themeData.textTheme.titleSmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Flexible(
                      child: TimeTextFormFieldWidget(
                        label: translation.fields.preparacao,
                        initTime: recurso.capacidade.preparacao.getTime(),
                        validator: (_) => recurso.capacidade.preparacao.errorMessage,
                        onChanged: (value) {
                          if (value != null) {
                            final capacidade = recurso.capacidade.copyWith(preparacao: TimeVO.time(value));
                            novoRecurso.value = recurso.copyWith(capacidade: capacidade);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: TimeTextFormFieldWidget(
                        label: translation.fields.execucao,
                        initTime: recurso.capacidade.execucao.getTime(),
                        validator: (_) => recurso.capacidade.execucao.errorMessage,
                        onChanged: (value) {
                          if (value != null) {
                            final capacidade = recurso.capacidade.copyWith(execucao: TimeVO.time(value));
                            novoRecurso.value = recurso.copyWith(capacidade: capacidade);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      child: DoubleTextFormFieldWidget(
                        label: translation.fields.capacidadeTotal,
                        initialValue: recurso.capacidade.capacidadeTotal.valueOrNull,
                        suffixSymbol: widget.unidade.codigo,
                        decimalDigits: widget.unidade.decimal,
                        validator: (_) => recurso.capacidade.capacidadeTotal.errorMessage,
                        onValueOrNull: (value) {
                          final capacidade = recurso.capacidade.copyWith(capacidadeTotal: DoubleVO(value));
                          novoRecurso.value = recurso.copyWith(capacidade: capacidade);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: DoubleTextFormFieldWidget(
                        label: translation.fields.minimaParaUso,
                        initialValue: recurso.capacidade.minima.valueOrNull,
                        suffixSymbol: widget.unidade.codigo,
                        decimalDigits: widget.unidade.decimal,
                        validator: (_) => recurso.capacidade.minima.errorMessage,
                        onValueOrNull: (value) {
                          final capacidade = recurso.capacidade.copyWith(minima: DoubleVO(value));
                          novoRecurso.value = recurso.copyWith(capacidade: capacidade);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: DoubleTextFormFieldWidget(
                        label: translation.fields.maximaRecomendada,
                        initialValue: recurso.capacidade.maxima.valueOrNull,
                        suffixSymbol: widget.unidade.codigo,
                        decimalDigits: widget.unidade.decimal,
                        validator: (_) => recurso.capacidade.maxima.errorMessage,
                        onValueOrNull: (value) {
                          final capacidade = recurso.capacidade.copyWith(maxima: DoubleVO(value));
                          novoRecurso.value = recurso.copyWith(capacidade: capacidade);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DesktopOperacaoGrupoDeRescricaoWidget(
                  gruposDeRestricoesControllers: widget.recursoController.listGrupoDeRestricaoController,
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomTextButton(
                    title: translation.fields.adicionarGrupoDeRestricoes,
                    onPressed: () async {
                      final responseModal = await showDialog(
                        context: context,
                        builder: (context) {
                          return DesktopOperacaoAdicionarGrupoDeRestricaoWidget(
                            grupoDeRestricaoController: widget.recursoController.novoGrupoDeRestricaoController,
                            getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
                            getUnidadeStore: widget.getUnidadeStore,
                          );
                        },
                      );

                      if (responseModal != null &&
                          responseModal is GrupoDeRestricaoController &&
                          responseModal.grupoDeRestricao != GrupoDeRestricaoAggregate.empty()) {
                        widget.recursoController.adicionarGrupoDeRestricaoController = responseModal;
                        setState(() {});
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      title: translation.fields.cancelar,
                      onPressed: () async {
                        if (novoRecurso.value != widget.recursoController.recurso) {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return ConfirmationModalWidget(
                                  title: translation.titles.descartarAlteracoes,
                                  messages: translation.messages.descatarAlteracoesCriacaoEntidade,
                                  titleCancel: translation.fields.descartar,
                                  titleSuccess: translation.fields.continuar,
                                  onCancel: () => widget.isEdit.value = false,
                                );
                              });

                          return;
                        }

                        widget.isEdit.value = false;
                      },
                    ),
                    const SizedBox(width: 12),
                    CustomOutlinedButton(
                      title: translation.fields.salvar,
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        if (novoRecurso.value != widget.recursoController.recurso) {
                          widget.recursoController.recurso = novoRecurso.value;
                        }

                        widget.isEdit.value = false;
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
