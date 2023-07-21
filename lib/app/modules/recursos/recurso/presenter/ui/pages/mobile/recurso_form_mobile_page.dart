// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/controllers/recurso_controller.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/stores/get_grupo_de_recurso_store.dart';

import '../../../stores/recurso_form_store.dart';
import '../../../stores/states/recurso_form_state.dart';

class RecursoFormMobilePage extends StatefulWidget {
  final String? id;
  final RecursoFormStore recursoFormStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final RecursoController recursoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const RecursoFormMobilePage({
    Key? key,
    this.id,
    required this.recursoFormStore,
    required this.getGrupoDeRecursoStore,
    required this.recursoController,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  State<RecursoFormMobilePage> createState() => _RecursoFormMobilePageState();
}

class _RecursoFormMobilePageState extends State<RecursoFormMobilePage> {
  RecursoFormStore get recursoFormStore => widget.recursoFormStore;
  GetGrupoDeRecursoStore get getGrupoDeRecursoStore => widget.getGrupoDeRecursoStore;
  RecursoController get recursoController => widget.recursoController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    recursoFormStore.clear();

    recursoController.isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final id = widget.id;

      getGrupoDeRecursoStore.getGrupos();

      if (id != null && recursoFormStore.state.recurso?.id != id) {
        recursoController.recurso = await recursoFormStore.pegarRecurso(id);
      }
      recursoController.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return CustomScaffold.titleString(
      widget.id != null ? context.l10n.materiaisPcpEditarRecurso : context.l10n.materiaisPcpCriarRecurso,
      alignment: Alignment.centerLeft,
      controller: scaffoldController,
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 24),
        child: Form(
          key: _formKey,
          child: RxBuilder(
            builder: (context) {
              if (recursoController.isLoading) {
                return Center(child: CircularProgressIndicator(color: colorTheme?.primary));
              }

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.materiaisPcpCamposObrigatorios,
                            style: AnaTextStyles.grey14Px,
                          ),
                          const SizedBox(height: 16),
                          IntegerTextFormFieldWidget(
                            label: context.l10n.materiaisPcpCodigoLabelObrigatorio,
                            initialValue: recursoController.recurso.codigo.value,
                            isRequiredField: true,
                            isEnabled: recursoController.isEnabled,
                            onChanged: (value) => recursoController.recurso = recursoController.recurso.copyWith(
                              codigo: CodigoVO(value),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormFieldWidget(
                            label: context.l10n.materiaisPcpNomeLabelObrigatorio,
                            initialValue: recursoController.recurso.descricao.value,
                            isRequiredField: true,
                            isEnabled: recursoController.isEnabled,
                            onChanged: (value) => recursoController.recurso = recursoController.recurso.copyWith(
                              descricao: TextVO(value),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ScopedBuilder<GetGrupoDeRecursoStore, List<GrupoDeRecurso>>(
                            store: getGrupoDeRecursoStore,
                            onState: (_, grupos) {
                              return DropdownButtonWidget<GrupoDeRecurso>(
                                label: context.l10n.materiaisPcpGrupoDeRecurso,
                                value: grupos.isNotEmpty ? recursoController.recurso.grupoDeRecurso : null,
                                isRequiredField: true,
                                errorMessage: context.l10n.materiaisPcpEsteCampoPrecisaEstarPreenchido,
                                isEnabled: recursoController.isEnabled,
                                items: grupos
                                    .map((grupoDeRecurso) => DropdownItem(value: grupoDeRecurso, label: grupoDeRecurso.descricao.value))
                                    .toList(),
                                onSelected: (value) =>
                                    recursoController.recurso = recursoController.recurso.copyWith(grupoDeRecurso: value, tipo: value.tipo),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          MoneyTextFormFieldWidget(
                            label: context.l10n.materiaisPcpCustoPorHoraLabel,
                            initialValue: recursoController.recurso.custoHora?.value,
                            isEnabled: recursoController.isEnabled,
                            showSymbol: false,
                            onChanged: (value) {
                              recursoController.recurso = recursoController.recurso.copyWith(
                                custoHora: MoedaVO(value),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: TripleBuilder<RecursoFormStore, RecursoFormState>(
          builder: (context, triple) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextButton(
                    title: l10n.materiaisPcpVoltar,
                    isEnabled: recursoController.isEnabled,
                    onPressed: () {
                      Modular.to.pop();

                      recursoFormStore.clear();
                    }),
                const SizedBox(width: 10),
                CustomPrimaryButton(
                  title: widget.id != null ? l10n.materiaisPcpEditar : l10n.materiaisPcpCriar,
                  isEnabled: recursoController.isEnabled,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await recursoFormStore.salvar(recursoController.recurso);

                        Asuka.showSnackBar(
                          SnackBar(
                            content: Text(
                              widget.id != null
                                  ? l10n.materiaisPpcEntidadeEditadoComSucessoMasculino(l10n.materiaisPcpRecurso)
                                  : l10n.materiaisPpcEntidadeCriadoComSucessoMasculino(l10n.materiaisPcpRecurso),
                              style: AnaTextStyles.grey14Px.copyWith(fontSize: 15, color: Colors.white, letterSpacing: 0.25),
                            ),
                            backgroundColor: const Color.fromRGBO(0, 0, 0, 0.87),
                            behavior: SnackBarBehavior.floating,
                            width: 635,
                          ),
                        );

                        Modular.to.pop();
                      } finally {}
                    }
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
