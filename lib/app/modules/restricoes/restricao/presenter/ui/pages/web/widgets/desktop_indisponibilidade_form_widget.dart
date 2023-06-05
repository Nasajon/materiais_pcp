import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/controllers/restricao_form_controller.dart';

class DesktopIndisponibilidadeFormWidget extends StatelessWidget {
  final RestricaoFormController restricaoFormController;

  const DesktopIndisponibilidadeFormWidget({
    Key? key,
    required this.restricaoFormController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    Widget addButton = CustomOutlinedButton(title: 'Adicionar indisponibilidade', onPressed: () {});

    if (restricaoFormController.restricao.indisponibilidades.isEmpty) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 390),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                'Adicione uma indisponibilidade',
                style: themeData.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Text(
                'Nenhuma indisponibilidade foi adicionada. Adicione uma indisponibilidade clicando no botão abaixo.',
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

    return Container();
  }
}
