// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/grupo_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';

class MobileCardGrupoDeRestricoeWidget extends StatelessWidget {
  final GrupoDeRestricaoEntity grupoDeRestricao;
  final SequenciamentoController sequenciamentoController;

  const MobileCardGrupoDeRestricoeWidget({
    Key? key,
    required this.grupoDeRestricao,
    required this.sequenciamentoController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorTheme?.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colorTheme?.border ?? Colors.grey,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ValueListenableBuilder(
                valueListenable: sequenciamentoController.restricaoIdsNotifier,
                builder: (context, value, child) {
                  return ExpansionTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    collapsedTextColor: colorTheme?.text,
                    textColor: colorTheme?.text,
                    iconColor: colorTheme?.text,
                    collapsedIconColor: colorTheme?.text,
                    backgroundColor: colorTheme?.background,
                    shape: Border.all(color: colorTheme?.background ?? Colors.transparent),
                    title: Text(
                      grupoDeRestricao.nome,
                      style: themeData.textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    children: [
                      Divider(color: colorTheme?.border, height: 1),
                      ...grupoDeRestricao.restricoes.map((restricao) {
                        return CheckboxListTile(
                          title: Text(restricao.nome),
                          value: value.contains(restricao.id),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            if (value != null && value) {
                              sequenciamentoController.addRestricaoId(restricao.id);
                            } else {
                              sequenciamentoController.removeRestricaoId(restricao.id);
                            }
                          },
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
