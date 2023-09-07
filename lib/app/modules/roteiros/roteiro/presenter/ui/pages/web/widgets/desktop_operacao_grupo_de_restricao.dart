// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_restricao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/recurso_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_restricao_widget.dart';

class DesktopOperacaoGrupoDeRescricaoWidget extends StatelessWidget {
  final RecursoController recursoController;

  const DesktopOperacaoGrupoDeRescricaoWidget({
    Key? key,
    required this.recursoController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              translation.titles.grupoDeRestricoes,
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),
            if (recursoController.listGrupoDeRestricaoController.isNotEmpty)
              ...recursoController.listGrupoDeRestricaoController
                  .map((controller) => ExpansionGrupoDeRescricaoWidget(
                        recursoController: recursoController,
                        grupoDeRestricaoController: controller,
                      ))
                  .toList()
            else
              Center(
                child: Column(
                  children: [
                    Text(
                      translation.titles.semRestricoes,
                      style: themeData.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      translation.messages.mensagemAdicioneUmaOuMaisRestricoes,
                      style: themeData.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class ExpansionGrupoDeRescricaoWidget extends StatelessWidget {
  final RecursoController recursoController;
  final GrupoDeRestricaoController grupoDeRestricaoController;

  const ExpansionGrupoDeRescricaoWidget({
    Key? key,
    required this.recursoController,
    required this.grupoDeRestricaoController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [grupoDeRestricaoController.grupoDeRestricao]);

    final grupoDeRestricao = grupoDeRestricaoController.grupoDeRestricao;

    // Usar 250w, 10 minutos durante a operação
    var textoDaTag = '';
    // Usar
    textoDaTag += '${translation.fields.usar} ';
    // 250
    textoDaTag += grupoDeRestricao.capacidade.usar.formatDoubleToString(decimalDigits: grupoDeRestricao.capacidade.unidade.decimal);
    // w,
    textoDaTag += '${grupoDeRestricao.capacidade.unidade.codigo.toLowerCase()}, ';
    // 10 minutos
    textoDaTag += '${grupoDeRestricao.capacidade.tempo.formatDuration()} ';
    // durante a operação
    textoDaTag += grupoDeRestricao.quando?.name.toLowerCase() ?? '';

    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      collapsedTextColor: colorTheme?.text,
      textColor: colorTheme?.text,
      iconColor: colorTheme?.text,
      collapsedIconColor: colorTheme?.text,
      backgroundColor: colorTheme?.background,
      shape: Border.all(color: colorTheme?.background ?? Colors.transparent),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(grupoDeRestricao.grupo.nome),
          const Spacer(),
          TagWidget(
            title: textoDaTag,
            titleColor: colorTheme?.text,
            borderColor: colorTheme?.text,
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              FontAwesomeIcons.ellipsisVertical,
              size: 18,
              color: colorTheme?.icons ?? Colors.transparent,
            ),
            splashRadius: 20,
          ),
        ],
      ),
      children: [
        Divider(color: colorTheme?.border, height: 1),
        ...grupoDeRestricaoController.listRestricaoController
            .map(
              (restricaoController) => DesktopOperacaoRestricaoWidget(
                grupoRestricaoId: grupoDeRestricaoController.grupoDeRestricao.grupo.id,
                recursoController: recursoController,
                restricaoController: restricaoController,
                unidade: grupoDeRestricao.capacidade.unidade,
              ),
            )
            .toList(),
      ],
    );
  }
}
