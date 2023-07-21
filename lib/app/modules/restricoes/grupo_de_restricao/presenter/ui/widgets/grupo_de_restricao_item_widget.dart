import 'package:ana_l10n/ana_l10n.dart';
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
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
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return TripleBuilder<DeletarGrupoDeRestricaoStore, bool>(
        store: deletarGrupoDeRestricaoStore,
        builder: (context, triple) {
          if (triple.state && !triple.isLoading) {
            grupoDeRestricaoListStore.deleteGrupoDeRestricao(grupoDeRestricao.id ?? '');
            NotificationSnackBar.showSnackBar(
              l10n.messages.excluiuUmEntidadeComSucesso(l10n.titles.centroDeTrabalho),
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
            subtitle: '${l10n.fields.tipo}: ${grupoDeRestricao.tipo.description}',
            trailing: !triple.isLoading
                ? PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: colorTheme?.icons,
                    ),
                    onSelected: (value) {
                      if (value == 1) {
                        Modular.to.pushNamed('./${grupoDeRestricao.id}');
                      } else if (value == 2) {
                        Asuka.showDialog(
                          barrierColor: Colors.black38,
                          builder: (context) {
                            return ConfirmationModalWidget(
                              title: l10n.titles.excluirEntidade(l10n.titles.centroDeTrabalho),
                              messages: l10n.messages.excluirUmEntidade(l10n.titles.centroDeTrabalho),
                              titleCancel: l10n.fields.excluir,
                              titleSuccess: l10n.fields.cancelar,
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
                          child: Text(l10n.fields.visualizar),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Text(l10n.fields.excluir),
                        ),
                      ];
                    },
                  )
                : const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(),
                  ),
            onTap: () => !triple.isLoading ? Modular.to.pushNamed('./${grupoDeRestricao.id}') : null,
          );
        });
  }
}
