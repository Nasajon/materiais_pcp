// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/desktop_chao_de_fabrica_atividade_gestor_page.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_apontamento_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_atividade_by_id_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_finalizar_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';

class ChaoDeFabricaAtividadeGestorPage extends StatefulWidget {
  final String id;
  final ChaoDeFabricaListStore chaoDeFabricaListStore;
  final ChaoDeFabricaAtividadeByIdStore atividadeByIdStore;
  final ChaoDeFabricaApontamentoStore apontamentoStore;
  final ChaoDeFabricaFinalizarStore finalizarStore;

  const ChaoDeFabricaAtividadeGestorPage({
    Key? key,
    required this.id,
    required this.chaoDeFabricaListStore,
    required this.atividadeByIdStore,
    required this.apontamentoStore,
    required this.finalizarStore,
  }) : super(key: key);

  @override
  State<ChaoDeFabricaAtividadeGestorPage> createState() => _ChaoDeFabricaAtividadeGestorPageState();
}

class _ChaoDeFabricaAtividadeGestorPageState extends State<ChaoDeFabricaAtividadeGestorPage> {
  String get id => widget.id;
  ChaoDeFabricaListStore get chaoDeFabricaListStore => widget.chaoDeFabricaListStore;
  ChaoDeFabricaAtividadeByIdStore get atividadeByIdStore => widget.atividadeByIdStore;
  ChaoDeFabricaApontamentoStore get apontamentoStore => widget.apontamentoStore;
  ChaoDeFabricaFinalizarStore get finalizarStore => widget.finalizarStore;

  @override
  void initState() {
    super.initState();

    if (id.isEmpty) {
      Modular.to.pop();
      // TODO: Mensagem para o usuario
      return;
    }

    atividadeByIdStore.getAtividade(id);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<ChaoDeFabricaAtividadeByIdStore, ChaoDeFabricaAtividadeAggregate>(
      store: atividadeByIdStore,
      onLoading: (_) => const Center(child: CircularProgressIndicator()),
      onError: (_, error) {
        Modular.to.pop();
        return const SizedBox.shrink();
      },
      onState: (_, atividade) {
        if (atividade == ChaoDeFabricaAtividadeAggregate.empty()) {
          Modular.to.pop();
          // TODO: Mensagem para o usuario
        }

        final desktopPage = DesktopChaoDeFabricaAtividadeGestorPage(
          atividade: atividade,
          chaoDeFabricaListStore: chaoDeFabricaListStore,
          atividadeByIdStore: atividadeByIdStore,
          apontamentoStore: apontamentoStore,
          finalizarStore: finalizarStore,
        );

        return NhidsAdaptive(
          mobilePage: Container(),
          desktopPage: desktopPage,
        );
      },
    );
  }
}
