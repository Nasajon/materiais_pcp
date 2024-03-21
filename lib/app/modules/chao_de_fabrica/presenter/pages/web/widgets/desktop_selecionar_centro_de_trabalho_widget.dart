import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/controllers/chao_de_fabrica_filter_controller.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_centro_de_trabalho_store.dart';

class DesktopSelecionarCentroDeTrabalhoWidget extends StatefulWidget {
  final ChaoDeFabricaCentroDeTrabalhoStore centroDeTrabalhoStore;
  final ChaoDeFabricaFilterController chaoDeFabricaFilterController;

  const DesktopSelecionarCentroDeTrabalhoWidget({
    Key? key,
    required this.centroDeTrabalhoStore,
    required this.chaoDeFabricaFilterController,
  }) : super(key: key);

  @override
  State<DesktopSelecionarCentroDeTrabalhoWidget> createState() => _DesktopSelecionarCentroDeTrabalhoWidgetState();
}

class _DesktopSelecionarCentroDeTrabalhoWidgetState extends State<DesktopSelecionarCentroDeTrabalhoWidget> {
  ChaoDeFabricaCentroDeTrabalhoStore get centroDeTrabalhoStore => widget.centroDeTrabalhoStore;
  ChaoDeFabricaFilterController get chaoDeFabricaFilterController => widget.chaoDeFabricaFilterController;

  late final Disposer centroDeTrabalhoDispose;
  final isLoadingNotifier = ValueNotifier(false);
  final centroDeTrabalhoNotifier = ValueNotifier<ChaoDeFabricaCentroDeTrabalhoEntity?>(null);

  @override
  void initState() {
    super.initState();
    centroDeTrabalhoStore.getCentrosDeTrabalhos('', delay: Duration.zero);

    centroDeTrabalhoNotifier.value = chaoDeFabricaFilterController.atividadeFilter.centroDeTrabalho;

    centroDeTrabalhoDispose = centroDeTrabalhoStore.observer(
      onLoading: (value) => isLoadingNotifier.value = value,
      onState: (_) => isLoadingNotifier.value = false,
    );
  }

  @override
  void dispose() {
    centroDeTrabalhoDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 500.responsive, maxWidth: 450.responsive),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 14.responsive),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translation.titles.selecione(translation.fields.centroDeTrabalho),
                  style: themeData.textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 14.responsive),
                NhidsSearchFormField(
                  hintText: translation.messages.pesquiseUmaEntidade(translation.fields.centroDeTrabalho),
                  onChanged: (value) => centroDeTrabalhoStore.getCentrosDeTrabalhos(value),
                ),
                SizedBox(height: 14.responsive),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: isLoadingNotifier,
              builder: (_, isLoading, __) {
                final listCentroDeTrabalho = centroDeTrabalhoStore.state;

                return ValueListenableBuilder(
                  valueListenable: centroDeTrabalhoNotifier,
                  builder: (_, centroDeTrabalhoSelecionado, __) {
                    return ListView.builder(
                      itemCount: listCentroDeTrabalho.length,
                      padding: EdgeInsets.all(14.responsive),
                      itemBuilder: (_, index) {
                        final centroDeTrabalho = listCentroDeTrabalho[index];

                        return ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          minVerticalPadding: 0,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  children: [
                                    Radio<ChaoDeFabricaCentroDeTrabalhoEntity>(
                                      value: centroDeTrabalho,
                                      groupValue: centroDeTrabalhoSelecionado,
                                      onChanged: (value) {
                                        centroDeTrabalhoNotifier.value = centroDeTrabalho;
                                      },
                                    ),
                                    SizedBox(width: 10.responsive),
                                    Text(
                                      centroDeTrabalho.nome,
                                      style: themeData.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(height: 0),
                            ],
                          ),
                          onTap: () {
                            centroDeTrabalhoNotifier.value = centroDeTrabalho;
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.responsive),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NhidsTertiaryButton(
                  label: translation.fields.cancelar,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                SizedBox(width: 10.responsive),
                NhidsPrimaryButton(
                  label: translation.fields.confirmarSelecao,
                  onPressed: () {
                    widget.chaoDeFabricaFilterController.atividadeFilter = chaoDeFabricaFilterController.atividadeFilter.copyWith(
                      centroDeTrabalho: centroDeTrabalhoNotifier.value,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
