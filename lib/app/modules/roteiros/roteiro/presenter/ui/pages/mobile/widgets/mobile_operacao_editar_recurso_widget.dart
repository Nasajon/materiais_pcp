// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showDialog;
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_restricao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/operacao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/recurso_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/mobile/widgets/mobile_operacao_adicionar_grupo_de_restriao_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/mobile/widgets/mobile_operacao_grupo_de_restricao.dart';

class MobileOperacaoEditarRecursoWidget extends StatefulWidget {
  final ValueNotifier isEdit;
  final UnidadeEntity unidade;
  final String grupoRecursoId;
  final OperacaoController operacaoController;
  final RecursoController recursoController;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetUnidadeStore getUnidadeStore;

  const MobileOperacaoEditarRecursoWidget({
    Key? key,
    required this.isEdit,
    required this.unidade,
    required this.grupoRecursoId,
    required this.recursoController,
    required this.operacaoController,
    required this.getGrupoDeRestricaoStore,
    required this.getUnidadeStore,
  }) : super(key: key);

  @override
  State<MobileOperacaoEditarRecursoWidget> createState() => _MobileOperacaoEditarRecursoWidgetState();
}

class _MobileOperacaoEditarRecursoWidgetState extends State<MobileOperacaoEditarRecursoWidget> {
  late final RecursoController novoRecursoController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    novoRecursoController = widget.recursoController.copyWith();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    novoRecursoController.recurso;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [novoRecursoController.recurso]);

    final recurso = novoRecursoController.recurso;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: TimeTextFormFieldWidget(
                        label: translation.fields.preparacao,
                        initTime: recurso.capacidade.preparacao.getTime(),
                        validator: (_) => recurso.capacidade.preparacao.errorMessage,
                        onChanged: (value) {
                          if (value != null) {
                            final capacidade = recurso.capacidade.copyWith(preparacao: TimeVO.time(value));
                            novoRecursoController.recurso = recurso.copyWith(capacidade: capacidade);
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
                            novoRecursoController.recurso = recurso.copyWith(capacidade: capacidade);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DoubleTextFormFieldWidget(
                  label: translation.fields.capacidadeTotal,
                  initialValue: recurso.capacidade.capacidadeTotal.valueOrNull,
                  suffixSymbol: widget.unidade.codigo,
                  decimalDigits: widget.unidade.decimal,
                  validator: (_) => recurso.capacidade.capacidadeTotal.errorMessage,
                  onValueOrNull: (value) {
                    final capacidade = recurso.capacidade.copyWith(capacidadeTotal: DoubleVO(value));
                    novoRecursoController.recurso = recurso.copyWith(capacidade: capacidade);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: DoubleTextFormFieldWidget(
                        label: translation.fields.minimaParaUso,
                        initialValue: recurso.capacidade.minima.valueOrNull,
                        suffixSymbol: widget.unidade.codigo,
                        decimalDigits: widget.unidade.decimal,
                        validator: (_) {
                          if (recurso.capacidade.minima.isNotValid) {
                            return recurso.capacidade.minima.errorMessage;
                          } else if (recurso.capacidade.minima.value > recurso.capacidade.capacidadeTotal.value) {
                            return translation.messages.erroCapacidadeMinimaMaiorTotal;
                          } else if (recurso.capacidade.minima.value > recurso.capacidade.maxima.value) {
                            return translation.messages.erroCapacidadeMinimaMaiorMaxima;
                          }

                          return null;
                        },
                        onValueOrNull: (value) {
                          final capacidade = recurso.capacidade.copyWith(minima: DoubleVO(value));
                          novoRecursoController.recurso = recurso.copyWith(capacidade: capacidade);
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
                        validator: (_) {
                          if (recurso.capacidade.maxima.isNotValid) {
                            return recurso.capacidade.maxima.errorMessage;
                          } else if (recurso.capacidade.maxima.value > recurso.capacidade.capacidadeTotal.value) {
                            return translation.messages.erroCapacidadeMaximaMaiorTotal;
                          } else if (recurso.capacidade.maxima.value < recurso.capacidade.minima.value) {
                            return translation.messages.erroCapacidadeMaximaMenorMinima;
                          }

                          return null;
                        },
                        onValueOrNull: (value) {
                          final capacidade = recurso.capacidade.copyWith(maxima: DoubleVO(value));
                          novoRecursoController.recurso = recurso.copyWith(capacidade: capacidade);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MobileOperacaoGrupoDeRescricaoWidget(
                  recursoController: novoRecursoController,
                  getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
                  getUnidadeStore: widget.getUnidadeStore,
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomTextButton(
                    title: translation.fields.adicionarGrupoDeRestricoes,
                    onPressed: () async {
                      final responseModal = await showDialog(
                        context: context,
                        builder: (context) {
                          return MobileOperacaoAdicionarGrupoDeRestricaoWidget(
                            grupoDeRestricaoController: novoRecursoController.novoGrupoDeRestricaoController,
                            getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
                            getUnidadeStore: widget.getUnidadeStore,
                            listaDeIdsDosGruposParaDeletar: novoRecursoController.listGrupoDeRestricaoController
                                .map((controller) => controller.grupoDeRestricao.grupo.id)
                                .toList(),
                          );
                        },
                      );

                      if (responseModal != null &&
                          responseModal is GrupoDeRestricaoController &&
                          responseModal.grupoDeRestricao != GrupoDeRestricaoAggregate.empty()) {
                        widget.recursoController.adicionarGrupoDeRestricao(responseModal.grupoDeRestricao);
                        setState(() {});
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      title: translation.fields.cancelar,
                      onPressed: () {
                        if (novoRecursoController.recurso != widget.recursoController.recurso) {
                          showDialog(
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

                        if (novoRecursoController.recurso != widget.recursoController.recurso) {
                          widget.recursoController.recurso = novoRecursoController.recurso;
                          final gruposRecursos = widget.operacaoController.operacao.gruposDeRecurso.map(
                            (grupo) {
                              if (grupo.grupo.id == widget.grupoRecursoId) {
                                return grupo.copyWith(
                                    recursos: grupo.recursos.map(
                                  (recurso) {
                                    if (recurso.id == novoRecursoController.recurso.id) {
                                      return novoRecursoController.recurso;
                                    }

                                    return recurso;
                                  },
                                ).toList());
                              }
                              return grupo;
                            },
                          ).toList();

                          widget.operacaoController.operacao = widget.operacaoController.operacao.copyWith(gruposDeRecurso: gruposRecursos);
                        }

                        widget.isEdit.value = false;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
