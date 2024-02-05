import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/enums/artigo_enum.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/controllers/chao_de_fabrica_filter_controller.dart';

class DesktopSelecionarSituacaoWidget extends StatefulWidget {
  final ChaoDeFabricaFilterController chaoDeFabricaFilterController;

  const DesktopSelecionarSituacaoWidget({
    Key? key,
    required this.chaoDeFabricaFilterController,
  }) : super(key: key);

  @override
  State<DesktopSelecionarSituacaoWidget> createState() => _DesktopSelecionarSituacaoWidgetState();
}

class _DesktopSelecionarSituacaoWidgetState extends State<DesktopSelecionarSituacaoWidget> {
  ChaoDeFabricaFilterController get chaoDeFabricaFilterController => widget.chaoDeFabricaFilterController;

  final isLoadingNotifier = ValueNotifier(false);
  final atividadeStatusNotifier = ValueNotifier<List<AtividadeStatusEnum>>([]);

  @override
  void initState() {
    super.initState();

    atividadeStatusNotifier.value = chaoDeFabricaFilterController.atividadeFilter.atividadeStatus;
  }

  bool verificarSituacao(AtividadeStatusEnum atividadeStatus) {
    for (var atividadeStatusNotifier in atividadeStatusNotifier.value) {
      if (atividadeStatus == atividadeStatusNotifier) {
        return true;
      }
    }

    return false;
  }

  void adicionarRemoverSituacao(AtividadeStatusEnum atividadeStatus) {
    final listSituacao = [...atividadeStatusNotifier.value];

    if (verificarSituacao(atividadeStatus)) {
      listSituacao.remove(atividadeStatus);
    } else {
      listSituacao.add(atividadeStatus);
    }

    atividadeStatusNotifier.value = listSituacao;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              translation.titles.selecione(translation.fields.situacao, artigo: ArtigoEnum.artigoFeminino),
              style: themeData.textTheme.titleLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            ValueListenableBuilder(
              valueListenable: isLoadingNotifier,
              builder: (_, isLoading, __) {
                return ValueListenableBuilder(
                  valueListenable: atividadeStatusNotifier,
                  builder: (_, atividadeStatus, __) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: AtividadeStatusEnum.values.map((status) {
                        return ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          minVerticalPadding: 0,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: verificarSituacao(status),
                                    onChanged: (value) {
                                      adicionarRemoverSituacao(status);
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    status.name,
                                    style: themeData.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            adicionarRemoverSituacao(status);
                          },
                        );
                      }).toList(),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 14),
            Row(
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
                      atividadeStatus: atividadeStatusNotifier.value,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
