// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/enum/tipo_de_restricao_enum.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/controllers/grupo_de_restricao_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/grupo_de_restricao_form_store.dart';

class GrupoDeRestricaoFormMobilePage extends StatefulWidget {
  final String? id;
  final GrupoDeRestricaoFormStore grupoDeRestricaoFormStore;
  final GrupoDeRestricaoController grupoDeRestricaoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const GrupoDeRestricaoFormMobilePage({
    Key? key,
    this.id,
    required this.grupoDeRestricaoFormStore,
    required this.grupoDeRestricaoController,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  State<GrupoDeRestricaoFormMobilePage> createState() => _GrupoDeRestricaoFormMobilePageState();
}

class _GrupoDeRestricaoFormMobilePageState extends State<GrupoDeRestricaoFormMobilePage> {
  GrupoDeRestricaoFormStore get grupoDeRestricaoFormStore => widget.grupoDeRestricaoFormStore;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  GrupoDeRestricaoController get grupoDeRestricaoController => widget.grupoDeRestricaoController;
  GrupoDeRestricaoEntity? oldGrupoRestricao;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    grupoDeRestricaoController.isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final id = widget.id;
      if (id != null && grupoDeRestricaoController.grupoDeRestricao.id != id) {
        grupoDeRestricaoController.grupoDeRestricao = await grupoDeRestricaoFormStore.pegarGrupoDeRestricao(id);
      }

      oldGrupoRestricao = grupoDeRestricaoController.grupoDeRestricao.copyWith();
      grupoDeRestricaoController.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;

    context.select(() => [
          grupoDeRestricaoController.grupoDeRestricao,
          grupoDeRestricaoController.isEnabled,
          grupoDeRestricaoController.isLoading,
        ]);

    if (grupoDeRestricaoController.isLoading) {
      return const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue));
    }

    final grupoDeRestricao = grupoDeRestricaoController.grupoDeRestricao;

    return CustomScaffold.titleString(
      widget.id == null ? l10n.titles.criarGrupoDeRestricoes : grupoDeRestricaoController.grupoDeRestricao.descricao.value,
      alignment: Alignment.centerLeft,
      controller: scaffoldController,
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              IntegerTextFormFieldWidget(
                label: l10n.fields.codigo,
                initialValue: grupoDeRestricao.codigo?.value,
                isEnabled: grupoDeRestricaoController.isEnabled,
                isRequiredField: true,
                onChanged: (value) {
                  grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(
                    codigo: CodigoVO(value),
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormFieldWidget(
                label: l10n.fields.nome,
                initialValue: grupoDeRestricao.descricao.value,
                isEnabled: grupoDeRestricaoController.isEnabled,
                isRequiredField: true,
                onChanged: (value) => grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(
                  descricao: TextVO(value),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonWidget<TipoDeRestricaoEnum>(
                label: l10n.fields.tipo,
                value: grupoDeRestricao.tipo,
                items: TipoDeRestricaoEnum.values
                    .map<DropdownItem<TipoDeRestricaoEnum>>((tipo) => DropdownItem(value: tipo, label: tipo.description))
                    .toList(),
                isRequiredField: true,
                errorMessage: l10n.messages.errorCampoObrigatorio,
                onSelected: (value) => grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(tipo: value),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: TripleBuilder<GrupoDeRestricaoFormStore, GrupoDeRestricaoEntity?>(
            store: grupoDeRestricaoFormStore,
            builder: (context, triple) {
              final error = triple.error;
              if (!triple.isLoading && error != null && error is Failure) {
                Asuka.showDialog(
                  barrierColor: Colors.black38,
                  builder: (context) {
                    return ErrorModal(errorMessage: (triple.error as Failure).errorMessage ?? '');
                  },
                );
              }

              final grupoRestricao = triple.state;
              if (grupoRestricao != null && !triple.isLoading) {
                Asuka.showSnackBar(
                  SnackBar(
                    content: Text(
                      widget.id == null
                          ? l10n.messages.criouUmEntidadeComSucesso(l10n.fields.grupoDeRestricao)
                          : l10n.messages.editouUmEntidadeComSucesso(l10n.fields.grupoDeRestricao),
                      style: AnaTextStyles.grey14Px.copyWith(fontSize: 15, color: Colors.white, letterSpacing: 0.25),
                    ),
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.87),
                    behavior: SnackBarBehavior.floating,
                    width: 635,
                  ),
                );

                if (widget.id == null) {
                  Modular.to.pop();
                } else {
                  oldGrupoRestricao = grupoDeRestricaoController.grupoDeRestricao.copyWith();
                  grupoDeRestricaoController.grupoDeRestricaoNotifyListeners();
                }
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(
                    title: widget.id == null ? l10n.fields.cancelar : l10n.fields.descartar,
                    isEnabled: grupoDeRestricaoController.isEnabled,
                    onPressed: () {
                      if (oldGrupoRestricao != widget.grupoDeRestricaoController.grupoDeRestricao) {
                        Asuka.showDialog(
                          barrierColor: Colors.black38,
                          builder: (context) {
                            return ConfirmationModalWidget(
                              title: l10n.titles.descartarAlteracoes,
                              messages: l10n.messages.descatarAlteracoesCriacaoEntidade,
                              titleCancel: l10n.fields.descartar,
                              titleSuccess: l10n.fields.continuar,
                              onCancel: () => Modular.to.pop(),
                            );
                          },
                        );
                      } else {
                        Modular.to.pop();
                      }
                    },
                  ),
                  const SizedBox(width: 12),
                  CustomPrimaryButton(
                    title: widget.id != null ? l10n.fields.salvar : l10n.fields.criar,
                    isLoading: triple.isLoading,
                    onPressed: () async {
                      grupoDeRestricaoFormStore.salvar(grupoDeRestricaoController.grupoDeRestricao);
                    },
                  )
                ],
              );
            }),
      ),
    );
  }
}
