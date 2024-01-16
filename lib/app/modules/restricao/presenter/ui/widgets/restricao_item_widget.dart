import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/enums/artigo_enum.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/deletar_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/restricao_list_store.dart';

class RestricaoItemWidget extends StatelessWidget {
  final RestricaoAggregate restricao;
  final DeletarRestricaoStore deletarRestricaoStore;
  final RestricaoListStore restricaoListStore;

  const RestricaoItemWidget({
    Key? key,
    required this.restricao,
    required this.deletarRestricaoStore,
    required this.restricaoListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return TripleBuilder<DeletarRestricaoStore, bool>(
        store: deletarRestricaoStore,
        builder: (context, triple) {
          if (triple.state && !triple.isLoading) {
            restricaoListStore.deleteRestricao(restricao.id ?? '');
            NotificationSnackBar.showSnackBar(
              translation.messages.excluiuAEntidadeComSucesso(translation.fields.restricao, artigo: ArtigoEnum.artigoFeminino),
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
            title: '${restricao.codigo.toText} - ${restricao.descricao.value}',
            subtitle: '${translation.fields.grupoDeRestricao}: ${restricao.grupoDeRestricao.nome}',
            trailing: !triple.isLoading
                ? PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: colorTheme?.icons,
                    ),
                    onSelected: (value) async {
                      if (value == 1) {
                        await Modular.to.pushNamed(NavigationRouter.restricoesModule.updatePath(restricao.id ?? ''));

                        restricaoListStore.getListRestricao();
                      } else if (value == 2) {
                        Asuka.showDialog(
                          barrierColor: Colors.black38,
                          builder: (context) {
                            return ConfirmationModalWidget(
                              title: translation.titles.excluirEntidade(translation.fields.restricao),
                              messages:
                                  translation.messages.excluirAEntidade(translation.fields.restricao, artigo: ArtigoEnum.artigoFeminino),
                              titleCancel: translation.fields.excluir,
                              titleSuccess: translation.fields.cancelar,
                              onCancel: () => deletarRestricaoStore.deletar(restricao.id ?? ''),
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
                    await Modular.to.pushNamed(NavigationRouter.restricoesModule.updatePath(restricao.id ?? ''));

                    restricaoListStore.getListRestricao();
                  }
                : null,
          );
        });
  }
}
