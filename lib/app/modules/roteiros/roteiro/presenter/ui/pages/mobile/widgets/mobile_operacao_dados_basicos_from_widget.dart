// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/roteiro_medicao_tempo_enum.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/operacao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';

class MobileOperacaoDadosBasicosFormWidget extends StatelessWidget {
  final OperacaoController operacaoController;
  final GetUnidadeStore getUnidadeStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetProdutoStore getProdutoStore;
  final GlobalKey<FormState> formKey;

  const MobileOperacaoDadosBasicosFormWidget({
    Key? key,
    required this.operacaoController,
    required this.getUnidadeStore,
    required this.getCentroDeTrabalhoStore,
    required this.getProdutoStore,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [operacaoController.operacao]);

    final operacao = operacaoController.operacao;

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
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translation.titles.dadosBasicos,
                    style: themeData.textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormFieldWidget(
                    label: translation.fields.nome,
                    initialValue: operacao.nome.value,
                    validator: (_) => operacao.nome.errorMessage,
                    onChanged: (value) {
                      operacaoController.operacao = operacao.copyWith(nome: TextVO(value));
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: AutocompleteTextFormField<UnidadeEntity>(
                          initialSelectedValue: operacao.unidade != UnidadeEntity.empty() ? operacao.unidade : null,
                          itemTextValue: (value) => '${value.descricao} - ${value.codigo}',
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
                            if (operacao.unidade == UnidadeEntity.empty()) {
                              return translation.messages.errorCampoObrigatorio;
                            }
                            return null;
                          },
                          onSelected: (unidade) {
                            operacaoController.operacao = operacao.copyWith(unidade: unidade ?? UnidadeEntity.empty());
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: DoubleTextFormFieldWidget(
                          label: translation.fields.razaoDeConversao,
                          initialValue: operacao.razaoConversao.valueOrNull,
                          validator: (_) => operacao.razaoConversao.errorMessage,
                          onValueOrNull: (value) {
                            operacaoController.operacao = operacao.copyWith(razaoConversao: DoubleVO(value));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonWidget<RoteiroMedicaoTempoEnum>(
                    label: translation.fields.medicaoDeTempo,
                    value: operacao.medicaoTempo,
                    isRequiredField: true,
                    errorMessage: translation.messages.errorCampoObrigatorio,
                    isEnabled: true,
                    items: RoteiroMedicaoTempoEnum.values
                        .map((medicaoTempo) => DropdownItem(value: medicaoTempo, label: medicaoTempo.name))
                        .toList(),
                    onSelected: (value) {
                      operacaoController.operacao = operacao.copyWith(medicaoTempo: value);
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: TimeTextFormFieldWidget(
                          label: translation.fields.preparacao,
                          initTime: operacao.preparacao.getTime(),
                          validator: (_) => operacao.preparacao.errorMessage,
                          onChanged: (value) {
                            if (value != null) {
                              operacaoController.operacao = operacao.copyWith(preparacao: TimeVO.time(value));
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: TimeTextFormFieldWidget(
                          label: translation.fields.execucao,
                          initTime: operacao.execucao.getTime(),
                          validator: (_) => operacao.execucao.errorMessage,
                          onChanged: (value) {
                            if (value != null) {
                              operacaoController.operacao = operacao.copyWith(execucao: TimeVO.time(value));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: AutocompleteTextFormField<CentroDeTrabalhoEntity>(
                          initialSelectedValue:
                              operacao.centroDeTrabalho != CentroDeTrabalhoEntity.empty() ? operacao.centroDeTrabalho : null,
                          itemTextValue: (value) => value.nome,
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: InputDecoration(
                              labelText: translation.fields.centroDeTrabalho,
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return await getCentroDeTrabalhoStore.getListCentroDeTrabalho(search: pattern);
                          },
                          itemBuilder: (context, centroDeTrabalho) {
                            return ListTile(
                              title: Text('${centroDeTrabalho.codigo} - ${centroDeTrabalho.nome}'),
                            );
                          },
                          errorBuilder: (context, error) {
                            return Text(error.toString());
                          },
                          validator: (value) {
                            if (operacao.centroDeTrabalho == CentroDeTrabalhoEntity.empty()) {
                              return translation.messages.errorCampoObrigatorio;
                            }
                            return null;
                          },
                          onSelected: (centroDeTrabalho) {
                            operacaoController.operacao =
                                operacao.copyWith(centroDeTrabalho: centroDeTrabalho ?? CentroDeTrabalhoEntity.empty());
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: AutocompleteTextFormField<ProdutoEntity>(
                          initialSelectedValue: operacao.produtoResultante,
                          itemTextValue: (value) => value.nome,
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: InputDecoration(
                              labelText: translation.fields.produtoResultante,
                              helperText: translation.fields.opcional,
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return await getProdutoStore.getListProdutos(search: pattern);
                          },
                          itemBuilder: (context, produtoResultante) {
                            return ListTile(
                              title: Text('${produtoResultante.codigo} - ${produtoResultante.nome}'),
                            );
                          },
                          errorBuilder: (context, error) {
                            return Text(error.toString());
                          },
                          onSelected: (produtoResultante) {
                            operacaoController.operacao = operacao.copyWith(produtoResultante: produtoResultante);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
