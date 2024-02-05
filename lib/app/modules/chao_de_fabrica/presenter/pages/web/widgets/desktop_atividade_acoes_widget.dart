// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';

class DesktopAtividadeAcoesWidget extends StatefulWidget {
  final RxNotifier<ChaoDeFabricaAtividadeAggregate> atividadeNotifier;
  final ChaoDeFabricaListStore chaoDeFabricaListStore;

  const DesktopAtividadeAcoesWidget({
    Key? key,
    required this.atividadeNotifier,
    required this.chaoDeFabricaListStore,
  }) : super(key: key);

  @override
  State<DesktopAtividadeAcoesWidget> createState() => _DesktopAtividadeAcoesWidgetState();
}

class _DesktopAtividadeAcoesWidgetState extends State<DesktopAtividadeAcoesWidget> {
  RxNotifier<ChaoDeFabricaAtividadeAggregate> get atividadeNotifier => widget.atividadeNotifier;
  ChaoDeFabricaListStore get chaoDeFabricaListStore => widget.chaoDeFabricaListStore;

  @override
  Widget build(BuildContext context) {
    final List<Widget> listWidget = [];

    final atividade = atividadeNotifier.value;

    final acaoIniciarPreparacao = CustomOutlinedButton(
      title: translation.fields.iniciarPreparacao,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.emPreparacao);
        setState(() {});
      },
    );
    final acaoIniciarAtividade = CustomOutlinedButton(
      title: translation.fields.iniciarAtividade,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.iniciada);
        setState(() {});
      },
    );
    final acaoPausarAtividade = CustomOutlinedButton(
      title: translation.fields.pausarAtividade,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.pausada);
        setState(() {});
      },
    );
    final acaoContinuarAtividade = CustomOutlinedButton(
      title: translation.fields.continuarAtividade,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.iniciada);
        setState(() {});
      },
    );
    final acaoFinalizarAtividade = CustomOutlinedButton(
      title: translation.fields.finalizarAtividade,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.encerrada);
        setState(() {});
      },
    );
    final acaoApontarEvolucao = CustomOutlinedButton(
      title: translation.fields.apontarEvolucao,
      onPressed: () {},
    );

    const paddingSize = SizedBox(width: 12);

    switch (atividade.status) {
      case AtividadeStatusEnum.aberta:
        if (atividade.fimPreparacaoPlanejado.getDate() != null &&
            atividade.inicioPreparacaoPlanejado.getDate() != null &&
            atividade.fimPreparacaoPlanejado.getDate()!.isAfter(atividade.inicioPreparacaoPlanejado.getDate()!)) {
          listWidget.addAll([acaoIniciarPreparacao]);
        } else {
          listWidget.addAll([acaoIniciarAtividade]);
        }
      case AtividadeStatusEnum.emPreparacao:
        listWidget.addAll([acaoIniciarAtividade]);
      case AtividadeStatusEnum.iniciada:
        listWidget.addAll([acaoApontarEvolucao, paddingSize, acaoPausarAtividade, paddingSize, acaoFinalizarAtividade]);
      case AtividadeStatusEnum.pausada:
        listWidget.addAll([acaoContinuarAtividade]);
      case AtividadeStatusEnum.cancelada:
      case AtividadeStatusEnum.encerrada:
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomTextButton(
          title: translation.fields.fechar,
          onPressed: () => Navigator.of(context).pop(),
        ),
        paddingSize,
        ...listWidget,
      ],
    );
  }
}
