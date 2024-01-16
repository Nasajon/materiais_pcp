// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/controllers/restricao_controller.dart';

class DesktopOperacaoEditarRestricaoWidget extends StatefulWidget {
  final RestricaoController restricaoController;
  final UnidadeEntity unidade;

  DesktopOperacaoEditarRestricaoWidget({
    Key? key,
    required this.restricaoController,
    required this.unidade,
  }) : super(key: key);

  @override
  State<DesktopOperacaoEditarRestricaoWidget> createState() => _DesktopOperacaoEditarRestricaoWidgetState();
}

class _DesktopOperacaoEditarRestricaoWidgetState extends State<DesktopOperacaoEditarRestricaoWidget> {
  late final novoRestricaoController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    novoRestricaoController = widget.restricaoController.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [novoRestricaoController.restricao]);

    final restricao = novoRestricaoController.restricao;

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
              label: translation.fields.capacidade,
              initialValue: restricao.capacidade.capacidade.valueOrNull,
              suffixSymbol: widget.unidade.codigo,
              decimalDigits: widget.unidade.decimal,
              validator: (_) => restricao.capacidade.capacidade.errorMessage,
              onChanged: (value) {
                final capacidade = restricao.capacidade.copyWith(capacidade: DoubleVO(value));
                novoRestricaoController.restricao = restricao.copyWith(capacidade: capacidade);
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextButton(
                  title: translation.fields.cancelar,
                  onPressed: () {
                    if (novoRestricaoController != widget.restricaoController) {}

                    Navigator.of(context).pop(null);
                  },
                ),
                const SizedBox(width: 10),
                CustomPrimaryButton(
                  title: translation.fields.adicionar,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).pop(novoRestricaoController);
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
