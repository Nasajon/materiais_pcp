import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_card_sequenciamento_object_widget.dart';

class DesktopSquenciamentoWidget extends StatelessWidget {
  final SequenciamentoController sequenciamentoController;

  const DesktopSquenciamentoWidget({
    Key? key,
    required this.sequenciamentoController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          DesktopCardSequenciamentoObjectWidget(
            title: translation.fields.recursos,
            sequenciamentoObject: sequenciamentoController.sequenciamento.sequenciamentoRecursos,
          ),
          if (sequenciamentoController.sequenciamento.sequenciamentoRestricoes.isNotEmpty) ...{
            const SizedBox(height: 16),
            DesktopCardSequenciamentoObjectWidget(
              title: translation.fields.restricoes,
              sequenciamentoObject: sequenciamentoController.sequenciamento.sequenciamentoRestricoes,
            ),
          }
        ],
      ),
    );
  }
}
