// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/restricao_controller.dart';

class DesktopOperacaoEditarRestricaoWidget extends StatelessWidget {
  final RestricaoController restricaoController;
  final UnidadeEntity unidade;

  DesktopOperacaoEditarRestricaoWidget({
    Key? key,
    required this.restricaoController,
    required this.unidade,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [restricaoController.restricao]);

    final restricao = restricaoController.restricao;

    return Container(
      width: 350,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorTheme?.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              translation.titles.editarEntidade(translation.fields.restricao),
              style: themeData.textTheme.titleLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            DoubleTextFormFieldWidget(
              label: translation.fields.usar,
              initialValue: restricao.capacidade.usar.valueOrNull,
              suffixSymbol: unidade.codigo,
              decimalDigits: unidade.decimal,
              validator: (_) => restricao.capacidade.usar.errorMessage,
              onChanged: (value) {
                final usar = restricao.capacidade.copyWith(usar: DoubleVO(value));
                restricaoController.restricao = restricao.copyWith(capacidade: usar);
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextButton(
                  title: translation.fields.cancelar,
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                ),
                const SizedBox(width: 10),
                CustomPrimaryButton(
                  title: translation.fields.adicionar,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).pop(restricaoController);
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
