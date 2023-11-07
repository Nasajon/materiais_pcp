// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_recurso_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/operacao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/mobile/widgets/mobile_operacao_adicionar_grupo_de_recurso_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/mobile/widgets/mobile_operacao_recurso_widget.dart';

class MobileOperacaoGrupoDeRecursoWidget extends StatefulWidget {
  final OperacaoController operacaoController;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetUnidadeStore getUnidadeStore;

  const MobileOperacaoGrupoDeRecursoWidget({
    Key? key,
    required this.operacaoController,
    required this.getGrupoDeRecursoStore,
    required this.getGrupoDeRestricaoStore,
    required this.getUnidadeStore,
  }) : super(key: key);

  @override
  State<MobileOperacaoGrupoDeRecursoWidget> createState() => _MobileOperacaoGrupoDeRecursoWidgetState();
}

class _MobileOperacaoGrupoDeRecursoWidgetState extends State<MobileOperacaoGrupoDeRecursoWidget> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: colorTheme?.border ?? Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  translation.titles.tituloRecursos,
                  style: themeData.textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12),
                ...widget.operacaoController.listGrupoRecursoController.map(
                  (grupoDeRecursoController) => ExpansionGrupoDeRecursoWidget(
                    operacaoController: widget.operacaoController,
                    grupoDeRecursoController: grupoDeRecursoController,
                    getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
                    getUnidadeStore: widget.getUnidadeStore,
                    unidade: widget.operacaoController.operacao.unidade,
                    deletarGrupo: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmationModalWidget(
                            title: translation.titles.removerEntidade(translation.fields.grupoDeRecursos),
                            messages: translation.messages.mensagemRemoverEntidade(translation.fields.grupoDeRecursos),
                            titleCancel: translation.fields.descartar,
                            titleSuccess: translation.fields.continuar,
                            onCancel: () {
                              widget.operacaoController.removerGrupoDeRecurso(grupoDeRecursoController.grupoDeRecurso.grupo.id);
                              setState(() {});
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomOutlinedButton(
                    title: translation.fields.adicionarGrupoDeRecursos,
                    onPressed: () async {
                      if (widget.operacaoController.operacao.unidade == UnidadeEntity.empty()) {
                        NotificationSnackBar.showSnackBar(
                          translation.messages.mensagemSelecioneUmaUnidadeDeMedida,
                          themeData: themeData,
                        );

                        return;
                      }

                      final responseModal = await showDialog(
                        context: context,
                        builder: (context) {
                          return MobileOperacaoAdicionarGrupoDeRecursoWidget(
                            grupoDeRecursoController: widget.operacaoController.novoGrupoDeRecursoController,
                            getGrupoDeRecursoStore: widget.getGrupoDeRecursoStore,
                            getUnidadeStore: widget.getUnidadeStore,
                            unidade: widget.operacaoController.operacao.unidade,
                            listaDeIdsDosGruposParaDeletar: widget.operacaoController.listGrupoRecursoController
                                .map((controller) => controller.grupoDeRecurso.grupo.id)
                                .toList(),
                          );
                        },
                      );

                      if (responseModal != null &&
                          responseModal is GrupoDeRecursoController &&
                          responseModal.grupoDeRecurso != GrupoDeRecursoAggregate.empty()) {
                        widget.operacaoController.adicionarGrupoDeRecursoController = responseModal;
                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExpansionGrupoDeRecursoWidget extends StatelessWidget {
  final OperacaoController operacaoController;
  final GrupoDeRecursoController grupoDeRecursoController;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetUnidadeStore getUnidadeStore;
  final UnidadeEntity unidade;
  final VoidCallback deletarGrupo;

  const ExpansionGrupoDeRecursoWidget({
    Key? key,
    required this.operacaoController,
    required this.grupoDeRecursoController,
    required this.getGrupoDeRestricaoStore,
    required this.getUnidadeStore,
    required this.unidade,
    required this.deletarGrupo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      collapsedTextColor: colorTheme?.text,
      textColor: colorTheme?.text,
      iconColor: colorTheme?.text,
      collapsedIconColor: colorTheme?.text,
      backgroundColor: colorTheme?.background,
      shape: Border.all(color: colorTheme?.background ?? Colors.transparent),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(grupoDeRecursoController.grupoDeRecurso.grupo.nome),
          const Spacer(),
          IconButton(
            onPressed: deletarGrupo,
            icon: Icon(
              size: 18,
              FontAwesomeIcons.trash,
              color: colorTheme?.danger ?? Colors.transparent,
            ),
            splashRadius: 20,
          ),
        ],
      ),
      children: [
        Divider(color: colorTheme?.border, height: 1),
        ...grupoDeRecursoController.listRecursoController
            .map(
              (recursoController) => MobileOperacaoRecursoWidget(
                unidade: unidade,
                grupoRecursoId: grupoDeRecursoController.grupoDeRecurso.grupo.id,
                operacaoController: operacaoController,
                recursoController: recursoController,
                getGrupoDeRestricaoStore: getGrupoDeRestricaoStore,
                getUnidadeStore: getUnidadeStore,
              ),
            )
            .toList(),
      ],
    );
  }
}
