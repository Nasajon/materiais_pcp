// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showDialog;

import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_material_dialog_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';

class DesktopOperacaoWidget extends StatelessWidget {
  final GetOperacaoStore getOperacaoStore;

  const DesktopOperacaoWidget({
    Key? key,
    required this.getOperacaoStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ScopedBuilder<GetOperacaoStore, List<OperacaoAggregate>>(
      store: getOperacaoStore,
      onState: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translation.fields.operacoes,
              style: themeData.textTheme.titleLarge?.copyWith(
                fontSize: 20,
              ),
            ),
            if (state.isEmpty)
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      translation.fields.semOperacoes,
                      style: themeData.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      translation.messages.selecioneRoteiroExibirOperacoes,
                      style: themeData.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ...state.map((operacao) => RoteiroOperacaoWidget(operacao: operacao)).toList(),
          ],
        );
      },
    );
  }
}

class RoteiroOperacaoWidget extends StatelessWidget {
  final OperacaoAggregate operacao;

  const RoteiroOperacaoWidget({
    Key? key,
    required this.operacao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    var quantidadeRecursos = 0;

    operacao.grupoDeRecursos.forEach((grupo) {
      quantidadeRecursos += grupo.recursos.length;
    });

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorTheme?.border ?? Colors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorTheme?.primary ?? Colors.transparent),
            ),
            child: Center(
              child: Text(
                '${operacao.ordem}',
                style: themeData.textTheme.labelSmall?.copyWith(
                  color: colorTheme?.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Text(
            operacao.nome,
            style: themeData.textTheme.bodyMedium,
          ),
          const Spacer(),
          TagWidget(
            title: operacao.centroDeTrabalho.nome,
            sizeBorder: 1,
          ),
          const SizedBox(width: 10),
          TagWidget(
            title: operacao.materiais.length == 1
                ? '${operacao.materiais.length} ${translation.fields.material.toLowerCase()}'
                : '${operacao.materiais.length} ${translation.fields.materiais.toLowerCase()}',
            sizeBorder: 1,
            borderColor: colorTheme?.text,
            titleColor: colorTheme?.text,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: DesktopMaterialDialogWidget(materiais: operacao.materiais),
                  );
                },
              );
            },
          ),
          const SizedBox(width: 10),
          TagWidget(
            title: quantidadeRecursos == 1
                ? '$quantidadeRecursos  ${translation.fields.recursoApto.toLowerCase()}'
                : '$quantidadeRecursos  ${translation.fields.recursosAptos.toLowerCase()}',
            sizeBorder: 1,
            borderColor: colorTheme?.text,
            titleColor: colorTheme?.text,
          ),
        ],
      ),
    );
  }
}
