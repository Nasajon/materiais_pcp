import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/enums/artigo_enum.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/controllers/chao_de_fabrica_filter_controller.dart';

class DesktopSelecionarDataWidget extends StatefulWidget {
  final ChaoDeFabricaFilterController chaoDeFabricaFilterController;

  const DesktopSelecionarDataWidget({
    Key? key,
    required this.chaoDeFabricaFilterController,
  }) : super(key: key);

  @override
  State<DesktopSelecionarDataWidget> createState() => _DesktopSelecionarDataWidgetState();
}

class _DesktopSelecionarDataWidgetState extends State<DesktopSelecionarDataWidget> {
  ChaoDeFabricaFilterController get chaoDeFabricaFilterController => widget.chaoDeFabricaFilterController;

  final isLoadingNotifier = ValueNotifier(false);
  final dataInicialNotifier = ValueNotifier(DateTime.now());
  final dataFinalNotifier = ValueNotifier(DateTime.now());

  @override
  void initState() {
    super.initState();

    dataInicialNotifier.value = chaoDeFabricaFilterController.atividadeFilter.dataInicial.getDate() ?? DateTime.now();
    dataFinalNotifier.value = chaoDeFabricaFilterController.atividadeFilter.dataFinal.getDate() ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              translation.titles.selecione(translation.fields.data, artigo: ArtigoEnum.artigoFeminino),
              style: themeData.textTheme.titleLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            ValueListenableBuilder(
              valueListenable: dataInicialNotifier,
              builder: (_, dataInicial, __) {
                return ValueListenableBuilder(
                    valueListenable: dataFinalNotifier,
                    builder: (_, dataFinal, __) {
                      return CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.range,
                        ),
                        value: [dataInicial, dataFinal],
                        onValueChanged: (values) {
                          if (values.length == 2) {
                            dataInicialNotifier.value = values[0] ?? DateTime.now();
                            dataFinalNotifier.value = values[1] ?? DateTime.now();
                          }
                        },
                      );
                    });
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
                      dataInicial: DateVO.date(dataInicialNotifier.value),
                      dataFinal: DateVO.date(dataFinalNotifier.value),
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
