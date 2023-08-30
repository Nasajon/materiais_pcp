import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/deletar_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/roteiro_list_store.dart';

class RoteiroItemWidget extends StatelessWidget {
  final RoteiroEntity roteiro;
  final DeletarRoteiroStore deletarRoteiroStore;
  final RoteiroListStore roteiroListStore;

  const RoteiroItemWidget({
    Key? key,
    required this.roteiro,
    required this.deletarRoteiroStore,
    required this.roteiroListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return TripleBuilder<DeletarRoteiroStore, bool>(
        store: deletarRoteiroStore,
        builder: (context, triple) {
          if (triple.state && !triple.isLoading) {
            roteiroListStore.deletarRoteiro(roteiro.id);
            NotificationSnackBar.showSnackBar(
              translation.messages.excluiuUmEntidadeComSucesso(translation.titles.centroDeTrabalho),
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
            title: roteiro.produto.nome,
            subtitle: '${translation.fields.descartar}: ${roteiro.descricao}',
            trailing: !triple.isLoading
                ? PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: colorTheme?.icons,
                    ),
                    onSelected: (value) {
                      if (value == 1) {
                        Modular.to.pushNamed('./${roteiro.id}');
                      } else if (value == 2) {
                        Asuka.showDialog(
                          barrierColor: Colors.black38,
                          builder: (context) {
                            return ConfirmationModalWidget(
                              title: translation.titles.excluirEntidade(translation.titles.centroDeTrabalho),
                              messages: translation.messages.excluirUmEntidade(translation.titles.centroDeTrabalho),
                              titleCancel: translation.fields.excluir,
                              titleSuccess: translation.fields.cancelar,
                              onCancel: () => deletarRoteiroStore.deletarRoteiroPorId(roteiro.id),
                            );
                          },
                        );
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text(translation.fields.visualizar),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
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
                    await Modular.to.pushNamed('./${roteiro.id}');
                  }
                : null,
          );
        });
  }
}
