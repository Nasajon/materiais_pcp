// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showDialog;
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/operacao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/recurso_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_editar_recurso_widget.dart';

class DesktopOperacaoRecursoWidget extends StatefulWidget {
  final UnidadeEntity unidade;
  final RecursoController recursoController;
  final String grupoRecursoId;
  final OperacaoController operacaoController;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetUnidadeStore getUnidadeStore;

  const DesktopOperacaoRecursoWidget({
    Key? key,
    required this.unidade,
    required this.recursoController,
    required this.grupoRecursoId,
    required this.operacaoController,
    required this.getGrupoDeRestricaoStore,
    required this.getUnidadeStore,
  }) : super(key: key);

  @override
  State<DesktopOperacaoRecursoWidget> createState() => _DesktopOperacaoRecursoWidgetState();
}

class _DesktopOperacaoRecursoWidgetState extends State<DesktopOperacaoRecursoWidget> {
  final isEdit = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return LayoutBuilder(
      builder: (context, constraints) {
        // context.select(() => [widget.recursoController.recurso]);

        return RxBuilder(builder: (context) {
          final recurso = widget.recursoController.recurso;

          return Column(
            children: [
              ValueListenableBuilder(
                valueListenable: isEdit,
                builder: (context, value, child) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: value
                        ? DesktopOperacaoEditarRecursoWidget(
                            isEdit: isEdit,
                            grupoRecursoId: widget.grupoRecursoId,
                            operacaoController: widget.operacaoController,
                            recursoController: widget.recursoController,
                            unidade: widget.unidade,
                            getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
                            getUnidadeStore: widget.getUnidadeStore,
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 14, left: 30, right: 14, bottom: 14),
                                child: Row(
                                  children: [
                                    Text(
                                      recurso.nome,
                                      style: themeData.textTheme.bodyLarge,
                                    ),
                                    const Spacer(),
                                    // TODO: Formatar os textos corretos
                                    TagWidget(title: '${translation.fields.preparacao}: ${recurso.capacidade.preparacao.timeFormat()}'),
                                    const SizedBox(width: 10),
                                    TagWidget(title: '${translation.fields.execucao}: ${recurso.capacidade.execucao.timeFormat()}'),
                                    const SizedBox(width: 10),
                                    TagWidget(
                                      title:
                                          '${recurso.capacidade.capacidadeTotal.formatDoubleToString(decimalDigits: widget.unidade.decimal)}${widget.unidade.codigo.toLowerCase()}',
                                    ),
                                    const SizedBox(width: 10),
                                    CustomTextButton(
                                      title: translation.fields.editar,
                                      style: themeData.textTheme.labelLarge?.copyWith(
                                        color: colorTheme?.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      onPressed: () {
                                        isEdit.value = true;
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Divider(color: colorTheme?.border, height: 1),
                            ],
                          ),
                  );
                },
              ),
            ],
          );
        });
      },
    );
  }
}
