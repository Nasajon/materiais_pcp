import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/unidades_list_store.dart';

class DesktopFichaTecnicaDadosGeraisFormWidget extends StatelessWidget {
  final FichaTecnicaFormController fichaTecnicaFormController;
  final ProdutoListStore produtoListStore;
  final UnidadeListStore unidadeListStore;
  final GlobalKey<FormState> formKey;

  const DesktopFichaTecnicaDadosGeraisFormWidget({
    Key? key,
    required this.fichaTecnicaFormController,
    required this.formKey,
    required this.produtoListStore,
    required this.unidadeListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = translation;

    return RxBuilder(builder: (context) {
      final fichaTecnica = fichaTecnicaFormController.fichaTecnica;

      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 635),
          padding: const EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: TextFormFieldWidget(
                        label: l10n.fields.codigo,
                        initialValue: fichaTecnica.codigo.value,
                        isRequiredField: true,
                        isEnabled: true,
                        validator: (_) => fichaTecnica.codigo.errorMessage,
                        onChanged: (value) {
                          fichaTecnicaFormController.fichaTecnica = fichaTecnica.copyWith(
                            codigo: TextVO(value),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      flex: 3,
                      child: AutocompleteTextFormField<ProdutoEntity>(
                        textFieldConfiguration: TextFieldConfiguration(decoration: InputDecoration(label: Text(l10n.fields.produto))),
                        initialSelectedValue: fichaTecnica.produto != ProdutoEntity.empty() ? fichaTecnica.produto : null,
                        itemTextValue: (value) => "${value.nome} - ${value.codigo}",
                        validator: (_) =>
                            fichaTecnica.produto != ProdutoEntity.empty() ? null : l10n.messages.selecioneUm(l10n.fields.produto),
                        itemBuilder: (context, produto) {
                          return ListTile(
                            title: Text("${produto.codigo} - ${produto.nome}"),
                          );
                        },
                        suggestionsCallback: (pattern) async {
                          await produtoListStore.getListProduto(search: pattern);
                          return produtoListStore.state;
                        },
                        onSelected: (value) {
                          fichaTecnicaFormController.fichaTecnica = fichaTecnica.copyWith(produto: value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: TextFormFieldWidget(
                        label: l10n.fields.descricao,
                        initialValue: fichaTecnica.descricao.value,
                        isRequiredField: true,
                        isEnabled: true,
                        validator: (_) => fichaTecnica.descricao.errorMessage,
                        onChanged: (value) {
                          fichaTecnicaFormController.fichaTecnica = fichaTecnica.copyWith(descricao: TextVO(value));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: DoubleTextFormFieldWidget(
                        label: l10n.fields.quantidadeDeProducao,
                        initialValue: fichaTecnica.quantidade.valueOrNull,
                        decimalDigits: fichaTecnica.unidade.decimais,
                        showSymbol: false,
                        isRequiredField: false,
                        isEnabled: true,
                        validator: (_) => fichaTecnica.quantidade.errorMessage,
                        onChanged: (value) {
                          fichaTecnicaFormController.fichaTecnica = fichaTecnica.copyWith(quantidade: DoubleVO(value));
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: AutocompleteTextFormField<UnidadeEntity>(
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(
                            label: Text(l10n.fields.tipoDeUnidade),
                          ),
                        ),
                        initialSelectedValue: fichaTecnica.unidade != UnidadeEntity.empty() ? fichaTecnica.unidade : null,
                        itemTextValue: (value) => "${value.nome} - ${value.codigo}",
                        validator: (_) => fichaTecnica.unidade != UnidadeEntity.empty() && fichaTecnica.unidade.isValid
                            ? null
                            : l10n.messages.selecioneUm(l10n.fields.tipoDeUnidade),
                        itemBuilder: (context, unidade) {
                          return ListTile(
                            title: Text("${unidade.nome} - ${unidade.codigo}"),
                          );
                        },
                        suggestionsCallback: (pattern) async {
                          await unidadeListStore.getListUnidade(search: pattern);
                          return unidadeListStore.state;
                        },
                        onSelected: (value) {
                          fichaTecnicaFormController.fichaTecnica = fichaTecnica.copyWith(unidade: value);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
