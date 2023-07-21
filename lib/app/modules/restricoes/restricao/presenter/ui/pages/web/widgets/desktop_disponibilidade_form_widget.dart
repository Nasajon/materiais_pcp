import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/disponibilidade_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_card_criar_editar_disponibilidade_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_card_disponibilidade_widget.dart';

class DesktopDisponibilidadeFormWidget extends StatelessWidget {
  final RestricaoFormController restricaoFormController;
  final GlobalKey<FormState> formKey;
  final bool isButtonAtTop;

  const DesktopDisponibilidadeFormWidget({
    Key? key,
    required this.restricaoFormController,
    required this.formKey,
    this.isButtonAtTop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return RxBuilder(
      builder: (_) {
        Widget addButton = CustomOutlinedButton(
            title: l10n.fields.adicionarDisponibilidade,
            onPressed: () async {
              restricaoFormController.disponibilidade = DisponibilidadeEntity.empty();
            });

        if (restricaoFormController.restricao.disponibilidades.isEmpty && restricaoFormController.disponibilidade == null) {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 390),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    l10n.titles.adicioneUmaDisponibilidade,
                    style: themeData.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.messages.nenhumaDisponibilidadeFoiAdicionada,
                    textAlign: TextAlign.center,
                    style: themeData.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  addButton,
                ],
              ),
            ),
          );
        }

        int index = 0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Visibility(
                visible: isButtonAtTop && restricaoFormController.disponibilidade == null,
                child: addButton,
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ...restricaoFormController.restricao.disponibilidades.map((disponibilidade) {
                  index++;
                  if (restricaoFormController.disponibilidade?.codigo == index) {
                    return DesktopCardCriarEditarDisponibilidadeWidget(
                      restricaoFormController: restricaoFormController,
                      formKey: formKey,
                    );
                  }

                  return DesktopCardDisponibilidadeWidget(
                    restricaoFormController: restricaoFormController,
                    disponibilidade: disponibilidade,
                  );
                }).toList(),
                if (restricaoFormController.disponibilidade?.codigo == 0) ...[
                  DesktopCardCriarEditarDisponibilidadeWidget(
                    restricaoFormController: restricaoFormController,
                    formKey: formKey,
                  ),
                ]
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Visibility(
                visible: !isButtonAtTop && restricaoFormController.disponibilidade == null,
                child: addButton,
              ),
            )
          ],
        );
      },
    );
  }
}
