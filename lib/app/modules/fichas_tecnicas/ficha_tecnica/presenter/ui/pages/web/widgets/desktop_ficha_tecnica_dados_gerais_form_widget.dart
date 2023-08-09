import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/enums/artigo.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/unidades_list_store.dart';

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
                        initialValue: fichaTecnicaFormController.fichaTecnica.codigo.value,
                        isRequiredField: true,
                        isEnabled: true,
                        validator: (_) => fichaTecnicaFormController.fichaTecnica.codigo.errorMessage,
                        onChanged: (value) {
                          fichaTecnicaFormController.fichaTecnica = fichaTecnicaFormController.fichaTecnica.copyWith(
                            codigo: TextVO(value),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                        flex: 3,
                        child: AutocompleteTextFormField<ProdutoEntity>(
                          label: l10n.fields.produto,
                          initialValue: fichaTecnicaFormController.fichaTecnica.produto != null
                              ? "${fichaTecnicaFormController.fichaTecnica.produto?.codigo} - ${fichaTecnicaFormController.fichaTecnica.produto?.nome}"
                              : '',
                          onSelected: (value) {
                            fichaTecnicaFormController.fichaTecnica = fichaTecnicaFormController.fichaTecnica.copyWith(produto: value);
                          },
                          validator: (_) => fichaTecnicaFormController.fichaTecnica.produto != null &&
                                  fichaTecnicaFormController.fichaTecnica.produto!.isValid
                              ? null
                              : l10n.messages.selecioneUm(l10n.fields.produto, ArtigoEnum.artigoMasculino),
                          itemBuilder: (context, produto) {
                            return ListTile(
                              title: Text("${produto.codigo!} - ${produto.nome!}"),
                            );
                          },
                          suggestionsCallback: (pattern) async {
                            await produtoListStore.getListProduto(search: pattern);
                            return produtoListStore.state;
                          },
                        ))
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
                            initialValue: fichaTecnicaFormController.fichaTecnica.descricao.value,
                            isRequiredField: true,
                            isEnabled: true,
                            validator: (_) => fichaTecnicaFormController.fichaTecnica.descricao.errorMessage,
                            onChanged: (value) => {
                                  fichaTecnicaFormController.fichaTecnica =
                                      fichaTecnicaFormController.fichaTecnica.copyWith(descricao: TextVO(value))
                                }))
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: DecimalTextFormFieldWidget(
                            label: l10n.fields.quantidadeDeProducao,
                            showSymbol: false,
                            initialValue: fichaTecnicaFormController.fichaTecnica.quantidade.value,
                            isRequiredField: false,
                            isEnabled: true,
                            validator: (_) => fichaTecnicaFormController.fichaTecnica.quantidade.errorMessage,
                            onChanged: (value) => {
                                  fichaTecnicaFormController.fichaTecnica =
                                      fichaTecnicaFormController.fichaTecnica.copyWith(quantidade: MoedaVO(value))
                                })),
                    const SizedBox(width: 16),
                    Flexible(
                      child: AutocompleteTextFormField<UnidadeEntity>(
                        label: l10n.fields.tipoDeUnidade,
                        initialValue: fichaTecnicaFormController.fichaTecnica.unidade != null
                            ? "${fichaTecnicaFormController.fichaTecnica.unidade?.nome} - ${fichaTecnicaFormController.fichaTecnica.unidade?.codigo}"
                            : '',
                        onSelected: (value) {
                          fichaTecnicaFormController.fichaTecnica = fichaTecnicaFormController.fichaTecnica.copyWith(unidade: value);
                        },
                        validator: (_) => fichaTecnicaFormController.fichaTecnica.unidade != null &&
                                fichaTecnicaFormController.fichaTecnica.unidade!.isValid
                            ? null
                            : l10n.messages.selecioneUm(l10n.fields.tipoDeUnidade, ArtigoEnum.artigoMasculino),
                        itemBuilder: (context, unidade) {
                          return ListTile(
                            title: Text("${unidade.nome!} - ${unidade.codigo!}"),
                          );
                        },
                        suggestionsCallback: (pattern) async {
                          await unidadeListStore.getListUnidade(search: pattern);
                          return unidadeListStore.state;
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
