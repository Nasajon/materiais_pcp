import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/mobile/widgets/mobile_card_sequenciamento_object_widget.dart';

class MobileSquenciamentoWidget extends StatelessWidget {
  final SequenciamentoController sequenciamentoController;

  const MobileSquenciamentoWidget({
    Key? key,
    required this.sequenciamentoController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          MobileCardSequenciamentoObjectWidget(
            title: translation.fields.recursos,
            sequenciamentoObject: sequenciamentoController.sequenciamento.sequenciamentoRecursos,
          ),
          if (sequenciamentoController.sequenciamento.sequenciamentoRestricoes.isNotEmpty) ...{
            const SizedBox(height: 16),
            MobileCardSequenciamentoObjectWidget(
              title: translation.fields.restricoes,
              sequenciamentoObject: sequenciamentoController.sequenciamento.sequenciamentoRestricoes,
            ),
          }
        ],
      ),
    );
  }
}
