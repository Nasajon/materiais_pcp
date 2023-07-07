// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_l10n.dart';
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/deletar_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/turno_trabalho_list_store.dart';

class TurnoTrabalhoItemWidget extends StatelessWidget {
  final TurnoTrabalhoAggregate turnoTrabalho;
  final DeletarTurnoTrabalhoStore deletarTurnoTrabalhoStore;
  final TurnoTrabalhoListStore turnoTrabalhoListStore;

  const TurnoTrabalhoItemWidget({
    Key? key,
    required this.turnoTrabalho,
    required this.deletarTurnoTrabalhoStore,
    required this.turnoTrabalhoListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return TripleBuilder<DeletarTurnoTrabalhoStore, bool>(
        store: deletarTurnoTrabalhoStore,
        builder: (context, triple) {
          if (triple.state && !triple.isLoading) {
            turnoTrabalhoListStore.deleteTurnoTrabalho(turnoTrabalho.id);
            NotificationSnackBar.showSnackBar(
              l10n.messages.excluiuUmEntidadeComSucesso(l10n.titles.turnosDeTrabalho),
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
            title: '${turnoTrabalho.codigo.toText} - ${turnoTrabalho.nome.value}',
            // TODO: Verificar com o pessoal de design o dias da semanas
            subtitle: '${l10n.fields.tipo}: dias da semanas',
            trailing: !triple.isLoading
                ? PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: colorTheme?.icons,
                    ),
                    onSelected: (value) {
                      if (value == 1) {
                        Modular.to.pushNamed('./${turnoTrabalho.id}/visualizar');
                      } else if (value == 2) {
                        Asuka.showDialog(
                          barrierColor: Colors.black38,
                          builder: (context) {
                            return ConfirmationModalWidget(
                              title: l10n.titles.excluirEntidade(l10n.titles.turnosDeTrabalho),
                              messages: l10n.messages.excluirUmEntidade(l10n.titles.turnosDeTrabalho),
                              titleCancel: l10n.fields.excluir,
                              titleSuccess: l10n.fields.cancelar,
                              onCancel: () => deletarTurnoTrabalhoStore.deletar(turnoTrabalho.id),
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
            onTap: () => !triple.isLoading ? Modular.to.pushNamed('./${turnoTrabalho.id}/visualizar') : null,
          );
        });
  }
}
