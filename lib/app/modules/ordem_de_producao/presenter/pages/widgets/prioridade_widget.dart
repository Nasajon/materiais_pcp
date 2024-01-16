// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/enums/prioridade_enum.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/ordem_de_producao_controller.dart';

class PrioridadeWidget extends StatelessWidget {
  final OrdemDeProducaoController ordemDeProducaoController;
  final bool isEnabledForm;

  const PrioridadeWidget({
    Key? key,
    required this.ordemDeProducaoController,
    required this.isEnabledForm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translation.fields.prioridade,
          style: themeData.textTheme.labelLarge,
        ),
        const SizedBox(height: 4),
        SegmentedButton(
          showSelectedIcon: false,
          selected: <PrioridadeEnum>{ordemDeProducaoController.ordemDeProducao.prioridade},
          segments: PrioridadeEnum.values
              .map(
                (e) => ButtonSegment<PrioridadeEnum>(
                  value: e,
                  label: Text(
                    e.name,
                    style: themeData.textTheme.labelLarge?.copyWith(color: colorTheme?.primary),
                  ),
                ),
              )
              .toList(),
          onSelectionChanged: (value) {
            if (isEnabledForm) {
              ordemDeProducaoController.ordemDeProducao = ordemDeProducaoController.ordemDeProducao.copyWith(prioridade: value.first);
            }
          },
          style: ButtonStyle(
            side: MaterialStatePropertyAll(
              BorderSide(color: colorTheme?.primary ?? Colors.transparent),
            ),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 16, horizontal: 36),
            ),
          ),
        ),
      ],
    );
  }
}
