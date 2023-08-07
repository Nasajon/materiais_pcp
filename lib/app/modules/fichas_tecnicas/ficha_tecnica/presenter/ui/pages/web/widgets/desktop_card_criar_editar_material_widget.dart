import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/artigos_enum.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/unidades_list_store.dart';

class DesktopCardCriarEditarMaterialWidget extends StatelessWidget {
  final FichaTecnicaFormController fichaTecnicaFormController;
  final ProdutoListStore produtoListStore;
  final UnidadeListStore unidadeListStore;
  final GlobalKey<FormState> formKey;
  bool get isProdutoSelected =>
      fichaTecnicaFormController.material?.produto?.codigo != '' && fichaTecnicaFormController.material?.produto?.nome != '';
  bool get isUnidadeSelected =>
      fichaTecnicaFormController.material?.unidade?.codigo != '' && fichaTecnicaFormController.material?.unidade?.nome != '';

  const DesktopCardCriarEditarMaterialWidget({
    Key? key,
    required this.fichaTecnicaFormController,
    required this.formKey,
    required this.produtoListStore,
    required this.unidadeListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = translation;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    final material = fichaTecnicaFormController.material;

    return Container(
      width: 480,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorTheme?.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorTheme?.border ?? Colors.transparent,
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              material != null && material.codigo == 0 ? l10n.titles.adicionarMaterial : l10n.titles.editarMaterial,
              style: themeData.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 3,
                  child: AutocompleteTextFormField<ProdutoEntity>(
                    key: key,
                    label: l10n.fields.produto,
                    initialValue: isProdutoSelected ? "${material?.produto?.codigo} - ${material?.produto?.nome}" : '',
                    validator: (_) => material!.produto!.isValid
                        ? null
                        : l10n.messages.selecione(l10n.fields.produto, ArtigoEnum.ARTIGO_MASCULINO_INDEFINIDO),
                    onSelected: (value) {
                      fichaTecnicaFormController.material = material?.copyWith(produto: value);
                    },
                    itemBuilder: (context, produto) {
                      return ListTile(
                        title: Text("${produto.codigo!} - ${produto.nome!}"),
                      );
                    },
                    suggestionsCallback: (pattern) async {
                      await produtoListStore.getListProduto(search: pattern);
                      return produtoListStore.state;
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: DecimalTextFormFieldWidget(
                      key: key,
                      label: l10n.fields.quantidade,
                      showSymbol: false,
                      initialValue: material?.quantidade?.value,
                      validator: (_) => material!.quantidade != null && material!.quantidade!.isNotValid
                          ? l10n.messages.insira(l10n.fields.quantidade, ArtigoEnum.ARTIGO_FEMININO_INDEFINIDO)
                          : null,
                      onChanged: (value) {
                        fichaTecnicaFormController.material = material?.copyWith(quantidade: MoedaVO(value));
                      }),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: AutocompleteTextFormField<UnidadeEntity>(
                    key: key,
                    label: l10n.fields.tipoDeUnidade,
                    initialValue: isUnidadeSelected ? "${material?.unidade?.nome} - ${material?.unidade?.codigo}" : '',
                    onSelected: (value) {
                      fichaTecnicaFormController.material = material?.copyWith(unidade: value);
                    },
                    validator: (_) => material!.unidade!.isValid
                        ? null
                        : l10n.messages.selecione(l10n.fields.tipoDeUnidade, ArtigoEnum.ARTIGO_MASCULINO_INDEFINIDO),
                    itemBuilder: (context, unidade) {
                      return ListTile(
                        title: Text("${unidade.codigo!} - ${unidade.nome!}"),
                      );
                    },
                    suggestionsCallback: (pattern) async {
                      await unidadeListStore.getListUnidade(search: pattern);
                      return unidadeListStore.state;
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: material != null && material.codigo > 0,
                  child: CustomTextButton(
                    title: l10n.fields.excluir,
                    onPressed: () {
                      Asuka.showDialog(
                        barrierColor: Colors.black38,
                        builder: (context) {
                          return ConfirmationModalWidget(
                            title: l10n.titles.excluirEntidade(l10n.fields.material),
                            messages: l10n.messages.excluirEntidade(l10n.fields.material, ArtigoEnum.ARTIGO_MASCULINO_DEFINIDO),
                            titleCancel: l10n.fields.excluir,
                            titleSuccess: l10n.fields.cancelar,
                            onCancel: () {
                              fichaTecnicaFormController.removerMaterial(material?.codigo ?? 0);

                              fichaTecnicaFormController.material = null;
                            },
                          );
                        },
                      );
                    },
                    textColor: colorTheme?.danger,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextButton(
                      title: l10n.fields.cancelar,
                      onPressed: () => fichaTecnicaFormController.material = null,
                    ),
                    const SizedBox(width: 16),
                    CustomOutlinedButton(
                      title: material != null && material.codigo > 0 ? l10n.fields.salvar : l10n.fields.adicionar,
                      onPressed: () {
                        var horario = fichaTecnicaFormController.material;
                        if (formKey.currentState!.validate() && horario != null) {
                          fichaTecnicaFormController.criarEditarMaterial(horario);
                        }
                      },
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
