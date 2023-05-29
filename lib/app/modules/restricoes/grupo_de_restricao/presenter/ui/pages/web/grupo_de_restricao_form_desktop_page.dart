// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/enum/tipo_de_restricao_enum.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/controllers/grupo_de_restricao_controller.dart';

import '../../../stores/grupo_de_restricao_form_store.dart';
import '../../../stores/states/grupo_de_restricao_form_state.dart';

class GrupoDeRestricaoFormDesktopPage extends StatefulWidget {
  final String? id;
  final GrupoDeRestricaoFormStore grupoDeRestricaoFormStore;
  final GrupoDeRestricaoController grupoDeRestricaoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const GrupoDeRestricaoFormDesktopPage({
    Key? key,
    this.id,
    required this.grupoDeRestricaoFormStore,
    required this.grupoDeRestricaoController,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  State<GrupoDeRestricaoFormDesktopPage> createState() => _GrupoDeRestricaoFormDesktopPageState();
}

class _GrupoDeRestricaoFormDesktopPageState extends State<GrupoDeRestricaoFormDesktopPage> {
  GrupoDeRestricaoFormStore get grupoDeRestricaoFormStore => widget.grupoDeRestricaoFormStore;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  GrupoDeRestricaoController get grupoDeRestricaoController => widget.grupoDeRestricaoController;

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
      grupoDeRestricaoController.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return CustomScaffold.titleString(
      widget.id != null ? l10n.materiaisPcpEditarGrupoDeRestricoes : l10n.materiaisPcpCriarGrupoDeRestricoes,
      alignment: Alignment.centerLeft,
      controller: scaffoldController,
      onIconTap: () {
        Modular.to.pop();
        grupoDeRestricaoFormStore.clear();
      },
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 635),
            child: RxBuilder(
              builder: (context) {
                if (grupoDeRestricaoController.isLoading) {
                  return const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue));
                }

                final grupoDeRestricao = grupoDeRestricaoController.grupoDeRestricao;

                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: CustomBaseTextField(
                              label: l10n.materiaisPcpCodigoLabel,
                              initialValue: grupoDeRestricao.codigo?.toString(),
                              isEnabled: true,
                              isRequiredField: true,
                              onChanged: (value) {
                                grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(codigo: value);
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                              flex: 3,
                              child: CustomBaseTextField(
                                label: l10n.materiaisPcpNomeLabel,
                                initialValue: grupoDeRestricao.descricao,
                                isEnabled: true,
                                isRequiredField: true,
                                onChanged: (value) =>
                                    grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(descricao: value),
                              )),
                        ],
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonWidget<TipoDeRestricaoEnum>(
                        label: l10n.materiaisPcpTipoLabel,
                        value: grupoDeRestricao.tipo,
                        items: TipoDeRestricaoEnum.values
                            .map<DropdownItem<TipoDeRestricaoEnum>>((tipo) => DropdownItem(value: tipo, label: tipo.description))
                            .toList(),
                        isRequiredField: true,
                        errorMessage: l10n.materiaisPcpEsteCampoPrecisaEstarPreenchido,
                        onSelected: (value) => grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(tipo: value),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: TripleBuilder<GrupoDeRestricaoFormStore, GrupoDeRestricaoFormState>(
          store: grupoDeRestricaoFormStore,
          builder: (context, triple) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextButton(
                    title: l10n.materiaisPcpVoltar,
                    isEnabled: !triple.isLoading,
                    onPressed: () {
                      Modular.to.pop();

                      grupoDeRestricaoFormStore.clear();
                    }),
                const SizedBox(width: 10),
                CustomPrimaryButton(
                  title: widget.id != null ? l10n.materiaisPcpEditar : l10n.materiaisPcpCriar,
                  isLoading: triple.isLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        grupoDeRestricaoController.isEnabled = false;
                        await grupoDeRestricaoFormStore.salvar(grupoDeRestricaoController.grupoDeRestricao);

                        Asuka.showSnackBar(
                          SnackBar(
                            content: Text(
                              widget.id != null
                                  ? l10n.materiaisPpcEntidadeEditadoComSucessoMasculino(l10n.materiaisPcpGrupoDeRestricao)
                                  : l10n.materiaisPpcEntidadeCriadoComSucessoMasculino(l10n.materiaisPcpGrupoDeRestricao),
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
