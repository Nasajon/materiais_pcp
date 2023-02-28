import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import '../../../../../../core/modules/tipo_de_recurso/presenter/widgets/tipo_de_recurso_dropdown_widget.dart';
import '../../../stores/grupo_de_recurso_form_store.dart';
import '../../../stores/states/grupo_de_recurso_form_state.dart';

class GrupoDeRecursoFormDesktopPage extends StatefulWidget {
  final String? id;

  const GrupoDeRecursoFormDesktopPage({super.key, this.id});

  @override
  State<GrupoDeRecursoFormDesktopPage> createState() =>
      _GrupoDeRecursoFormDesktopPageState();
}

class _GrupoDeRecursoFormDesktopPageState
    extends State<GrupoDeRecursoFormDesktopPage> {
  final _store = Modular.get<GrupoDeRecursoFormStore>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.id != null && _store.state.grupoDeRecurso?.id != widget.id) {
      _store.pegarGrupoDeRecurso(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBasicAppBar.backButton(
          title: widget.id != null
              ? context.l10n.materiaisPcpEditarGrupoDeRecursos
              : context.l10n.materiaisPcpCriarGrupoDeRecursos,
          onPressed: () {
            Modular.to.pop();

            _store.clear();
          }),
      body: Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 635),
              child: Form(
                key: _formKey,
                child: TripleBuilder<GrupoDeRecursoFormStore, Failure,
                    GrupoDeRecursoFormState>(
                  store: _store,
                  builder: (context, triple) {
                    if (triple.isLoading &&
                        widget.id != null &&
                        triple.state.grupoDeRecurso == null) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: AnaColors.darkBlue));
                    }

                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: CustomBaseTextField(
                                label: context.l10n.materiaisPcpCodigoLabel,
                                controller: _store.codigoController,
                                isEnabled: !triple.isLoading,
                                isRequiredField: true,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                                flex: 3,
                                child: CustomBaseTextField(
                                  label: context.l10n.materiaisPcpNomeLabel,
                                  controller: _store.nomeController,
                                  isEnabled: !triple.isLoading,
                                  isRequiredField: true,
                                )),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TipoDeRecursoDropdownWidget(
                            listenable: _store.selectedTipoDeRecurso,
                            isRequiredField: true,
                            isEnabled: !triple.isLoading,
                            onSelected: (value) =>
                                _store.selectTipoDeRecurso(value)),
                        const Spacer(),
                        Row(
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
                                                          .materiaisPcpGrupoDeRecurso)
                                              : context.l10n
                                                  .materiaisPpcEntidadeCriadoComSucessoMasculino(
                                                      context.l10n
                                                          .materiaisPcpGrupoDeRecurso),
                                          style: AnaTextStyles.grey14Px
                                              .copyWith(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  letterSpacing: 0.25),
                                        ),
                                        backgroundColor:
                                            const Color.fromRGBO(0, 0, 0, 0.87),
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
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          )),
    );
  }
}
