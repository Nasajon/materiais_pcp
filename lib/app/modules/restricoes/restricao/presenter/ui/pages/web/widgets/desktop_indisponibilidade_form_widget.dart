// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';

import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/indisponibilidade_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_card_criar_editar_indisponibilidade_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_card_indisponibilidade_widget.dart';

class DesktopIndisponibilidadeFormWidget extends StatelessWidget {
  final RestricaoFormController restricaoFormController;
  final GlobalKey<FormState> formKey;
  final bool isButtonAtTop;

  const DesktopIndisponibilidadeFormWidget({
    Key? key,
    required this.restricaoFormController,
    required this.formKey,
    this.isButtonAtTop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return RxBuilder(
      builder: (_) {
        Widget addButton = CustomOutlinedButton(
            title: translation.fields.adicionarIndisponibilidade,
            onPressed: () async {
              restricaoFormController.indisponibilidade = IndisponibilidadeEntity.empty();
            });

        if (restricaoFormController.restricao.indisponibilidades.isEmpty && restricaoFormController.indisponibilidade == null) {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 390),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    translation.titles.adicioneUmaIndisponibilidade,
                    style: themeData.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    translation.messages.nenhumaIndisponibilidadeFoiAdicionada,
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
                visible: isButtonAtTop && restricaoFormController.indisponibilidade == null,
                child: addButton,
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ...restricaoFormController.restricao.indisponibilidades.map((indisponibilidade) {
                  index++;
                  if (restricaoFormController.indisponibilidade?.codigo == index) {
                    return DesktopCardCriarEditarIndisponibilidadeWidget(
                      restricaoFormController: restricaoFormController,
                      formKey: formKey,
                    );
                  }

                  return DesktopCardIndisponibilidadeWidget(
                    restricaoFormController: restricaoFormController,
                    indisponibilidade: indisponibilidade,
                  );
                }).toList(),
                if (restricaoFormController.indisponibilidade?.codigo == 0) ...[
                  DesktopCardCriarEditarIndisponibilidadeWidget(
                    restricaoFormController: restricaoFormController,
                    formKey: formKey,
                  ),
                ]
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Visibility(
                visible: !isButtonAtTop && restricaoFormController.indisponibilidade == null,
                child: addButton,
              ),
            )
          ],
        );
      },
    );
  }
}
