import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/stores/centro_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/stores/deletar_centro_trabalho_store.dart';

class CentroTrabalhoItemWidget extends StatelessWidget {
  final CentroTrabalhoAggregate centroTrabalho;
  final DeletarCentroTrabalhoStore deletarCentroTrabalhoStore;
  final CentroTrabalhoListStore centroTrabalhoListStore;

  const CentroTrabalhoItemWidget({
    Key? key,
    required this.centroTrabalho,
    required this.deletarCentroTrabalhoStore,
    required this.centroTrabalhoListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return TripleBuilder<DeletarCentroTrabalhoStore, bool>(
        store: deletarCentroTrabalhoStore,
        builder: (context, triple) {
          if (triple.state && !triple.isLoading) {
            centroTrabalhoListStore.deleteCentroTrabalho(centroTrabalho.id);
            NotificationSnackBar.showSnackBar(
              translation.messages.excluiuAEntidadeComSucesso(translation.titles.centroDeTrabalho),
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
            title: '${centroTrabalho.codigo.toText} - ${centroTrabalho.nome.value}',
            // TODO: Adicionar os turnos
            subtitle: '${translation.fields.turnosDeTrabalho}: ',
            trailing: !triple.isLoading
                ? PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: colorTheme?.icons,
                    ),
                    onSelected: (value) {
                      if (value == 1) {
                        Modular.to.pushNamed('./${centroTrabalho.id}');
                      } else if (value == 2) {
                        Asuka.showDialog(
                          barrierColor: Colors.black38,
                          builder: (context) {
                            return ConfirmationModalWidget(
                              title: translation.titles.excluirEntidade(translation.titles.centroDeTrabalho),
                              messages: translation.messages.excluirAEntidade(translation.titles.centroDeTrabalho),
                              titleCancel: translation.fields.excluir,
                              titleSuccess: translation.fields.cancelar,
                              onCancel: () => deletarCentroTrabalhoStore.deletar(centroTrabalho.id),
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
                    await Modular.to.pushNamed(
                      NavigationRouter.centrosDeTrabalhosModule.updatePath(centroTrabalho.id),
                    );

                    centroTrabalhoListStore.getListCentroTrabalho();
                  }
                : null,
          );
        });
  }
}
