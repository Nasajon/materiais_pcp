// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/ficha_tecnica_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/roteiro_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';

class DesktopDadosBasicosFormWidget extends StatelessWidget {
  final RoteiroController roteiroController;
  final GetProdutoStore getProdutoStore;
  final GetFichaTecnicaStore getFichaTecnicaStore;
  final GetUnidadeStore getUnidadeStore;
  final GlobalKey<FormState> formKey;

  const DesktopDadosBasicosFormWidget({
    Key? key,
    required this.roteiroController,
    required this.getProdutoStore,
    required this.getFichaTecnicaStore,
    required this.getUnidadeStore,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    context.select(() => [roteiroController.roteiro]);
    final roteiro = roteiroController.roteiro;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            translation.messages.mensagemComoCriarRoteiro,
            style: themeData.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: IntegerTextFormFieldWidget(
                  label: translation.fields.codigo,
                  initialValue: roteiro.codigo.value,
                  validator: (_) => roteiro.codigo.errorMessage,
                  onChanged: (value) {
                    roteiroController.roteiro = roteiro.copyWith(codigo: CodigoVO(value));
                  },
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                flex: 4,
                child: AutocompleteTextFormField<ProdutoEntity>(
                  key: ValueKey(roteiro.produto),
                  initialValue: roteiro.produto != ProdutoEntity.empty() ? '${roteiro.produto.codigo} - ${roteiro.produto.nome}' : null,
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                      labelText: translation.fields.produto,
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await getProdutoStore.getListProdutos(search: pattern);
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
                    if (roteiro.produto == ProdutoEntity.empty()) {
                      return translation.messages.errorCampoObrigatorio;
                    }
                  },
                  onSelected: (produto) {
                    roteiroController.roteiro = roteiro.copyWith(produto: produto);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormFieldWidget(
            label: translation.fields.descricao,
            initialValue: roteiro.descricao.value,
            validator: (_) => roteiro.descricao.errorMessage,
            onChanged: (value) {
              roteiroController.roteiro = roteiro.copyWith(descricao: TextVO(value));
            },
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: AutocompleteTextFormField<FichaTecnicaEntity>(
                  key: ValueKey(roteiro.fichaTecnica),
                  initialValue: roteiro.fichaTecnica != FichaTecnicaEntity.empty()
                      ? '${roteiro.fichaTecnica.codigo} - ${roteiro.fichaTecnica.descricao}'
                      : null,
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                      labelText: translation.fields.fichaTecnica,
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await getFichaTecnicaStore.getListFichaTecnica(search: pattern);
                  },
                  itemBuilder: (context, fichaTecnica) {
                    return ListTile(
                      title: Text('${fichaTecnica.codigo} - ${fichaTecnica.descricao}'),
                    );
                  },
                  errorBuilder: (context, error) {
                    return Text(error.toString());
                  },
                  validator: (value) {
                    if (roteiro.fichaTecnica == FichaTecnicaEntity.empty()) {
                      return translation.messages.errorCampoObrigatorio;
                    }
                  },
                  onSelected: (fichaTecnica) {
                    roteiroController.roteiro = roteiro.copyWith(fichaTecnica: fichaTecnica);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: AutocompleteTextFormField<UnidadeEntity>(
                  key: ValueKey(roteiro.unidade),
                  initialValue:
                      roteiro.unidade != UnidadeEntity.empty() ? '${roteiro.unidade.codigo} - ${roteiro.unidade.descricao}' : null,
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                      labelText: translation.fields.unidadeDeMedida,
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await getUnidadeStore.getListUnidade(search: pattern);
                  },
                  itemBuilder: (context, unidade) {
                    return ListTile(
                      title: Text('${unidade.codigo} - ${unidade.descricao}'),
                    );
                  },
                  errorBuilder: (context, error) {
                    return Text(error.toString());
                  },
                  validator: (value) {
                    if (roteiro.unidade == UnidadeEntity.empty()) {
                      return translation.messages.errorCampoObrigatorio;
                    }
                  },
                  onSelected: (unidade) {
                    roteiroController.roteiro = roteiro.copyWith(unidade: unidade);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormFieldWidget(
            label: translation.fields.observacoes,
            initialValue: roteiro.observacao,
            maxLines: 5,
            onChanged: (value) {
              roteiroController.roteiro = roteiro.copyWith(observacao: value);
            },
          ),
        ],
      ),
    );
  }
}
