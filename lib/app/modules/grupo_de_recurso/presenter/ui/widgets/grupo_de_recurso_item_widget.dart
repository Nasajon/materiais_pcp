import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/presenter/stores/deletar_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/presenter/stores/grupo_de_recurso_list_store.dart';

class GrupoDeRecursoItemWidget extends StatelessWidget {
  final GrupoDeRecurso grupoDeRecurso;
  final DeletarGrupoDeRecursoStore deletarGrupoDeRecursoStore;
  final GrupoDeRecursoListStore grupoDeRecursoListStore;

  const GrupoDeRecursoItemWidget({
    Key? key,
    required this.grupoDeRecurso,
    required this.deletarGrupoDeRecursoStore,
    required this.grupoDeRecursoListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return TripleBuilder<DeletarGrupoDeRecursoStore, bool>(
        store: deletarGrupoDeRecursoStore,
        builder: (context, triple) {
          if (triple.state && !triple.isLoading) {
            grupoDeRecursoListStore.deleteGrupoDeRecurso(grupoDeRecurso.id ?? '');
            NotificationSnackBar.showSnackBar(
              translation.messages.excluiuAEntidadeComSucesso(translation.fields.grupoDeRecurso),
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
            title: '${grupoDeRecurso.codigo.toText} - ${grupoDeRecurso.descricao.value}',
            subtitle: '${translation.fields.tipoDeRecurso}: ',
            trailing: !triple.isLoading
                ? PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: colorTheme?.icons,
                    ),
                    onSelected: (value) async {
                      if (value == 1) {
                        await Modular.to.pushNamed(NavigationRouter.gruposDeRecursosModule.updatePath(grupoDeRecurso.id ?? ''));

                        grupoDeRecursoListStore.getList();
                      } else if (value == 2) {
                        Asuka.showDialog(
                          barrierColor: Colors.black38,
                          builder: (context) {
                            return ConfirmationModalWidget(
                              title: translation.titles.excluirEntidade(translation.fields.grupoDeRecurso),
                              messages: translation.messages.excluirAEntidade(translation.fields.grupoDeRecurso),
                              titleCancel: translation.fields.excluir,
                              titleSuccess: translation.fields.cancelar,
                              onCancel: () => deletarGrupoDeRecursoStore.deletar(grupoDeRecurso.id ?? ''),
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
                    await Modular.to.pushNamed('./${grupoDeRecurso.id}');
                    grupoDeRecursoListStore.getList();
                  }
                : null,
          );
        });
  }
}
