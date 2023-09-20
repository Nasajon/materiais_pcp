// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/roteiro_controller.dart';

class MobilePeriodoFormWidget extends StatelessWidget {
  final RoteiroController roteiroController;

  const MobilePeriodoFormWidget({
    Key? key,
    required this.roteiroController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [roteiroController.roteiro]);

    final roteiro = roteiroController.roteiro;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translation.messages.mensagemSelecionePeriodoVigencia,
            style: themeData.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translation.fields.inicio,
                style: themeData.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorTheme?.border ?? Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CalendarDatePicker(
                  initialDate: roteiro.inicio.getDate() ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2030),
                  onDateChanged: (value) {
                    roteiroController.roteiro = roteiro.copyWith(inicio: DateVO.date(value));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translation.fields.fim,
                style: themeData.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorTheme?.border ?? Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CalendarDatePicker(
                  initialDate: roteiro.fim.getDate() ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2030),
                  onDateChanged: (value) {
                    roteiroController.roteiro = roteiro.copyWith(fim: DateVO.date(value));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
