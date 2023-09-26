import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/enums/artigo_enum.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/unidades_list_store.dart';

class MobileCriarEditarMaterialPage extends StatefulWidget {
  final FichaTecnicaFormController fichaTecnicaFormController;
  final ProdutoListStore produtoListStore;
  final UnidadeListStore unidadeListStore;

  final ValueNotifier<bool> adaptiveModalNotifier;

  const MobileCriarEditarMaterialPage({
    Key? key,
    required this.fichaTecnicaFormController,
    required this.adaptiveModalNotifier,
    required this.produtoListStore,
    required this.unidadeListStore,
  }) : super(key: key);

  @override
  State<MobileCriarEditarMaterialPage> createState() => _MobileCriarEditarMaterialPageState();
}

class _MobileCriarEditarMaterialPageState extends State<MobileCriarEditarMaterialPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    verificarFichaTecnicaMaterialRouter();
  }

  void verificarFichaTecnicaMaterialRouter() {
    if (!ScreenSizeUtil(context).isMobile && widget.adaptiveModalNotifier.value) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = translation;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return CustomScaffold.titleString(
      key: _scaffoldKey,
      widget.fichaTecnicaFormController.material != null && widget.fichaTecnicaFormController.material?.codigo == 0
          ? translations.titles.adicionarMaterial
          : translations.titles.editarMaterial,
      controller: CustomScaffoldController(),
      alignment: Alignment.centerLeft,
      closeIcon: const Icon(Icons.close),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              RxBuilder(builder: (context) {
                return AutocompleteTextFormField<ProdutoEntity>(
                  textFieldConfiguration: TextFieldConfiguration(decoration: InputDecoration(label: Text(translations.fields.produto))),
                  initialSelectedValue: widget.fichaTecnicaFormController.material?.produto != ProdutoEntity.empty()
                      ? widget.fichaTecnicaFormController.material?.produto
                      : null,
                  itemTextValue: (value) => "${value.codigo} - ${value.nome}",
                  onSelected: (value) {
                    widget.fichaTecnicaFormController.material = widget.fichaTecnicaFormController.material?.copyWith(produto: value);
                  },
                  validator: (_) => widget.fichaTecnicaFormController.material!.produto.isValid
                      ? ''
                      : translations.messages.selecioneUm(translations.fields.produto),
                  itemBuilder: (context, produto) {
                    return ListTile(
                      title: Text("${produto.codigo} - ${produto.nome}"),
                    );
                  },
                  suggestionsCallback: (pattern) async {
                    await widget.produtoListStore.getListProduto(search: pattern);
                    return widget.produtoListStore.state;
                  },
                );
              }),
              const SizedBox(height: 20),
              DoubleTextFormFieldWidget(
                label: translations.fields.quantidade,
                initialValue: widget.fichaTecnicaFormController.material?.quantidade.valueOrNull,
                decimalDigits: widget.fichaTecnicaFormController.material?.unidade.decimais ?? 0,
                validator: (_) => widget.fichaTecnicaFormController.material!.quantidade.valueOrNull != null &&
                        widget.fichaTecnicaFormController.material!.quantidade.isNotValid
                    ? translations.messages.insiraUm(translations.fields.quantidade, artigo: ArtigoEnum.artigoFeminino)
                    : '',
                onChanged: (value) {
                  widget.fichaTecnicaFormController.material =
                      widget.fichaTecnicaFormController.material?.copyWith(quantidade: DoubleVO(value));
                },
              ),
              const SizedBox(height: 16),
              RxBuilder(builder: (context) {
                return AutocompleteTextFormField<UnidadeEntity>(
                  textFieldConfiguration:
                      TextFieldConfiguration(decoration: InputDecoration(label: Text(translations.fields.tipoDeUnidade))),
                  initialSelectedValue: widget.fichaTecnicaFormController.material?.unidade != UnidadeEntity.empty()
                      ? widget.fichaTecnicaFormController.material?.unidade
                      : null,
                  itemTextValue: (value) => "${value.codigo} - ${value.nome}",
                  onSelected: (value) {
                    widget.fichaTecnicaFormController.material = widget.fichaTecnicaFormController.material?.copyWith(unidade: value);
                  },
                  validator: (_) => widget.fichaTecnicaFormController.material!.unidade == UnidadeEntity.empty()
                      ? translations.messages.selecioneUm(translations.fields.tipoDeUnidade)
                      : null,
                  itemBuilder: (context, unidade) {
                    return ListTile(
                      title: Text("${unidade.codigo} - ${unidade.nome}"),
                    );
                  },
                  suggestionsCallback: (pattern) async {
                    await widget.unidadeListStore.getListUnidade(search: pattern);
                    return widget.unidadeListStore.state;
                  },
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.fichaTecnicaFormController.material != null && widget.fichaTecnicaFormController.material!.codigo > 0,
              child: CustomTextButton(
                title: translations.fields.excluir,
                textColor: colorTheme?.danger,
                onPressed: () {
                  Asuka.showDialog(
                    barrierColor: Colors.black38,
                    builder: (context) {
                      return ConfirmationModalWidget(
                        title: translations.titles.excluirEntidade(translations.fields.material),
                        messages: translations.messages.excluirAEntidade(translations.fields.material),
                        titleCancel: translations.fields.excluir,
                        titleSuccess: translations.fields.cancelar,
                        onCancel: () {
                          widget.fichaTecnicaFormController.removerMaterial(widget.fichaTecnicaFormController.material?.codigo ?? 0);

                          widget.fichaTecnicaFormController.material = null;

                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextButton(
                  title: translations.fields.cancelar,
                  onPressed: () {
                    widget.fichaTecnicaFormController.material = null;

                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 16),
                CustomPrimaryButton(
                  title: widget.fichaTecnicaFormController.material != null && widget.fichaTecnicaFormController.material!.codigo > 0
                      ? translations.fields.salvar
                      : translations.fields.adicionar,
                  onPressed: () {
                    var material = widget.fichaTecnicaFormController.material;
                    if (formKey.currentState!.validate() && material != null) {
                      widget.fichaTecnicaFormController.criarEditarMaterial(material);
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
