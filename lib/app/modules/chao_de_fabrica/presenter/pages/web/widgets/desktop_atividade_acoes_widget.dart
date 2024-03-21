// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_apontar_evolucao_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_finalizar_atividade_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_apontamento_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_atividade_by_id_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_finalizar_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';

class DesktopAtividadeAcoesWidget extends StatefulWidget {
  final ValueNotifier<ChaoDeFabricaAtividadeAggregate> atividadeNotifier;
  final ChaoDeFabricaListStore chaoDeFabricaListStore;
  final ChaoDeFabricaApontamentoStore apontamentoStore;
  final ChaoDeFabricaFinalizarStore finalizarStore;
  final ChaoDeFabricaAtividadeByIdStore atividadeByIdStore;
  final MainAxisAlignment mainAxisAlignment;

  const DesktopAtividadeAcoesWidget({
    Key? key,
    required this.atividadeNotifier,
    required this.chaoDeFabricaListStore,
    required this.apontamentoStore,
    required this.finalizarStore,
    required this.atividadeByIdStore,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  State<DesktopAtividadeAcoesWidget> createState() => _DesktopAtividadeAcoesWidgetState();
}

class _DesktopAtividadeAcoesWidgetState extends State<DesktopAtividadeAcoesWidget> {
  ValueNotifier<ChaoDeFabricaAtividadeAggregate> get atividadeNotifier => widget.atividadeNotifier;
  ChaoDeFabricaListStore get chaoDeFabricaListStore => widget.chaoDeFabricaListStore;
  ChaoDeFabricaApontamentoStore get apontamentoStore => widget.apontamentoStore;
  ChaoDeFabricaFinalizarStore get finalizarStore => widget.finalizarStore;
  ChaoDeFabricaAtividadeByIdStore get atividadeByIdStore => widget.atividadeByIdStore;

  @override
  Widget build(BuildContext context) {
    final List<Widget> listWidget = [];

    final atividade = atividadeNotifier.value;

    final acaoIniciarPreparacao = NhidsSecondaryButton(
      label: translation.fields.iniciarPreparacao,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.emPreparacao);
        setState(() {});
      },
    );
    final acaoIniciarAtividade = NhidsSecondaryButton(
      label: translation.fields.iniciarAtividade,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.iniciada);
        setState(() {});
      },
    );
    final acaoPausarAtividade = NhidsSecondaryButton(
      label: translation.fields.pausar,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.pausada);
        setState(() {});
      },
    );
    final acaoContinuarAtividade = NhidsSecondaryButton(
      label: translation.fields.continuar,
      onPressed: () async {
        atividadeNotifier.value =
            await chaoDeFabricaListStore.alterarStatusAtividade(atividade: atividade, novoStatus: AtividadeStatusEnum.iniciada);
        setState(() {});
      },
    );
    final acaoFinalizarAtividade = NhidsPrimaryButton(
      label: translation.fields.finalizar,
      onPressed: () async {
        await Asuka.showDialog(
          builder: (context) {
            return Dialog.fullscreen(
              child: DesktopFinalizarAtividadeWidget(
                atividade: atividade,
                finalizarStore: finalizarStore,
                atividadeByIdStore: atividadeByIdStore,
              ),
            );
          },
        );
      },
    );
    final acaoApontarEvolucao = NhidsSecondaryButton(
      label: translation.fields.apontar,
      onPressed: () async {
        await Asuka.showDialog(
          builder: (context) {
            return Dialog.fullscreen(
              child: DesktopApontarEvolucaoWidget(
                atividade: atividade,
                apontamentoStore: apontamentoStore,
                atividadeByIdStore: atividadeByIdStore,
              ),
            );
          },
        );
      },
    );

    final paddingSize = SizedBox(width: 8.responsive);

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
        if (widget.mainAxisAlignment == MainAxisAlignment.end) {
          listWidget.addAll([acaoPausarAtividade, paddingSize, acaoApontarEvolucao, paddingSize, acaoFinalizarAtividade]);
        } else {
          listWidget.addAll([acaoFinalizarAtividade, paddingSize, acaoApontarEvolucao, paddingSize, acaoPausarAtividade]);
        }
      case AtividadeStatusEnum.pausada:
        listWidget.addAll([acaoContinuarAtividade]);
      case AtividadeStatusEnum.cancelada:
      case AtividadeStatusEnum.encerrada:
    }

    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: listWidget,
    );
  }
}
