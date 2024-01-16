// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/controllers/operacao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/controllers/roteiro_controller.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_material_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_unidade_store.dart';

class DesktopOperacaoPanelWidget extends StatefulWidget {
  final RoteiroController roteiroController;
  final GetUnidadeStore getUnidadeStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetProdutoStore getProdutoStore;
  final GetMaterialStore getMaterialStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final OperacaoController operacaoController;

  const DesktopOperacaoPanelWidget({
    Key? key,
    required this.roteiroController,
    required this.getUnidadeStore,
    required this.getCentroDeTrabalhoStore,
    required this.getProdutoStore,
    required this.getMaterialStore,
    required this.getGrupoDeRecursoStore,
    required this.getGrupoDeRestricaoStore,
    required this.operacaoController,
  }) : super(key: key);

  @override
  State<DesktopOperacaoPanelWidget> createState() => _DesktopOperacaoPanelWidgetState();
}

class _DesktopOperacaoPanelWidgetState extends State<DesktopOperacaoPanelWidget> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 12),
      child: RxBuilder(
        builder: (context) {
          return Column(
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
                itemCount: widget.roteiroController.roteiro.operacoes.length,
                itemBuilder: (context, index) {
                  final operacao = widget.roteiroController.roteiro.operacoes[index];

                  return _CardOperacaoWidget(
                    key: ValueKey(index),
                    index: index,
                    operacao: operacao,
                    operacaoController: widget.operacaoController,
                    roteiroController: widget.roteiroController,
                  );
                },
                onReorder: (oldIndex, newIndex) => widget.roteiroController.setaOrdemOperacao(oldIndex: oldIndex, newIndex: newIndex),
              ),
              Center(
                child: CustomOutlinedButton(
                  title: translation.fields.adicionarOperacao,
                  onPressed: () async {
                    widget.operacaoController.fichaTecnicaId = widget.roteiroController.roteiro.fichaTecnica.id;
                    widget.operacaoController.operacao = OperacaoAggregate.empty();
                    widget.operacaoController.materiais = widget.roteiroController.getMateriais();

                    var response = await Modular.to.pushNamed('./operacao');

                    if (response != null && response is OperacaoAggregate && response != OperacaoAggregate.empty()) {
                      response = response.copyWith(ordem: widget.roteiroController.roteiro.operacoes.length + 1);

                      final operacoes = widget.roteiroController.roteiro.operacoes;

                      operacoes.add(response);

                      widget.roteiroController.roteiro = widget.roteiroController.roteiro.copyWith(operacoes: operacoes);
                      setState(() {});
                    }
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class _CardOperacaoWidget extends StatelessWidget {
  final int index;
  final OperacaoAggregate operacao;
  final OperacaoController operacaoController;
  final RoteiroController roteiroController;

  const _CardOperacaoWidget({
    Key? key,
    required this.index,
    required this.operacao,
    required this.operacaoController,
    required this.roteiroController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();
    var quantidadeRecursos = 0;

    operacao.gruposDeRecurso.forEach((grupo) {
      quantidadeRecursos += grupo.recursos.length;
    });

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
                      '${operacao.ordem} - ${operacao.nome}',
                      style: themeData.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        TagWidget(
                          title: operacao.centroDeTrabalho.nome,
                          sizeBorder: 1,
                        ),
                        const SizedBox(width: 10),
                        TagWidget(
                          title: '${operacao.execucao.timeFormatToStringWithoutSeconds()} ${operacao.medicaoTempo?.name ?? ''}',
                          sizeBorder: 1,
                        ),
                        const SizedBox(width: 10),
                        TagWidget(
                          title:
                              '${operacao.materiais.length} ${operacao.materiais.length == 1 ? translation.fields.material.toLowerCase() : translation.fields.materiais.toLowerCase()}',
                          sizeBorder: 1,
                          titleColor: colorTheme?.text,
                          borderColor: colorTheme?.text,
                        ),
                        const SizedBox(width: 10),
                        TagWidget(
                          title:
                              '$quantidadeRecursos ${quantidadeRecursos == 1 ? translation.fields.recursoApto.toLowerCase() : translation.fields.recursosAptos.toLowerCase()}',
                          sizeBorder: 1,
                          titleColor: colorTheme?.text,
                          borderColor: colorTheme?.text,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: colorTheme?.icons,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text(translation.fields.editar),
                      onTap: () async {
                        // operacaoController.fichaTecnicaId = roteiroController.roteiro.fichaTecnica.id;
                        operacaoController.operacao = operacao;
                        operacaoController.fichaTecnicaId = roteiroController.roteiro.fichaTecnica.id;
                        operacaoController.materiais = roteiroController.getMateriais(operacao.ordem);

                        final response = await Modular.to.pushNamed('./operacao');

                        if (response != null && response is OperacaoAggregate) {
                          final operacoes = roteiroController.roteiro.operacoes;
                          final index = operacoes.indexWhere((element) => element.ordem == operacao.ordem);
                          operacoes.setAll(index, [response]);
                          roteiroController.roteiro = roteiroController.roteiro.copyWith(operacoes: operacoes);
                        }
                      },
                    ),
                    PopupMenuItem(
                      child: Text(translation.fields.excluir),
                      onTap: () => roteiroController.removerOperacao(operacao.ordem),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
