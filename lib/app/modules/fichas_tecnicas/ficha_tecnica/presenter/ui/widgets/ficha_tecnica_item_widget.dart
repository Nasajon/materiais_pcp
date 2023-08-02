// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_l10n.dart';
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/artigos_enum.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/deletar_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/ficha_tecnica_list_store.dart';

class FichaTecnicaItemWidget extends StatelessWidget {
  final FichaTecnicaAggregate fichaTecnica;
  final DeletarFichaTecnicaStore deletarFichaTecnicaStore;
  final FichaTecnicaListStore fichaTecnicaListStore;

  const FichaTecnicaItemWidget({
    Key? key,
    required this.fichaTecnica,
    required this.deletarFichaTecnicaStore,
    required this.fichaTecnicaListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = translation;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return TripleBuilder<DeletarFichaTecnicaStore, bool>(
        store: deletarFichaTecnicaStore,
        builder: (context, triple) {
          if (triple.state && !triple.isLoading) {
            fichaTecnicaListStore.deleteFichaTecnica(fichaTecnica.id);
            NotificationSnackBar.showSnackBar(
              l10n.messages.excluiuEntidadeComSucesso(l10n.titles.fichaTecnica, ArtigoEnum.ARTIGO_FEMININO_DEFINIDO),
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
            title: fichaTecnica.codigo.value,
            subtitle: 'Produto: ${fichaTecnica.produto?.codigo}',
            trailing: !triple.isLoading
                ? PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: colorTheme?.icons,
                    ),
                    onSelected: (value) {
                      if (value == 1) {
                        Modular.to.pushNamed('./${fichaTecnica.id}/visualizar');
                      } else if (value == 2) {
                        Asuka.showDialog(
                          barrierColor: Colors.black38,
                          builder: (context) {
                            return ConfirmationModalWidget(
                              title: l10n.titles.excluirEntidade(l10n.titles.fichaTecnica),
                              messages: l10n.messages.excluirEntidade(l10n.titles.fichaTecnica, ArtigoEnum.ARTIGO_FEMININO_DEFINIDO),
                              titleCancel: l10n.fields.excluir,
                              titleSuccess: l10n.fields.cancelar,
                              onCancel: () => deletarFichaTecnicaStore.deletar(fichaTecnica.id),
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
            onTap: () => !triple.isLoading ? Modular.to.pushNamed('./${fichaTecnica.id}/visualizar') : null,
          );
        });
  }
}
