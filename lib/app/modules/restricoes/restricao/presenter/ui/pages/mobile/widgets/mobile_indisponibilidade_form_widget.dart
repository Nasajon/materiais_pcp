import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/indisponibilidade_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/mobile/widgets/mobile_card_indisponibilidade_widget.dart';

class MobileIndisponibilidadeFormWidget extends StatelessWidget {
  final RestricaoFormController restricaoFormController;
  final bool isButtonAtTop;

  const MobileIndisponibilidadeFormWidget({
    Key? key,
    required this.restricaoFormController,
    this.isButtonAtTop = false,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: constraints.maxWidth - 32,
            child: RxBuilder(
              builder: (_) {
                Widget addButton = CustomOutlinedButton(
                    title: l10n.fields.adicionarIndisponibilidade,
                    onPressed: () async {
                      restricaoFormController.indisponibilidade = IndisponibilidadeEntity.empty();

                      Modular.to.pushNamed('/pcp/restricoes/indisponibilidade');
                    });

                if (restricaoFormController.restricao.indisponibilidades.isEmpty && restricaoFormController.indisponibilidade == null) {
                  return Column(
                    children: [
                      Text(
                        l10n.titles.adicioneUmaIndisponibilidade,
                        style: themeData.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.messages.nenhumaIndisponibilidadeFoiAdicionada,
                        textAlign: TextAlign.center,
                        style: themeData.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      addButton,
                    ],
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
                          // if (restricaoFormController.disponibilidade?.codigo == index) {
                          //   return DesktopCardCriarEditarIndisponibilidadeWidget(
                          //     restricaoFormController: restricaoFormController,
                          //     formKey: formKey,
                          //   );
                          // }

                          return MobileCardIndisponibilidadeWidget(
                            restricaoFormController: restricaoFormController,
                            indisponibilidade: indisponibilidade,
                          );
                        }).toList(),
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
            ),
          ),
        );
      },
    );
  }
}
