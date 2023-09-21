import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/stores/deletar_recurso_store.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/stores/recurso_list_store.dart';

class RecursoItemWidget extends StatelessWidget {
  final Recurso recurso;
  final DeletarRecursoStore deletarRecursoStore;
  final RecursoListStore recursoListStore;

  const RecursoItemWidget({
    Key? key,
    required this.recurso,
    required this.deletarRecursoStore,
    required this.recursoListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return TripleBuilder<DeletarRecursoStore, bool>(
        store: deletarRecursoStore,
        builder: (context, triple) {
          if (triple.state && !triple.isLoading) {
            recursoListStore.deleteRecurso(recurso.id ?? '');
            NotificationSnackBar.showSnackBar(
              translation.messages.excluiuAEntidadeComSucesso(translation.fields.recurso),
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
            title: '${recurso.codigo.toText} - ${recurso.descricao.value}',
            // TODO: Adicionar os turnos
            subtitle: '${translation.fields.grupoDeRecurso}: ${recurso.grupoDeRecurso?.descricao ?? ''}',
            trailing: !triple.isLoading
                ? PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: colorTheme?.icons,
                    ),
                    onSelected: (value) async {
                      if (value == 1) {
                        await Modular.to.pushNamed('./${recurso.id}');

                        recursoListStore.getList();
                      } else if (value == 2) {
                        Asuka.showDialog(
                          barrierColor: Colors.black38,
                          builder: (context) {
                            return ConfirmationModalWidget(
                              title: translation.titles.excluirEntidade(translation.fields.recurso),
                              messages: translation.messages.excluirAEntidade(translation.fields.recurso),
                              titleCancel: translation.fields.excluir,
                              titleSuccess: translation.fields.cancelar,
                              onCancel: () => deletarRecursoStore.deletar(recurso.id ?? ''),
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
                    await Modular.to.pushNamed('./${recurso.id}');
                    recursoListStore.getList();
                  }
                : null,
          );
        });
  }
}
