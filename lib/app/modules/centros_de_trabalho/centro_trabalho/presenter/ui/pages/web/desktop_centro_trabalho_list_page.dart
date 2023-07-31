import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/presenter/stores/centro_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/presenter/stores/states/centro_trabalho_state.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/presenter/ui/widgets/centro_trabalho_item_widget.dart';

class DesktopCentroTrabalhoListPage extends StatefulWidget {
  final CentroTrabalhoListStore centroTrabalhoListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const DesktopCentroTrabalhoListPage({
    Key? key,
    required this.centroTrabalhoListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<DesktopCentroTrabalhoListPage> createState() => _DesktopCentroTrabalhoListPageState();
}

class _DesktopCentroTrabalhoListPageState extends State<DesktopCentroTrabalhoListPage>
    with DialogErrorMixin<DesktopCentroTrabalhoListPage, CentroTrabalhoListStore> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return CustomScaffold.titleString(
      translation.titles.centrosDeTrabalho,
      controller: widget.scaffoldController,
      alignment: Alignment.centerLeft,
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 635),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              PesquisaFormFieldWidget(
                label: translation.messages.pesquisarNomeOuPalavraChave,
                onChanged: (value) => widget.centroTrabalhoListStore.search = value,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ScopedBuilder<CentroTrabalhoListStore, List<CentroTrabalhoState>>(
                  store: widget.centroTrabalhoListStore,
                  onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                  onState: (context, state) {
                    final createCentroTrabalhoButton = Center(
                      child: CustomPrimaryButton(
                        title: translation.fields.criarCentro,
                        onPressed: () async {
                          await Modular.to.pushNamed('./new');
                        },
                      ),
                    );

                    if (state.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              widget.centroTrabalhoListStore.search.isEmpty
                                  ? translation.messages.nenhumEntidadeEncontrado(translation.titles.centroDeTrabalho)
                                  : translation.messages.naoHaResultadosParaPesquisa,
                              style: AnaTextStyles.grey20Px,
                            ),
                          ),
                          createCentroTrabalhoButton,
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (widget.centroTrabalhoListStore.search.isEmpty) ...{
                          Text(
                            translation.titles.ultimosCentrosAcessados,
                            style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 40),
                        },
                        Flexible(
                          child: ListView(
                            children: [
                              ...state.map((value) {
                                return CentroTrabalhoItemWidget(
                                  key: ValueKey('${value.centroTrabalho.codigo} - ${value.centroTrabalho.nome}'),
                                  centroTrabalho: value.centroTrabalho,
                                  deletarCentroTrabalhoStore: value.deletarStore,
                                  centroTrabalhoListStore: widget.centroTrabalhoListStore,
                                );
                              }).toList(),
                              const SizedBox(height: 16),
                              createCentroTrabalhoButton,
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
