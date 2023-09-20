import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/enums/artigo.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/deletar_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/grupo_de_restricao_list_store.dart';

class GrupoDeRestricaoItemWidget extends StatelessWidget {
  final GrupoDeRestricaoEntity grupoDeRestricao;
  final DeletarGrupoDeRestricaoStore deletarGrupoDeRestricaoStore;
  final GrupoDeRestricaoListStore grupoDeRestricaoListStore;

  const GrupoDeRestricaoItemWidget({
    Key? key,
    required this.grupoDeRestricao,
    required this.deletarGrupoDeRestricaoStore,
    required this.grupoDeRestricaoListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return TripleBuilder<DeletarGrupoDeRestricaoStore, bool>(
        store: deletarGrupoDeRestricaoStore,
        builder: (context, triple) {
          if (triple.state && !triple.isLoading) {
            grupoDeRestricaoListStore.deleteGrupoDeRestricao(grupoDeRestricao.id ?? '');
            NotificationSnackBar.showSnackBar(
              translation.messages.excluiuAEntidadeComSucesso(translation.titles.gruposDeRestricao, ArtigoEnum.artigoMasculino),
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
            title: '${grupoDeRestricao.codigo?.toText} - ${grupoDeRestricao.descricao.value}',
            subtitle: '${translation.fields.tipo}: ${grupoDeRestricao.tipo.description}',
            trailing: !triple.isLoading
                ? PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: colorTheme?.icons,
                    ),
                    onSelected: (value) async {
                      if (value == 1) {
                        await Modular.to.pushNamed('./${grupoDeRestricao.id}');
                        grupoDeRestricaoListStore.getList();
                      } else if (value == 2) {
                        Asuka.showDialog(
                          barrierColor: Colors.black38,
                          builder: (context) {
                            return ConfirmationModalWidget(
                              title: translation.titles.excluirEntidade(translation.titles.gruposDeRestricao),
                              messages:
                                  translation.messages.excluirAEntidade(translation.titles.gruposDeRestricao, ArtigoEnum.artigoMasculino),
                              titleCancel: translation.fields.excluir,
                              titleSuccess: translation.fields.cancelar,
                              onCancel: () => deletarGrupoDeRestricaoStore.deletar(grupoDeRestricao.id ?? ''),
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
                    await Modular.to.pushNamed('./${grupoDeRestricao.id}');
                    grupoDeRestricaoListStore.getList();
                  }
                : null,
          );
        });
  }
}
