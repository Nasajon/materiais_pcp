// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_l10n.dart';
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
import 'package:pcp_flutter/app/modules/recursos/common/domain/enum/tipo_de_recurso_enum.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/controllers/grupo_de_recurso_controller.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/stores/grupo_de_recurso_form_store.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/stores/states/grupo_de_recurso_form_state.dart';

class GrupoDeRecursoFormMobilePage extends StatefulWidget {
  final String? id;
  final GrupoDeRecursoFormStore grupoDeRecursoFormStore;
  final GrupoDeRecursoController grupoDeRecursoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const GrupoDeRecursoFormMobilePage({
    Key? key,
    this.id,
    required this.grupoDeRecursoFormStore,
    required this.grupoDeRecursoController,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  State<GrupoDeRecursoFormMobilePage> createState() => _GrupoDeRecursoFormMobilePageState();
}

class _GrupoDeRecursoFormMobilePageState extends State<GrupoDeRecursoFormMobilePage> {
  GrupoDeRecursoFormStore get grupoDeRecursoFormStore => widget.grupoDeRecursoFormStore;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  GrupoDeRecursoController get grupoDeRecursoController => widget.grupoDeRecursoController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    grupoDeRecursoController.isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final id = widget.id;
      if (id != null && grupoDeRecursoController.grupoDeRecurso.id != id) {
        grupoDeRecursoController.grupoDeRecurso = await grupoDeRecursoFormStore.pegarGrupoDeRecurso(id);
      }
      grupoDeRecursoController.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final themeData = Theme.of(context);

    return CustomScaffold.titleString(
      widget.id != null ? l10n.materiaisPcpEditarGrupoDeRecursos : l10n.materiaisPcpCriarGrupoDeRecursos,
      alignment: Alignment.centerLeft,
      controller: scaffoldController,
      onIconTap: () {
        Modular.to.pop();
        grupoDeRecursoFormStore.clear();
      },
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 24),
        child: RxBuilder(builder: (context) {
          if (grupoDeRecursoController.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue));
          }

          final grupoDeRecurso = grupoDeRecursoController.grupoDeRecurso;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                IntegerTextFormFieldWidget(
                  label: l10n.materiaisPcpCodigoLabel,
                  initialValue: grupoDeRecurso.codigo.value,
                  isEnabled: grupoDeRecursoController.isEnabled,
                  isRequiredField: true,
                  onChanged: (value) => grupoDeRecursoController.grupoDeRecurso = grupoDeRecurso.copyWith(
                    codigo: CodigoVO(value),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(
                  label: l10n.materiaisPcpNomeLabel,
                  initialValue: grupoDeRecurso.descricao.value,
                  isEnabled: grupoDeRecursoController.isEnabled,
                  isRequiredField: true,
                  onChanged: (value) => grupoDeRecursoController.grupoDeRecurso = grupoDeRecurso.copyWith(
                    descricao: TextVO(value),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonWidget<TipoDeRecursoEnum>(
                  label: l10n.materiaisPcpTipoLabel,
                  value: grupoDeRecurso.tipo,
                  items: TipoDeRecursoEnum.values
                      .map<DropdownItem<TipoDeRecursoEnum>>((tipo) => DropdownItem(value: tipo, label: tipo.name(context.l10nLocalization)))
                      .toList(),
                  isRequiredField: true,
                  errorMessage: l10n.materiaisPcpEsteCampoPrecisaEstarPreenchido,
                  onSelected: (value) => grupoDeRecursoController.grupoDeRecurso = grupoDeRecurso.copyWith(tipo: value),
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: TripleBuilder<GrupoDeRecursoFormStore, GrupoDeRecursoFormState>(
            store: grupoDeRecursoFormStore,
            builder: (context, triple) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(
                      title: l10n.materiaisPcpVoltar,
                      isEnabled: grupoDeRecursoController.isEnabled,
                      onPressed: () {
                        Modular.to.pop();

                        grupoDeRecursoFormStore.clear();
                      }),
                  const SizedBox(width: 12),
                  CustomPrimaryButton(
                      title: widget.id != null ? l10n.materiaisPcpEditar : l10n.materiaisPcpCriar,
                      isLoading: triple.isLoading,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await grupoDeRecursoFormStore.salvar(grupoDeRecursoController.grupoDeRecurso);

                            Asuka.showSnackBar(
                              SnackBar(
                                content: Text(
                                  widget.id != null
                                      ? l10n.materiaisPpcEntidadeEditadoComSucessoMasculino(l10n.materiaisPcpGrupoDeRecurso)
                                      : l10n.materiaisPpcEntidadeCriadoComSucessoMasculino(l10n.materiaisPcpGrupoDeRecurso),
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
              );
            }),
      ),
    );
  }
}
