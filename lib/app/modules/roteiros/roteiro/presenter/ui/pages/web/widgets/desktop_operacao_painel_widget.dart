// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/roteiro_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_material_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_form_widget.dart';

class DesktopOperacaoPanelWidget extends StatelessWidget {
  final RoteiroController roteiroController;
  final GetUnidadeStore getUnidadeStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetProdutoStore getProdutoStore;
  final GetMaterialStore getMaterialStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;

  const DesktopOperacaoPanelWidget({
    Key? key,
    required this.roteiroController,
    required this.getUnidadeStore,
    required this.getCentroDeTrabalhoStore,
    required this.getProdutoStore,
    required this.getMaterialStore,
    required this.getGrupoDeRecursoStore,
    required this.getGrupoDeRestricaoStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            translation.messages.mensagemAdicioneAsAperacoes,
            style: themeData.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          ReorderableList(
            shrinkWrap: true,
            itemCount: roteiroController.listOpercaoController.length,
            itemBuilder: (context, index) {
              final operacaoController = roteiroController.listOpercaoController[index];

              return _CardOperacaoWidget(
                key: ValueKey(index),
                index: index,
              );
            },
            onReorder: (oldIndex, newIndex) {},
          ),
          Center(
            child: CustomOutlinedButton(
              title: translation.fields.adicionarOperacao,
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return DesktopOperacaoFormWidget(
                      operacaoController: roteiroController.newOperacaoController,
                      getUnidadeStore: getUnidadeStore,
                      getCentroDeTrabalhoStore: getCentroDeTrabalhoStore,
                      getProdutoStore: getProdutoStore,
                      getMaterialStore: getMaterialStore,
                      getGrupoDeRecursoStore: getGrupoDeRecursoStore,
                      getGrupoDeRestricaoStore: getGrupoDeRestricaoStore,
                    );
                  },
                ).then((value) {});
              },
            ),
          )
        ],
      ),
    );
  }
}

class _CardOperacaoWidget extends StatelessWidget {
  final int index;
  // final OperacaoController operacaoController;

  const _CardOperacaoWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorTheme?.background,
            border: Border.all(
              color: colorTheme?.border ?? Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: Icon(
                  FontAwesomeIcons.gripVertical,
                  color: colorTheme?.icons,
                ),
              ),
              const SizedBox(width: 14),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '010 - Bater a massa',
                      style: themeData.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        TagWidget(
                          title: 'Centro 123',
                          sizeBorder: 1,
                        ),
                        const SizedBox(width: 10),
                        TagWidget(
                          title: '30m por lote',
                          sizeBorder: 1,
                        ),
                        const SizedBox(width: 10),
                        TagWidget(
                          title: '2 materiais',
                          sizeBorder: 1,
                          titleColor: colorTheme?.text,
                          borderColor: colorTheme?.text,
                        ),
                        const SizedBox(width: 10),
                        TagWidget(
                          title: '1 recurso apto',
                          sizeBorder: 1,
                          titleColor: colorTheme?.text,
                          borderColor: colorTheme?.text,
                        ),
                        const Spacer(),
                        CustomTextButton(
                          title: translation.fields.excluir,
                          textColor: colorTheme?.danger,
                          onPressed: () {},
                        ),
                        CustomTextButton(
                          title: translation.fields.editar,
                          textColor: colorTheme?.primary,
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
