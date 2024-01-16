import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/controllers/operacao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_material_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/mobile/widgets/mobile_operacao_dados_basicos_from_widget.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/mobile/widgets/mobile_operacao_grupo_de_recurso_widget.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/mobile/widgets/mobile_operacao_material_form_widget.dart';

class MobileOperacaoFormWidget extends StatefulWidget {
  final OperacaoController operacaoController;
  final GetUnidadeStore getUnidadeStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetProdutoStore getProdutoStore;
  final GetMaterialStore getMaterialStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;

  const MobileOperacaoFormWidget({
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
  State<MobileOperacaoFormWidget> createState() => _MobileOperacaoFormWidgetState();
}

class _MobileOperacaoFormWidgetState extends State<MobileOperacaoFormWidget> {
  final formKey = GlobalKey<FormState>();

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
      translation.titles.adicionarOperacao,
      controller: CustomScaffoldController(),
      alignment: Alignment.centerLeft,
      closeIcon: Icon(FontAwesomeIcons.xmark, color: colorTheme?.text),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 690),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MobileOperacaoDadosBasicosFormWidget(
                  operacaoController: widget.operacaoController,
                  getUnidadeStore: widget.getUnidadeStore,
                  getCentroDeTrabalhoStore: widget.getCentroDeTrabalhoStore,
                  getProdutoStore: widget.getProdutoStore,
                  formKey: formKey,
                ),
                const SizedBox(height: 20),
                MobileOperacaoMaterialFormWidget(
                  operacaoController: widget.operacaoController,
                  getMaterialStore: widget.getMaterialStore,
                  getProdutoStore: widget.getProdutoStore,
                ),
                const SizedBox(height: 20),
                MobileOperacaoGrupoDeRecursoWidget(
                  operacaoController: widget.operacaoController,
                  getGrupoDeRecursoStore: widget.getGrupoDeRecursoStore,
                  getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
                  getUnidadeStore: widget.getUnidadeStore,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTextButton(
              title: widget.operacaoController.operacao == OperacaoAggregate.empty()
                  ? translation.fields.cancelar
                  : translation.fields.descartar,
              // isEnabled: !triple.isLoading,
              onPressed: () {
                // if (roteiroController.roteiro != RoteiroAggregate.empty()) {
                //   Asuka.showDialog(
                //     barrierColor: Colors.black38,
                //     builder: (context) {
                //       return ConfirmationModalWidget(
                //         title: translation.titles.descartarAlteracoes,
                //         messages: translation.messages.descatarAlteracoesCriacaoEntidade,
                //         titleCancel: translation.fields.descartar,
                //         titleSuccess: translation.fields.continuar,
                //         onCancel: () => Modular.to.pop(),
                //       );
                //     },
                //   );
                // } else {
                //   Modular.to.pop();
                // }
                widget.operacaoController.operacao = OperacaoAggregate.empty();
                Modular.to.pop(null);
              },
            ),
            const SizedBox(width: 10),
            CustomPrimaryButton(
              title: widget.operacaoController.operacao == OperacaoAggregate.empty()
                  ? translation.fields.adicionarOperacao
                  : translation.fields.salvar,
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }

                if (widget.operacaoController.operacao.gruposDeRecurso.isEmpty) {
                  NotificationSnackBar.showSnackBar(
                    translation.messages.mensagemAdicioneUmRecurso,
                    themeData: themeData,
                  );
                  return;
                }

                if (!widget.operacaoController.operacao.isValid) {
                  // TODO: Verificar esse cenario
                  NotificationSnackBar.showSnackBar(
                    'Não está valido',
                    themeData: themeData,
                  );
                  return;
                }

                Modular.to.pop(widget.operacaoController.operacao.copyWith());
              },
            ),
          ],
        ),
      ),
    );
  }
}
