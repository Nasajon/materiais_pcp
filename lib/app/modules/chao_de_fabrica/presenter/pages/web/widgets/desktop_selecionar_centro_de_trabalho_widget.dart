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
  final centroDeTrabalhoNotifier = ValueNotifier<List<ChaoDeFabricaCentroDeTrabalhoEntity>>([]);

  @override
  void initState() {
    super.initState();
    centroDeTrabalhoStore.getCentrosDeTrabalhos('', delay: Duration.zero);

    centroDeTrabalhoNotifier.value = chaoDeFabricaFilterController.atividadeFilter.centrosDeTrabalhos;

    centroDeTrabalhoDispose = centroDeTrabalhoStore.observer(
      onLoading: (value) => isLoadingNotifier.value = value,
      onState: (_) => isLoadingNotifier.value = false,
    );
  }

  bool verificarCentroDeTrabalho(ChaoDeFabricaCentroDeTrabalhoEntity centroDeTrabalho) {
    for (var centroDeTrabalhoNotifier in centroDeTrabalhoNotifier.value) {
      if (centroDeTrabalho == centroDeTrabalhoNotifier) {
        return true;
      }
    }

    return false;
  }

  void adicionarRemoverCentroDeTrabalho(ChaoDeFabricaCentroDeTrabalhoEntity centroDeTrabalho) {
    final listCentroDeTrabalho = [...centroDeTrabalhoNotifier.value];

    if (verificarCentroDeTrabalho(centroDeTrabalho)) {
      listCentroDeTrabalho.remove(centroDeTrabalho);
    } else {
      listCentroDeTrabalho.add(centroDeTrabalho);
    }

    centroDeTrabalhoNotifier.value = listCentroDeTrabalho;
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
      constraints: const BoxConstraints(maxHeight: 500, maxWidth: 550),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 14),
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
                const SizedBox(height: 14),
                TextFormFieldWidget(
                  label: '',
                  hintText: translation.messages.pesquiseUmaEntidade(translation.fields.centroDeTrabalho),
                  onChanged: (value) => centroDeTrabalhoStore.getCentrosDeTrabalhos(value),
                ),
                const SizedBox(height: 14),
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
                  builder: (_, centroDeTrabalho, __) {
                    return ListView.builder(
                      itemCount: listCentroDeTrabalho.length,
                      padding: const EdgeInsets.all(14),
                      itemBuilder: (_, index) {
                        final centroDeTrabalhoIndex = listCentroDeTrabalho[index];

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
                                    Checkbox(
                                      value: verificarCentroDeTrabalho(centroDeTrabalhoIndex),
                                      onChanged: (value) {
                                        adicionarRemoverCentroDeTrabalho(centroDeTrabalhoIndex);
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      centroDeTrabalhoIndex.nome,
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
                            adicionarRemoverCentroDeTrabalho(centroDeTrabalhoIndex);
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
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextButton(
                  title: translation.fields.cancelar,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 10),
                CustomPrimaryButton(
                  title: translation.fields.confirmarSelecao,
                  onPressed: () {
                    widget.chaoDeFabricaFilterController.atividadeFilter = chaoDeFabricaFilterController.atividadeFilter.copyWith(
                      centrosDeTrabalhos: centroDeTrabalhoNotifier.value,
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
