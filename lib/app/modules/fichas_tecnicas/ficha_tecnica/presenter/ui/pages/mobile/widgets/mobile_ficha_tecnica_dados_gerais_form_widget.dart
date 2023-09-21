// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/unidades_list_store.dart';

class MobileFichaTecnicaDadosGeraisFormWidget extends StatelessWidget {
  final FichaTecnicaFormController fichaTecnicaFormController;
  final ProdutoListStore produtoListStore;
  final UnidadeListStore unidadeListStore;
  final GlobalKey<FormState> formKey;

  const MobileFichaTecnicaDadosGeraisFormWidget({
    Key? key,
    required this.formKey,
    required this.fichaTecnicaFormController,
    required this.produtoListStore,
    required this.unidadeListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = translation;

    return RxBuilder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Form(
          key: formKey,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              TextFormFieldWidget(
                label: l10n.fields.codigo,
                initialValue: fichaTecnicaFormController.fichaTecnica.codigo.value,
                isRequiredField: true,
                isEnabled: true,
                validator: (_) => fichaTecnicaFormController.fichaTecnica.codigo.errorMessage,
                onChanged: (value) {
                  fichaTecnicaFormController.fichaTecnica =
                      fichaTecnicaFormController.fichaTecnica.copyWith(codigo: value.isNotEmpty ? TextVO(value) : TextVO(''));
                },
              ),
              const SizedBox(height: 16),
              AutocompleteTextFormField<ProdutoEntity>(
                textFieldConfiguration: TextFieldConfiguration(decoration: InputDecoration(label: Text(l10n.fields.produto))),
                initialSelectedValue: fichaTecnicaFormController.fichaTecnica.produto,
                itemTextValue: (value) => "${value.codigo} - ${value.nome}",
                onSelected: (value) {
                  fichaTecnicaFormController.fichaTecnica = fichaTecnicaFormController.fichaTecnica.copyWith(produto: value);
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
              const SizedBox(height: 16),
              TextFormFieldWidget(
                label: l10n.fields.descricao,
                initialValue: fichaTecnicaFormController.fichaTecnica.descricao.value,
                isRequiredField: true,
                isEnabled: true,
                validator: (_) => fichaTecnicaFormController.fichaTecnica.descricao.errorMessage,
                onChanged: (value) {
                  fichaTecnicaFormController.fichaTecnica =
                      fichaTecnicaFormController.fichaTecnica.copyWith(descricao: value.isNotEmpty ? TextVO(value) : TextVO(''));
                },
              ),
              const SizedBox(height: 16),
              DoubleTextFormFieldWidget(
                label: l10n.fields.quantidadeDeProducao,
                initialValue: fichaTecnicaFormController.fichaTecnica.quantidade.value,
                isRequiredField: true,
                isEnabled: true,
                showSymbol: false,
                validator: (_) => fichaTecnicaFormController.fichaTecnica.quantidade.errorMessage,
                onChanged: (value) {
                  fichaTecnicaFormController.fichaTecnica = fichaTecnicaFormController.fichaTecnica.copyWith(quantidade: MoedaVO(value));
                },
              ),
              const SizedBox(height: 16),
              AutocompleteTextFormField<UnidadeEntity>(
                textFieldConfiguration: TextFieldConfiguration(decoration: InputDecoration(label: Text(l10n.fields.tipoDeUnidade))),
                initialSelectedValue: fichaTecnicaFormController.fichaTecnica.unidade,
                itemTextValue: (value) => "${value.nome} - ${value.codigo}",
                onSelected: (value) {
                  fichaTecnicaFormController.fichaTecnica = fichaTecnicaFormController.fichaTecnica.copyWith(unidade: value);
                },
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
            ],
          ),
        ),
      );
    });
  }
}
