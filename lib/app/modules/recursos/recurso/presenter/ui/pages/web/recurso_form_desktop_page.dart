// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/enum/tipo_de_recurso_enum.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/stores/get_grupo_de_recurso_store.dart';

import '../../../stores/recurso_form_store.dart';
import '../../../stores/states/recurso_form_state.dart';

class RecursoFormDesktopPage extends StatefulWidget {
  final String? id;
  final RecursoFormStore recursoFormStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const RecursoFormDesktopPage({
    Key? key,
    this.id,
    required this.recursoFormStore,
    required this.getGrupoDeRecursoStore,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  State<RecursoFormDesktopPage> createState() => _RecursoFormDesktopPageState();
}

class _RecursoFormDesktopPageState extends State<RecursoFormDesktopPage> {
  RecursoFormStore get recursoFormStore => widget.recursoFormStore;
  GetGrupoDeRecursoStore get getGrupoDeRecursoStore => widget.getGrupoDeRecursoStore;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getGrupoDeRecursoStore.getGrupos();

      if (widget.id != null && recursoFormStore.state.recurso?.id != widget.id) {
        recursoFormStore.pegarRecurso(widget.id!);
      }
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
      onIconTap: () {
        Modular.to.pop();
        recursoFormStore.clear();
      },
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 24),
        child: Center(
            child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 635),
          child: Form(
            key: _formKey,
            child: TripleBuilder<RecursoFormStore, RecursoFormState>(
              store: recursoFormStore,
              builder: (context, triple) {
                if (triple.isLoading && widget.id != null && triple.state.recurso == null) {
                  return const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.materiaisPcpCamposObrigatorios,
                      style: AnaTextStyles.grey14Px,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: CustomBaseTextField(
                            controller: recursoFormStore.codigoController,
                            label: context.l10n.materiaisPcpCodigoLabelObrigatorio,
                            isRequiredField: true,
                            isEnabled: !triple.isLoading,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          flex: 3,
                          child: CustomBaseTextField(
                            controller: recursoFormStore.nomeController,
                            label: context.l10n.materiaisPcpNomeLabelObrigatorio,
                            isRequiredField: true,
                            isEnabled: !triple.isLoading,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: DropdownButtonWidget<TipoDeRecursoEnum>(
                              label: l10n.materiaisPcpTipoDeRecursoLabel,
                              items: TipoDeRecursoEnum.values
                                  .map<DropdownItem<TipoDeRecursoEnum>>((tipo) => DropdownItem(value: tipo, label: tipo.name))
                                  .toList(),
                              isRequiredField: true,
                              errorMessage: l10n.materiaisPcpEsteCampoPrecisaEstarPreenchido,
                              onSelected: (value) {} //=> grupoDeRecursoFormStore.selectTipoDeRecurso(value),
                              ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          flex: 1,
                          child: ScopedBuilder<GetGrupoDeRecursoStore, List<GrupoDeRecurso>>(
                            store: getGrupoDeRecursoStore,
                            onState: (_, grupos) {
                              return DropdownButtonWidget<GrupoDeRecurso>(
                                label: context.l10n.materiaisPcpGrupoDeRecurso,
                                isRequiredField: true,
                                errorMessage: context.l10n.materiaisPcpEsteCampoPrecisaEstarPreenchido,
                                onSelected: (value) {},
                                items: grupos
                                    .map((grupoDeRecurso) => DropdownItem(value: grupoDeRecurso, label: grupoDeRecurso.descricao))
                                    .toList(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomBaseTextField(
                      label: context.l10n.materiaisPcpCustoPorHoraLabel,
                      controller: recursoFormStore.custoHoraController,
                      isEnabled: !triple.isLoading,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, CentavosInputFormatter(moeda: true)],
                    ),
                    const Spacer(),
                    Row(
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
                                            ? context.l10n.materiaisPpcEntidadeEditadoComSucessoMasculino(context.l10n.materiaisPcpRecurso)
                                            : context.l10n.materiaisPpcEntidadeCriadoComSucessoMasculino(context.l10n.materiaisPcpRecurso),
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
                            })
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        )),
      ),
    );
  }
}
