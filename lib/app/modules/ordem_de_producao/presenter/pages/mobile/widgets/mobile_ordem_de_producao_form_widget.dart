// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/cliente_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/enums/status_ordem_de_producao_enum.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/ordem_de_producao_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/mobile/widgets/mobile_operacao_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/widgets/prioridade_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_cliente_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_roteiro_store.dart';

class MobileOrdemDeProducaoFormWidget extends StatelessWidget {
  final OrdemDeProducaoController ordemDeProducaoController;
  final GetRoteiroStore getRoteiroStore;
  final GetProdutoStore getProdutoStore;
  final GetClienteStore getClienteStore;
  final GetOperacaoStore getOperacaoStore;
  final GlobalKey<FormState> formKey;
  final EdgeInsetsGeometry? padding;

  const MobileOrdemDeProducaoFormWidget({
    Key? key,
    required this.ordemDeProducaoController,
    required this.getRoteiroStore,
    required this.getProdutoStore,
    required this.getClienteStore,
    required this.getOperacaoStore,
    required this.formKey,
    this.padding = const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RxBuilder(builder: (context) {
      final ordemDeProducao = ordemDeProducaoController.ordemDeProducao;

      final isEnabledForm =
          ordemDeProducao.status == StatusOrdemDeProducaoEnum.aberta || ordemDeProducao.status == StatusOrdemDeProducaoEnum.aprovada;

      return SingleChildScrollView(
        padding: padding,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntegerTextFormFieldWidget(
                label: translation.fields.codigo,
                initialValue: ordemDeProducao.codigo.value,
                validator: (_) => ordemDeProducao.codigo.errorMessage,
                onChanged: (value) {
                  ordemDeProducaoController.ordemDeProducao = ordemDeProducao.copyWith(codigo: CodigoVO(value));
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
                  return await getProdutoStore.getListProdutos(search: pattern);
                },
                suggestionsForNextPageCallback: (pattern, lastObject) async {
                  return await getProdutoStore.getListProdutosProximaPagina(search: pattern, ultimoId: lastObject.id);
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
                  ordemDeProducaoController.ordemDeProducao = ordemDeProducao.copyWith(
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
                      ? await getRoteiroStore.getListRoteiros(
                          produtoId: ordemDeProducao.produto.id,
                          search: pattern,
                        )
                      : [];
                },
                suggestionsForNextPageCallback: (pattern, lastObject) async {
                  return await getRoteiroStore.getListRoteirosProximaPage(
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
                    getOperacaoStore.getList([roteiro.id]);
                  }

                  ordemDeProducaoController.ordemDeProducao = ordemDeProducao.copyWith(roteiro: roteiro ?? RoteiroEntity.empty());
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
                  return await getClienteStore.getListClientes(search: pattern);
                },
                suggestionsForNextPageCallback: (pattern, lastObject) async {
                  return await getClienteStore.getListClientesProximaPagina(search: pattern, ultimoId: lastObject.id);
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
                  ordemDeProducaoController.ordemDeProducao = ordemDeProducao.copyWith(cliente: cliente ?? ClienteEntity.empty());
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
                  ordemDeProducaoController.ordemDeProducao = ordemDeProducao.copyWith(quantidade: DoubleVO(value));
                },
              ),
              const SizedBox(height: 16),
              DateTextFormFieldWidget(
                label: translation.fields.periodoDeEntrega,
                initialValue: ordemDeProducao.previsaoDeEntrega.getDate(),
                validator: (_) => ordemDeProducao.previsaoDeEntrega.errorMessage,
                onChanged: (value) {
                  ordemDeProducaoController.ordemDeProducao = ordemDeProducao.copyWith(
                    previsaoDeEntrega: value != null ? DateVO.date(value) : DateVO(''),
                  );
                },
              ),
              const SizedBox(height: 16),
              PrioridadeWidget(
                ordemDeProducaoController: ordemDeProducaoController,
                isEnabledForm: isEnabledForm,
              ),
              const SizedBox(height: 16),
              MobileOperacaoWidget(getOperacaoStore: getOperacaoStore)
            ],
          ),
        ),
      );
    });
  }
}
