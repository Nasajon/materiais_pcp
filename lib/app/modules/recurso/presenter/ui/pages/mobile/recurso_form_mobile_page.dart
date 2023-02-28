import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import '../../../../../../core/modules/tipo_de_recurso/presenter/widgets/tipo_de_recurso_dropdown_widget.dart';
import '../../../../../grupo_de_recurso/presenter/ui/widgets/grupo_de_recurso_dropdown_widget.dart';
import '../../../stores/recurso_form_store.dart';
import '../../../stores/states/recurso_form_state.dart';

class RecursoFormMobilePage extends StatefulWidget {
  final String? id;

  const RecursoFormMobilePage({super.key, this.id});

  @override
  State<RecursoFormMobilePage> createState() => _RecursoFormMobilePageState();
}

class _RecursoFormMobilePageState extends State<RecursoFormMobilePage> {
  final _store = Modular.get<RecursoFormStore>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.id != null && _store.state.recurso?.id != widget.id) {
      _store.pegarRecurso(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBasicAppBar.backButton(
          title: widget.id != null
              ? context.l10n.materiaisPcpEditarRecurso
              : context.l10n.materiaisPcpCriarRecurso,
          onPressed: () {
            Modular.to.pop();

            _store.clear();
          }),
      body: Padding(
          padding:
              const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 24),
          child: Form(
            key: _formKey,
            child: TripleBuilder<RecursoFormStore, Failure, RecursoFormState>(
              store: _store,
              builder: (context, triple) {
                if (triple.isLoading &&
                    widget.id != null &&
                    triple.state.recurso == null) {
                  return const Center(
                      child:
                          CircularProgressIndicator(color: AnaColors.darkBlue));
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
                              controller: _store.codigoController,
                              label: context
                                  .l10n.materiaisPcpCodigoLabelObrigatorio,
                              isEnabled: !triple.isLoading,
                              isRequiredField: true,
                            ),
                            const SizedBox(height: 16),
                            CustomBaseTextField(
                              controller: _store.nomeController,
                              label:
                                  context.l10n.materiaisPcpNomeLabelObrigatorio,
                              isEnabled: !triple.isLoading,
                              isRequiredField: true,
                            ),
                            const SizedBox(height: 16),
                            TipoDeRecursoDropdownWidget(
                              listenable: _store.selectedTipoDeRecurso,
                              isRequiredField: false,
                              isEnabled: !triple.isLoading,
                              onSelected: (value) =>
                                  _store.selectTipoDeRecurso(value),
                            ),
                            const SizedBox(height: 16),
                            GrupoDeRecursoDropdownWidget(
                              listenable: _store.selectedGrupoDeRecurso,
                              isRequiredField: false,
                              isEnabled: !triple.isLoading,
                              onSelected: (value) =>
                                  _store.selectGrupoDeRecurso(value),
                            ),
                            const SizedBox(height: 16),
                            CustomBaseTextField(
                              label: context.l10n.materiaisPcpCustoPorHoraLabel,
                              controller: _store.custoHoraController,
                              isEnabled: !triple.isLoading,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CentavosInputFormatter(moeda: true)
                              ],
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

                                _store.clear();
                              }),
                          const SizedBox(width: 10),
                          CustomPrimaryButton(
                              title: widget.id != null
                                  ? context.l10n.materiaisPcpEditar
                                  : context.l10n.materiaisPcpCriar,
                              isLoading: triple.isLoading,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await _store.salvar();

                                    Asuka.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          widget.id != null
                                              ? context.l10n
                                                  .materiaisPpcEntidadeEditadoComSucessoMasculino(
                                                      context.l10n
                                                          .materiaisPcpRecurso)
                                              : context.l10n
                                                  .materiaisPpcEntidadeCriadoComSucessoMasculino(
                                                      context.l10n
                                                          .materiaisPcpRecurso),
                                          style: AnaTextStyles.grey14Px
                                              .copyWith(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  letterSpacing: 0.25),
                                        ),
                                        backgroundColor:
                                            const Color.fromRGBO(0, 0, 0, 0.87),
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 20),
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
