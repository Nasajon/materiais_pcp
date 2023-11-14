import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/deletar_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/ordem_de_producao_list_store.dart';

class OrdemDeProducaoItemWidget extends StatelessWidget {
  final OrdemDeProducaoAggregate ordemDeProducao;
  final DeletarOrdemDeProducaoStore deletarOrdemDeProducaoStore;
  final OrdemDeProducaoListStore ordemDeProducaoListStore;

  const OrdemDeProducaoItemWidget({
    Key? key,
    required this.ordemDeProducao,
    required this.deletarOrdemDeProducaoStore,
    required this.ordemDeProducaoListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return TripleBuilder<DeletarOrdemDeProducaoStore, bool>(
        store: deletarOrdemDeProducaoStore,
        builder: (context, triple) {
          if (triple.state && !triple.isLoading) {
            ordemDeProducaoListStore.deletarOrdemDeProducao(ordemDeProducao.id);
            NotificationSnackBar.showSnackBar(
              translation.messages.excluirUmaEntidade(translation.titles.centroDeTrabalho),
              themeData: themeData,
            );
          }

          final error = triple.error;
          if (error is Failure && !triple.isLoading) {
            Asuka.showDialog(
              barrierColor: Colors.black38,
              builder: (context) {
                return ErrorModal(errorMessage: (triple.error as Failure).errorMessage ?? '');
              },
            );
          }
          return ListTileWidget(
            key: key,
            title: ordemDeProducao.produto.nome,
            subtitle: '',
            trailing: !triple.isLoading
                ? PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: colorTheme?.icons,
                    ),
                    onSelected: (value) {
                      if (value == translation.fields.visualizar) {
                        Modular.to.pushNamed('./${ordemDeProducao.id}');
                      } else if (value == translation.fields.excluir) {
                        Asuka.showDialog(
                          barrierColor: Colors.black38,
                          builder: (context) {
                            return ConfirmationModalWidget(
                              title: translation.titles.excluirEntidade(translation.titles.centroDeTrabalho),
                              messages: translation.messages.excluirUmaEntidade(translation.titles.centroDeTrabalho),
                              titleCancel: translation.fields.excluir,
                              titleSuccess: translation.fields.cancelar,
                              onCancel: () => deletarOrdemDeProducaoStore.deletarOrdemDeProducaoPorId(ordemDeProducao.id),
                            );
                          },
                        );
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<String>(
                          value: translation.fields.visualizar,
                          child: Text(translation.fields.visualizar),
                        ),
                        PopupMenuItem<String>(
                          value: translation.fields.excluir,
                          child: Text(translation.fields.excluir),
                        ),
                      ];
                    },
                  )
                : const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(),
                  ),
            onTap: !triple.isLoading
                ? () async {
                    await Modular.to.pushNamed('./${ordemDeProducao.id}');
                  }
                : null,
          );
        });
  }
}
