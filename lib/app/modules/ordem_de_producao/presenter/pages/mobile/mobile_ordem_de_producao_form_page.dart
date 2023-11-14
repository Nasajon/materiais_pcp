// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/cliente_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/ordem_de_producao_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/mobile/widgets/mobile_operacao_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/widgets/prioridade_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_cliente_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_ordem_de_producao_por_id_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/inserir_editar_ordem_de_producao_store.dart';

class MobileOrdemDeProducaoFormPage extends StatefulWidget {
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

  const MobileOrdemDeProducaoFormPage({
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
  State<MobileOrdemDeProducaoFormPage> createState() => _MobileOrdemDeProducaoFormPageState();
}

class _MobileOrdemDeProducaoFormPageState extends State<MobileOrdemDeProducaoFormPage> {
  @override
  void initState() {
    super.initState();

    if (widget.ordemDeProducaoOld.value != null) {
      widget.getOperacaoStore.getList(widget.ordemDeProducaoController.ordemDeProducao.roteiro.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final [ordemDeProducao] = context.select(() => [widget.ordemDeProducaoController.ordemDeProducao]);

    return CustomScaffold.titleString(
      widget.ordemDeProducaoOld.value == null
          ? translation.titles.criarEntidade(translation.fields.ordemDeProducao)
          : '${translation.fields.ordemDeProducao} ${translation.fields.codigo.toLowerCase()} ${widget.ordemDeProducaoOld.value!.codigo.toText}',
      controller: widget.scaffoldController,
      alignment: Alignment.centerLeft,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: Form(
          key: widget.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntegerTextFormFieldWidget(
                label: translation.fields.codigo,
                initialValue: ordemDeProducao.codigo.value,
                validator: (_) => ordemDeProducao.codigo.errorMessage,
                onChanged: (value) {
                  widget.ordemDeProducaoController.ordemDeProducao = ordemDeProducao.copyWith(codigo: CodigoVO(value));
                },
              ),
              const SizedBox(height: 16),
              AutocompleteTextFormField<ProdutoEntity>(
                initialSelectedValue: ordemDeProducao.produto != ProdutoEntity.empty() ? ordemDeProducao.produto : null,
                itemTextValue: (value) => value.nome,
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    labelText: translation.fields.produto,
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  return await widget.getProdutoStore.getListProdutos(search: pattern);
                },
                suggestionsForNextPageCallback: (pattern, lastObject) async {
                  return await widget.getProdutoStore.getListProdutosProximaPagina(search: pattern, ultimoId: lastObject.id);
                },
                itemBuilder: (context, produto) {
                  return ListTile(
                    title: Text('${produto.codigo} - ${produto.nome}'),
                  );
                },
                errorBuilder: (context, error) {
                  return Text(error.toString());
                },
                validator: (value) {
                  if (ordemDeProducao.produto == ProdutoEntity.empty()) {
                    return translation.messages.errorCampoObrigatorio;
                  }

                  return null;
                },
                onSelected: (produto) {
                  widget.ordemDeProducaoController.ordemDeProducao = ordemDeProducao.copyWith(
                    roteiro: produto != ordemDeProducao.produto ? RoteiroEntity.empty() : null,
                    produto: produto ?? ProdutoEntity.empty(),
                  );
                },
              ),
              const SizedBox(height: 16),
              AutocompleteTextFormField<RoteiroEntity>(
                key: ValueKey(ordemDeProducao.produto),
                initialSelectedValue: ordemDeProducao.roteiro != RoteiroEntity.empty() ? ordemDeProducao.roteiro : null,
                itemTextValue: (value) => value.nome,
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    labelText: translation.fields.roteiro,
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  return ordemDeProducao.produto.id.isNotEmpty
                      ? await widget.getRoteiroStore.getListRoteiros(
                          produtoId: ordemDeProducao.produto.id,
                          search: pattern,
                        )
                      : [];
                },
                suggestionsForNextPageCallback: (pattern, lastObject) async {
                  return await widget.getRoteiroStore.getListRoteirosProximaPage(
                    produtoId: ordemDeProducao.produto.id,
                    search: pattern,
                    ultimoId: lastObject.id,
                  );
                },
                itemBuilder: (context, roteiro) {
                  return ListTile(
                    title: Text('${roteiro.codigo} - ${roteiro.nome}'),
                  );
                },
                errorBuilder: (context, error) {
                  return Text(error.toString());
                },
                validator: (value) {
                  if (ordemDeProducao.roteiro == RoteiroEntity.empty()) {
                    return translation.messages.errorCampoObrigatorio;
                  }

                  return null;
                },
                onSelected: (roteiro) {
                  if (roteiro != null && roteiro != ordemDeProducao.roteiro) {
                    widget.getOperacaoStore.getList(roteiro.id);
                  }

                  widget.ordemDeProducaoController.ordemDeProducao = ordemDeProducao.copyWith(roteiro: roteiro ?? RoteiroEntity.empty());
                },
              ),
              const SizedBox(height: 16),
              AutocompleteTextFormField<ClienteEntity>(
                initialSelectedValue: ordemDeProducao.cliente != ClienteEntity.empty() ? ordemDeProducao.cliente : null,
                itemTextValue: (value) => value.nome,
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    labelText: translation.fields.cliente,
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  return await widget.getClienteStore.getListClientes(search: pattern);
                },
                suggestionsForNextPageCallback: (pattern, lastObject) async {
                  return await widget.getClienteStore.getListClientesProximaPagina(search: pattern, ultimoId: lastObject.id);
                },
                itemBuilder: (context, cliente) {
                  return ListTile(
                    title: Text('${cliente.codigo} - ${cliente.nome}'),
                  );
                },
                errorBuilder: (context, error) {
                  return Text(error.toString());
                },
                onSelected: (cliente) {
                  widget.ordemDeProducaoController.ordemDeProducao = ordemDeProducao.copyWith(cliente: cliente ?? ClienteEntity.empty());
                },
              ),
              const SizedBox(height: 16),
              DoubleTextFormFieldWidget(
                label: translation.fields.quantidade,
                initialValue: ordemDeProducao.quantidade.valueOrNull,
                suffixSymbol: ordemDeProducao.roteiro.unidade.nome,
                decimalDigits: ordemDeProducao.roteiro.unidade.decimal,
                validator: (_) => ordemDeProducao.quantidade.errorMessage,
                onValueOrNull: (value) {
                  widget.ordemDeProducaoController.ordemDeProducao = ordemDeProducao.copyWith(quantidade: DoubleVO(value));
                },
              ),
              const SizedBox(height: 16),
              DateTextFormFieldWidget(
                label: translation.fields.periodoDeEntrega,
                initialValue: ordemDeProducao.previsaoDeEntrega.getDate(),
                validator: (_) => ordemDeProducao.previsaoDeEntrega.errorMessage,
                onChanged: (value) {
                  widget.ordemDeProducaoController.ordemDeProducao = ordemDeProducao.copyWith(
                    previsaoDeEntrega: value != null ? DateVO.date(value) : DateVO(''),
                  );
                },
              ),
              const SizedBox(height: 16),
              PrioridadeWidget(ordemDeProducaoController: widget.ordemDeProducaoController),
              const SizedBox(height: 16),
              MobileOperacaoWidget(getOperacaoStore: widget.getOperacaoStore)
            ],
          ),
        ),
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
  }
}
