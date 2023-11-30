import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_card_sequenciamento_recursos_widget.dart';

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
          DesktopCardSequenciamentoRecursosWidget(sequenciamentosRecursos: sequenciamentoController.sequenciamento.sequenciamentoRecursos),
        ],
      ),
    );
  }
}
