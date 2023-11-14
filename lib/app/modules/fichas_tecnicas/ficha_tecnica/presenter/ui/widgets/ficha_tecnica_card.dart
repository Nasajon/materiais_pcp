import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart' hide CardWidget;
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/presenter/widgets/card_widget.dart';

class FichaTecnicaCard extends StatelessWidget implements CardWidget {
  final BuildContext context;

  FichaTecnicaCard({Key? key, required this.context}) : super(key: key) {
    titulo = translation.titles.fichasTecnicas;
    secao = context.l10n.materiaisProducao;
    descricoes = [];
  }

  @override
  late final String titulo;
  @override
  late final String secao;
  @override
  late final List<String> descricoes;

  @override
  String get codigo => 'materiais_pcp_ficha_tecnica';
  @override
  List<String> get funcoes => [];
  @override
  List<String> get permissoes => [];
  @override
  bool get exibirModoDemo => true;
  @override
  int get sistemaId => 318;

  @override
  void onPressed() {
    Modular.to.pushNamed('/pcp/ficha-tecnica');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), offset: Offset.zero, blurRadius: 6, spreadRadius: 2)]),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(
            children: [
              Expanded(child: Text(titulo, style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18))),
              const SizedBox(width: 4),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: 16,
                ),
                color: AnaColors.commonGrey,
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Text('Veja e roteirize suas entregas do dia a dia.', style: AnaTextStyles.grey14Px),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [CustomTextButton(title: context.l10n.materiaisPcpAbrirApp, onPressed: onPressed)],
          )
        ]),
      ),
    );
  }
}
