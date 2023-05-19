// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/enum/tipo_de_recurso_enum.dart';

import '../../../../../grupo_de_recurso/presenter/ui/widgets/grupo_de_recurso_dropdown_widget.dart';
import '../../../stores/recurso_form_store.dart';
import '../../../stores/states/recurso_form_state.dart';

class RecursoFormMobilePage extends StatefulWidget {
  final String? id;
  final RecursoFormStore recursoFormStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const RecursoFormMobilePage({
    Key? key,
    this.id,
    required this.recursoFormStore,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  State<RecursoFormMobilePage> createState() => _RecursoFormMobilePageState();
}

class _RecursoFormMobilePageState extends State<RecursoFormMobilePage> {
  RecursoFormStore get recursoFormStore => widget.recursoFormStore;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.id != null && recursoFormStore.state.recurso?.id != widget.id) {
      recursoFormStore.pegarRecurso(widget.id!);
    }
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
      onIconTap: () {
        Modular.to.pop();
        recursoFormStore.clear();
      },
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: Padding(
          padding: const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 24),
          child: Form(
            key: _formKey,
            child: TripleBuilder<RecursoFormStore, RecursoFormState>(
              store: recursoFormStore,
              builder: (context, triple) {
                if (triple.isLoading && widget.id != null && triple.state.recurso == null) {
                  return const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue));
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
                            CustomBaseTextField(
                              controller: recursoFormStore.codigoController,
                              label: context.l10n.materiaisPcpCodigoLabelObrigatorio,
                              isEnabled: !triple.isLoading,
                              isRequiredField: true,
                            ),
                            const SizedBox(height: 16),
                            CustomBaseTextField(
                              controller: recursoFormStore.nomeController,
                              label: context.l10n.materiaisPcpNomeLabelObrigatorio,
                              isEnabled: !triple.isLoading,
                              isRequiredField: true,
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonWidget<TipoDeRecursoEnum>(
                                label: context.l10n.materiaisPcpTipoDeRecursoLabel,
                                items: TipoDeRecursoEnum.values
                                    .map<DropdownItem<TipoDeRecursoEnum>>((tipo) => DropdownItem(value: tipo, label: tipo.name))
                                    .toList(),
                                isRequiredField: true,
                                errorMessage: l10n.materiaisPcpEsteCampoPrecisaEstarPreenchido,
                                onSelected: (value) {} //=> grupoDeRecursoFormStore.selectTipoDeRecurso(value),
                                ),
                            const SizedBox(height: 16),
                            GrupoDeRecursoDropdownWidget(
                              listenable: recursoFormStore.selectedGrupoDeRecurso,
                              isRequiredField: false,
                              isEnabled: !triple.isLoading,
                              onSelected: (value) => recursoFormStore.selectGrupoDeRecurso(value),
                            ),
                            const SizedBox(height: 16),
                            CustomBaseTextField(
                              label: context.l10n.materiaisPcpCustoPorHoraLabel,
                              controller: recursoFormStore.custoHoraController,
                              isEnabled: !triple.isLoading,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly, CentavosInputFormatter(moeda: true)],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextButton(
                              title: context.l10n.materiaisPcpVoltar,
                              isEnabled: !triple.isLoading,
                              onPressed: () {
                                Modular.to.pop();

                                recursoFormStore.clear();
                              }),
                          const SizedBox(width: 10),
                          CustomPrimaryButton(
                              title: widget.id != null ? context.l10n.materiaisPcpEditar : context.l10n.materiaisPcpCriar,
                              isLoading: triple.isLoading,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await recursoFormStore.salvar();

                                    Asuka.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          widget.id != null
                                              ? context.l10n
                                                  .materiaisPpcEntidadeEditadoComSucessoMasculino(context.l10n.materiaisPcpRecurso)
                                              : context.l10n
                                                  .materiaisPpcEntidadeCriadoComSucessoMasculino(context.l10n.materiaisPcpRecurso),
                                          style: AnaTextStyles.grey14Px.copyWith(fontSize: 15, color: Colors.white, letterSpacing: 0.25),
                                        ),
                                        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.87),
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                                      ),
                                    );

                                    Modular.to.pop();
                                  } finally {}
                                }
                              })
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          )),
    );
  }
}
