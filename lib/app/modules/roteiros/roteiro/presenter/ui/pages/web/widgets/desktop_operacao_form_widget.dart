import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showDialog;
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_recurso_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/operacao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_material_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_adicionar_grupo_de_recurso_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_dados_basicos_from_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_grupo_de_recurso_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_material_form_widget.dart';

class DesktopOperacaoFormWidget extends StatefulWidget {
  final OperacaoController operacaoController;
  final GetUnidadeStore getUnidadeStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetProdutoStore getProdutoStore;
  final GetMaterialStore getMaterialStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;

  const DesktopOperacaoFormWidget({
    Key? key,
    required this.operacaoController,
    required this.getUnidadeStore,
    required this.getCentroDeTrabalhoStore,
    required this.getProdutoStore,
    required this.getMaterialStore,
    required this.getGrupoDeRecursoStore,
    required this.getGrupoDeRestricaoStore,
  }) : super(key: key);

  @override
  State<DesktopOperacaoFormWidget> createState() => _DesktopOperacaoFormWidgetState();
}

class _DesktopOperacaoFormWidgetState extends State<DesktopOperacaoFormWidget> {
  @override
  void initState() {
    super.initState();
    widget.getMaterialStore.getMateriais(widget.operacaoController.fichaTecnicaId);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return CustomScaffold.titleString(
      translation.titles.adicionarDisponibilidade,
      controller: CustomScaffoldController(),
      alignment: Alignment.centerLeft,
      closeIcon: Icon(FontAwesomeIcons.xmark, color: colorTheme?.text),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 690),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DesktopOperacaoDadosBasicosFormWidget(
                  operacaoController: widget.operacaoController,
                  getUnidadeStore: widget.getUnidadeStore,
                  getCentroDeTrabalhoStore: widget.getCentroDeTrabalhoStore,
                  getProdutoStore: widget.getProdutoStore,
                ),
                const SizedBox(height: 20),
                DesktopOperacaoMaterialFormWidget(
                  operacaoController: widget.operacaoController,
                  getMaterialStore: widget.getMaterialStore,
                ),
                const SizedBox(height: 20),
                DesktopOperacaoGrupoDeRecursoWidget(
                  key: ValueKey(widget.operacaoController.listGrupoRecursoController.length),
                  unidade: widget.operacaoController.operacao.unidade,
                  gruposDeRecursosController: widget.operacaoController.listGrupoRecursoController,
                  getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
                  getUnidadeStore: widget.getUnidadeStore,
                  adicionarGrupoDeRecurso: () async {
                    if (widget.operacaoController.operacao.unidade == UnidadeEntity.empty()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ErrorModal(errorMessage: 'Sem unidade');
                        },
                      );
                      return;
                    }

                    final responseModal = await showDialog(
                      context: context,
                      builder: (context) {
                        return DesktopOperacaoAdicionarGrupoDeRecursoWidget(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
