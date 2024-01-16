// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showDialog;
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/grupo_de_restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/controllers/grupo_de_restricao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/controllers/recurso_controller.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/mobile/widgets/mobile_operacao_adicionar_grupo_de_restriao_widget.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/mobile/widgets/mobile_operacao_restricao_widget.dart';

class MobileOperacaoGrupoDeRescricaoWidget extends StatelessWidget {
  final RecursoController recursoController;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetUnidadeStore getUnidadeStore;

  const MobileOperacaoGrupoDeRescricaoWidget({
    Key? key,
    required this.recursoController,
    required this.getGrupoDeRestricaoStore,
    required this.getUnidadeStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              translation.titles.grupoDeRestricoes,
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),
            if (recursoController.listGrupoDeRestricaoController.isNotEmpty)
              ...recursoController.listGrupoDeRestricaoController
                  .map(
                    (controller) => ExpansionGrupoDeRescricaoWidget(
                      recursoController: recursoController,
                      grupoDeRestricaoController: controller,
                      getGrupoDeRestricaoStore: getGrupoDeRestricaoStore,
                      getUnidadeStore: getUnidadeStore,
                    ),
                  )
                  .toList()
            else
              Center(
                child: Column(
                  children: [
                    Text(
                      translation.titles.semRestricoes,
                      style: themeData.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      translation.messages.mensagemAdicioneUmaOuMaisRestricoes,
                      style: themeData.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class ExpansionGrupoDeRescricaoWidget extends StatefulWidget {
  final RecursoController recursoController;
  final GrupoDeRestricaoController grupoDeRestricaoController;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetUnidadeStore getUnidadeStore;

  const ExpansionGrupoDeRescricaoWidget({
    Key? key,
    required this.recursoController,
    required this.grupoDeRestricaoController,
    required this.getGrupoDeRestricaoStore,
    required this.getUnidadeStore,
  }) : super(key: key);

  @override
  State<ExpansionGrupoDeRescricaoWidget> createState() => _ExpansionGrupoDeRescricaoWidgetState();
}

class _ExpansionGrupoDeRescricaoWidgetState extends State<ExpansionGrupoDeRescricaoWidget> {
  Future<bool> deletarGrupoDeRestricao(String grupoId) async {
    final response = await showDialog(
      context: context,
      builder: (context) {
        return ConfirmationModalWidget(
          title: translation.titles.removerEntidade(translation.fields.grupoDeRestricoes),
          titleCancel: translation.fields.remover,
          titleSuccess: translation.fields.cancelar,
          messages: translation.messages.mensagemRemoverEntidade(translation.fields.grupoDeRestricoes),
          onCancel: () {
            widget.recursoController.deletarGrupoDeRestricao(grupoId);
            setState(() {});
          },
        );
      },
    );

    if (response is bool) {
      return response;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [widget.grupoDeRestricaoController.grupoDeRestricao]);

    final grupoDeRestricao = widget.grupoDeRestricaoController.grupoDeRestricao;

    // Usar 250w, 10 minutos durante a operação
    var textoDaTag = '';
    // Usar
    textoDaTag += '${translation.fields.usar} ';
    // 250
    textoDaTag += grupoDeRestricao.capacidade.usar.formatDoubleToString(decimalDigits: grupoDeRestricao.capacidade.unidade.decimal);
    // w,
    textoDaTag += '${grupoDeRestricao.capacidade.unidade.codigo.toLowerCase()}, ';
    // 10 minutos
    textoDaTag += '${grupoDeRestricao.capacidade.tempo.formatDuration()} ';
    // durante a operação
    textoDaTag += grupoDeRestricao.quando?.name.toLowerCase() ?? '';

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
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(grupoDeRestricao.grupo.nome),
                const SizedBox(height: 8),
                TagWidget(
                  title: textoDaTag,
                  titleColor: colorTheme?.text,
                  borderColor: colorTheme?.text,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          PopupMenuButton(
            splashRadius: 20,
            icon: Icon(
              FontAwesomeIcons.ellipsisVertical,
              size: 18,
              color: colorTheme?.icons ?? Colors.transparent,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  value: translation.fields.editar,
                  child: Text(translation.fields.editar),
                ),
                PopupMenuItem<String>(
                  value: translation.fields.remover,
                  child: Text(translation.fields.remover),
                ),
              ];
            },
            onSelected: (value) async {
              if (value == translation.fields.editar) {
                final responseModal = await showDialog(
                  context: context,
                  builder: (context) {
                    return MobileOperacaoAdicionarGrupoDeRestricaoWidget(
                      grupoDeRestricaoController: widget.grupoDeRestricaoController,
                      getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
                      getUnidadeStore: widget.getUnidadeStore,
                      listaDeIdsDosGruposParaDeletar: [],
                      removerGrupoDeRestricao: () async {
                        final response = await deletarGrupoDeRestricao(grupoDeRestricao.grupo.id);
                        if (!response) {
                          Navigator.of(context).pop(null);
                        }
                      },
                    );
                  },
                );

                if (responseModal != null &&
                    responseModal is GrupoDeRestricaoController &&
                    responseModal.grupoDeRestricao != GrupoDeRestricaoAggregate.empty()) {
                  widget.recursoController.editarGrupoDeRestricao(responseModal.grupoDeRestricao);
                  setState(() {});
                }
              } else if (value == translation.fields.remover) {
                await deletarGrupoDeRestricao(grupoDeRestricao.grupo.id);
              }
            },
          ),
        ],
      ),
      children: [
        Divider(color: colorTheme?.border, height: 1),
        ...widget.grupoDeRestricaoController.listRestricaoController
            .map(
              (restricaoController) => MobileOperacaoRestricaoWidget(
                grupoRestricaoId: widget.grupoDeRestricaoController.grupoDeRestricao.grupo.id,
                recursoController: widget.recursoController,
                restricaoController: restricaoController,
                unidade: grupoDeRestricao.capacidade.unidade,
              ),
            )
            .toList(),
      ],
    );
  }
}
