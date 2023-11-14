// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showDialog;
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/recurso_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/restricao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_editar_restricao_widget.dart';

class DesktopOperacaoRestricaoWidget extends StatefulWidget {
  final String grupoRestricaoId;
  final RecursoController recursoController;

  final RestricaoController restricaoController;
  final UnidadeEntity unidade;

  const DesktopOperacaoRestricaoWidget({
    Key? key,
    required this.grupoRestricaoId,
    required this.recursoController,
    required this.restricaoController,
    required this.unidade,
  }) : super(key: key);

  @override
  State<DesktopOperacaoRestricaoWidget> createState() => _DesktopOperacaoRestricaoWidgetState();
}

class _DesktopOperacaoRestricaoWidgetState extends State<DesktopOperacaoRestricaoWidget> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [widget.restricaoController.restricao]);

    final restricao = widget.restricaoController.restricao;

    // Capacidade: 200 w
    var textoDaTag = '${translation.fields.capacidade} ';
    textoDaTag += restricao.capacidade.capacidade.formatDoubleToString(decimalDigits: widget.unidade.decimal);
    // w,
    textoDaTag += widget.unidade.codigo.toLowerCase();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 30, right: 14, bottom: 14),
              child: Row(
                children: [
                  Text(
                    restricao.nome,
                    style: themeData.textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  TagWidget(title: textoDaTag),
                  const SizedBox(width: 10),
                  CustomTextButton(
                    title: translation.fields.editar,
                    style: themeData.textTheme.labelLarge?.copyWith(
                      color: colorTheme?.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    onPressed: () async {
                      final responseModal = await showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: DesktopOperacaoEditarRestricaoWidget(
                              restricaoController: widget.restricaoController,
                              unidade: widget.unidade,
                            ),
                          );
                        },
                      );

                      if (responseModal != null && responseModal is RestricaoController) {
                        var gruposRestricoes = widget.recursoController.recurso.grupoDeRestricoes.map((grupo) {
                          if (grupo.grupo.id == widget.grupoRestricaoId) {
                            return grupo.copyWith(
                              restricoes: grupo.restricoes.map((restricao) {
                                if (restricao.id == responseModal.restricao.id) {
                                  return responseModal.restricao;
                                }
                                return restricao;
                              }).toList(),
                            );
                          }
                          return grupo;
                        }).toList();

                        widget.recursoController.recurso = widget.recursoController.recurso.copyWith(grupoDeRestricoes: gruposRestricoes);

                        setState(() {});
                      }
                    },
                  )
                ],
              ),
            ),
            Divider(color: colorTheme?.border, height: 1),
          ],
        );
      },
    );
  }
}
