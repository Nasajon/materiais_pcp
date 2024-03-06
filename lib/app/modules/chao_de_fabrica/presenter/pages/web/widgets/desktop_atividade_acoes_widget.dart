// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_apontar_evolucao_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_apontamento_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_atividade_by_id_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';

class DesktopAtividadeAcoesWidget extends StatefulWidget {
  final RxNotifier<ChaoDeFabricaAtividadeAggregate> atividadeNotifier;
  final ChaoDeFabricaListStore chaoDeFabricaListStore;
  final ChaoDeFabricaApontamentoStore apontamentoStore;
  final ChaoDeFabricaAtividadeByIdStore atividadeByIdStore;

  const DesktopAtividadeAcoesWidget({
    Key? key,
    required this.atividadeNotifier,
    required this.chaoDeFabricaListStore,
    required this.apontamentoStore,
    required this.atividadeByIdStore,
  }) : super(key: key);

  @override
  State<DesktopAtividadeAcoesWidget> createState() => _DesktopAtividadeAcoesWidgetState();
}

class _DesktopAtividadeAcoesWidgetState extends State<DesktopAtividadeAcoesWidget> {
  RxNotifier<ChaoDeFabricaAtividadeAggregate> get atividadeNotifier => widget.atividadeNotifier;
  ChaoDeFabricaListStore get chaoDeFabricaListStore => widget.chaoDeFabricaListStore;
  ChaoDeFabricaApontamentoStore get apontamentoStore => widget.apontamentoStore;
  ChaoDeFabricaAtividadeByIdStore get atividadeByIdStore => widget.atividadeByIdStore;

  @override
  Widget build(BuildContext context) {
    final List<Widget> listWidget = [];

    final atividade = atividadeNotifier.value;

    final acaoIniciarPreparacao = NhidsSecondaryButton(
      title: translation.fields.iniciarPreparacao,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.emPreparacao);
        setState(() {});
      },
    );
    final acaoIniciarAtividade = NhidsSecondaryButton(
      title: translation.fields.iniciarAtividade,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.iniciada);
        setState(() {});
      },
    );
    final acaoPausarAtividade = NhidsSecondaryButton(
      title: translation.fields.pausarAtividade,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.pausada);
        setState(() {});
      },
    );
    final acaoContinuarAtividade = NhidsSecondaryButton(
      title: translation.fields.continuarAtividade,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.iniciada);
        setState(() {});
      },
    );
    final acaoFinalizarAtividade = NhidsSecondaryButton(
      title: translation.fields.finalizarAtividade,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.encerrada);
        setState(() {});
      },
    );
    final acaoApontarEvolucao = NhidsSecondaryButton(
      title: translation.fields.apontarEvolucao,
      onPressed: () {
        Asuka.showDialog(builder: (context) {
          return Dialog.fullscreen(
            child: DesktopApontarEvolucaoWidget(
              atividade: atividade,
              apontamentoStore: apontamentoStore,
              atividadeByIdStore: atividadeByIdStore,
            ),
          );
        });
      },
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
        NhidsTertiaryButton(
          title: translation.fields.fechar,
          onPressed: () => Navigator.of(context).pop(),
        ),
        paddingSize,
        ...listWidget,
      ],
    );
  }
}
