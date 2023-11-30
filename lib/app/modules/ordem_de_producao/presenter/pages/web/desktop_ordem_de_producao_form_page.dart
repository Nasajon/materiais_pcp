// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/ordem_de_producao_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_ordem_de_producao_form_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_cliente_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_ordem_de_producao_por_id_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/inserir_editar_ordem_de_producao_store.dart';

class DesktopOrdemDeProducaoFormPage extends StatefulWidget {
  final ValueNotifier<OrdemDeProducaoAggregate?> ordemDeProducaoOld;
  final InserirEditarOrdemDeProducaoStore inserirEditarOrdemDeProducaoStore;
  final GetOrdemDeProducaoPorIdStore getOrdemDeProducaoPorIdStore;
  final GetProdutoStore getProdutoStore;
  final GetRoteiroStore getRoteiroStore;
  final GetClienteStore getClienteStore;
  final GetOperacaoStore getOperacaoStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;
  final OrdemDeProducaoController ordemDeProducaoController;
  final GlobalKey<FormState> formKey;

  const DesktopOrdemDeProducaoFormPage({
    Key? key,
    required this.ordemDeProducaoOld,
    required this.inserirEditarOrdemDeProducaoStore,
    required this.getOrdemDeProducaoPorIdStore,
    required this.getProdutoStore,
    required this.getRoteiroStore,
    required this.getClienteStore,
    required this.getOperacaoStore,
    required this.connectionStore,
    required this.scaffoldController,
    required this.ordemDeProducaoController,
    required this.formKey,
  }) : super(key: key);

  @override
  State<DesktopOrdemDeProducaoFormPage> createState() => _DesktopOrdemDeProducaoFormPageState();
}

class _DesktopOrdemDeProducaoFormPageState extends State<DesktopOrdemDeProducaoFormPage> {
  @override
  void initState() {
    super.initState();

    if (widget.ordemDeProducaoOld.value != null) {
      widget.getOperacaoStore.getList(widget.ordemDeProducaoController.ordemDeProducao.roteiro.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(builder: (context) {
      final ordemDeProducao = widget.ordemDeProducaoController.ordemDeProducao;
      return CustomScaffold.titleString(
        widget.ordemDeProducaoOld.value == null
            ? translation.titles.criarEntidade(translation.fields.ordemDeProducao)
            : '${translation.fields.ordemDeProducao} ${translation.fields.codigo.toLowerCase()} ${widget.ordemDeProducaoOld.value!.codigo.toText}',
        controller: widget.scaffoldController,
        alignment: Alignment.centerLeft,
        body: DesktopOrdemDeProducaoFormWidget(
          ordemDeProducaoController: widget.ordemDeProducaoController,
          getRoteiroStore: widget.getRoteiroStore,
          getProdutoStore: widget.getProdutoStore,
          getClienteStore: widget.getClienteStore,
          getOperacaoStore: widget.getOperacaoStore,
          formKey: widget.formKey,
          padding: const EdgeInsets.symmetric(vertical: 48),
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: widget.ordemDeProducaoOld,
          builder: (context, oldOrdemDeProducao, child) {
            return Visibility(
              visible: oldOrdemDeProducao == null || (ordemDeProducao.id.isNotEmpty && oldOrdemDeProducao != ordemDeProducao),
              child: ContainerNavigationBarWidget(
                child: TripleBuilder<InserirEditarOrdemDeProducaoStore, OrdemDeProducaoAggregate>(
                  store: widget.inserirEditarOrdemDeProducaoStore,
                  builder: (context, triple) {
                    final id = widget.ordemDeProducaoController.ordemDeProducao.id;

                    final error = triple.error;
                    if (!triple.isLoading && error != null && error is Failure) {
                      Asuka.showDialog(
                        barrierColor: Colors.black38,
                        builder: (context) {
                          return ErrorModal(errorMessage: (triple.error as Failure).errorMessage ?? '');
                        },
                      );
                    }

                    final ordemDeProducao = triple.state;
                    if (ordemDeProducao != OrdemDeProducaoAggregate.empty() && !triple.isLoading && ordemDeProducao != oldOrdemDeProducao) {
                      Asuka.showSnackBar(
                        SnackBar(
                          content: Text(
                            id.isEmpty
                                ? translation.messages.criouAEntidadeComSucesso(translation.fields.ordemDeProducao)
                                : translation.messages.editouAEntidadeComSucesso(translation.fields.ordemDeProducao),
                            style: AnaTextStyles.grey14Px.copyWith(fontSize: 15, color: Colors.white, letterSpacing: 0.25),
                          ),
                          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.87),
                          behavior: SnackBarBehavior.floating,
                          width: 635,
                        ),
                      );

                      if (id.isEmpty) {
                        Modular.to.pop();
                      } else {
                        widget.ordemDeProducaoController.ordemDeProducao = ordemDeProducao;
                        widget.ordemDeProducaoOld.value = widget.ordemDeProducaoController.ordemDeProducao.copyWith();
                      }
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextButton(
                          title: id.isEmpty ? translation.fields.cancelar : translation.fields.descartar,
                          isEnabled: !triple.isLoading,
                          onPressed: () {
                            if ((oldOrdemDeProducao != null && oldOrdemDeProducao != widget.ordemDeProducaoController.ordemDeProducao) ||
                                (widget.ordemDeProducaoController.ordemDeProducao != OrdemDeProducaoAggregate.empty())) {
                              Asuka.showDialog(
                                barrierColor: Colors.black38,
                                builder: (context) {
                                  return ConfirmationModalWidget(
                                    title: translation.titles.descartarAlteracoes,
                                    messages: translation.messages.descatarAlteracoesCriacaoEntidade,
                                    titleCancel: translation.fields.descartar,
                                    titleSuccess: translation.fields.continuar,
                                    onCancel: () => Modular.to.pop(),
                                  );
                                },
                              );
                            } else {
                              Modular.to.pop();
                            }
                          },
                        ),
                        const SizedBox(width: 10),
                        CustomPrimaryButton(
                          title: oldOrdemDeProducao != null ? translation.fields.salvar : translation.fields.criarOrdem,
                          isLoading: triple.isLoading,
                          onPressed: () async {
                            if (widget.formKey.currentState!.validate()) {
                              if (widget.ordemDeProducaoOld.value != null) {
                                widget.inserirEditarOrdemDeProducaoStore.atualizar(widget.ordemDeProducaoController.ordemDeProducao);
                              } else {
                                widget.inserirEditarOrdemDeProducaoStore.inserir(widget.ordemDeProducaoController.ordemDeProducao);
                              }
                            }
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
