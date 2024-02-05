import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/controllers/chao_de_fabrica_filter_controller.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_recurso_store.dart';

class DesktopSelecionarRecursoWidget extends StatefulWidget {
  final ChaoDeFabricaRecursoStore recursoStore;
  final ChaoDeFabricaFilterController chaoDeFabricaFilterController;

  const DesktopSelecionarRecursoWidget({
    Key? key,
    required this.recursoStore,
    required this.chaoDeFabricaFilterController,
  }) : super(key: key);

  @override
  State<DesktopSelecionarRecursoWidget> createState() => _DesktopSelecionarRecursoWidgetState();
}

class _DesktopSelecionarRecursoWidgetState extends State<DesktopSelecionarRecursoWidget> {
  ChaoDeFabricaRecursoStore get recursoStore => widget.recursoStore;
  ChaoDeFabricaFilterController get chaoDeFabricaFilterController => widget.chaoDeFabricaFilterController;

  late final Disposer recursoDispose;
  final isLoadingNotifier = ValueNotifier(false);
  final recursoNotifier = ValueNotifier<List<ChaoDeFabricaRecursoEntity>>([]);

  @override
  void initState() {
    super.initState();
    recursoStore.getCentrosDeTrabalhos('', delay: Duration.zero);

    recursoNotifier.value = chaoDeFabricaFilterController.atividadeFilter.recursos;

    recursoDispose = recursoStore.observer(
      onLoading: (value) => isLoadingNotifier.value = value,
      onState: (_) => isLoadingNotifier.value = false,
    );
  }

  bool verificarRecurso(ChaoDeFabricaRecursoEntity recurso) {
    for (var recursoNotifier in recursoNotifier.value) {
      if (recurso == recursoNotifier) {
        return true;
      }
    }

    return false;
  }

  void adicionarRemoverRecurso(ChaoDeFabricaRecursoEntity recurso) {
    final listRecurso = [...recursoNotifier.value];

    if (verificarRecurso(recurso)) {
      listRecurso.remove(recurso);
    } else {
      listRecurso.add(recurso);
    }

    recursoNotifier.value = listRecurso;
  }

  @override
  void dispose() {
    recursoDispose();
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
                  translation.titles.selecione(translation.fields.recurso),
                  style: themeData.textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                TextFormFieldWidget(
                  label: '',
                  hintText: translation.messages.pesquiseUmaEntidade(translation.fields.recurso),
                  onChanged: (value) => recursoStore.getCentrosDeTrabalhos(value),
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: isLoadingNotifier,
              builder: (_, isLoading, __) {
                final listRecurso = recursoStore.state;
                return ValueListenableBuilder(
                  valueListenable: recursoNotifier,
                  builder: (_, recurso, __) {
                    return ListView.builder(
                      itemCount: listRecurso.length,
                      padding: const EdgeInsets.all(14),
                      itemBuilder: (_, index) {
                        final recursoIndex = listRecurso[index];

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
                                      value: verificarRecurso(recursoIndex),
                                      onChanged: (value) {
                                        adicionarRemoverRecurso(recursoIndex);
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      recursoIndex.nome,
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
                            adicionarRemoverRecurso(recursoIndex);
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
                      recursos: recursoNotifier.value,
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
