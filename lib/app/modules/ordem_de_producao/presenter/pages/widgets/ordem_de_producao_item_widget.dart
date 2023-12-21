// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/enums/status_ordem_de_producao_enum.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/aprovar_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/deletar_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/ordem_de_producao_list_store.dart';

class OrdemDeProducaoItemWidget extends StatefulWidget {
  final OrdemDeProducaoAggregate ordemDeProducao;
  final DeletarOrdemDeProducaoStore deletarOrdemDeProducaoStore;
  final OrdemDeProducaoListStore ordemDeProducaoListStore;
  final AprovarOrdemDeProducaoStore aprovarOrdemDeProducaoStore;

  const OrdemDeProducaoItemWidget({
    Key? key,
    required this.ordemDeProducao,
    required this.deletarOrdemDeProducaoStore,
    required this.ordemDeProducaoListStore,
    required this.aprovarOrdemDeProducaoStore,
  }) : super(key: key);

  @override
  State<OrdemDeProducaoItemWidget> createState() => _OrdemDeProducaoItemWidgetState();
}

class _OrdemDeProducaoItemWidgetState extends State<OrdemDeProducaoItemWidget> {
  final _isLoadingNotifier = ValueNotifier(false);
  late Disposer _deletarOrdemDeProducaoDisposer;
  late Disposer _aprovarOrdemDeProducaoDisposer;

  @override
  void initState() {
    super.initState();

    _deletarOrdemDeProducaoDisposer = widget.deletarOrdemDeProducaoStore.observer(
      onLoading: (value) => _isLoadingNotifier.value = value,
      onError: showError,
      onState: (state) {
        _isLoadingNotifier.value = false;
        final themeData = Theme.of(context);
        widget.ordemDeProducaoListStore.deletarOrdemDeProducao(widget.ordemDeProducao.id);
        NotificationSnackBar.showSnackBar(
          translation.messages.excluirUmaEntidade(translation.titles.centroDeTrabalho),
          themeData: themeData,
        );
      },
    );

    _aprovarOrdemDeProducaoDisposer = widget.aprovarOrdemDeProducaoStore.observer(
      onLoading: (value) => _isLoadingNotifier.value = value,
      onError: showError,
      onState: (state) {
        _isLoadingNotifier.value = false;
        widget.ordemDeProducaoListStore.editarOrdemDeProducao(widget.ordemDeProducao.copyWith(status: StatusOrdemDeProducaoEnum.aprovada));
        // NotificationSnackBar.showSnackBar(
        //   translation.messages.excluirUmaEntidade(translation.titles.centroDeTrabalho),
        //   themeData: themeData,
        // );
      },
    );
  }

  void showError(dynamic error) {
    _isLoadingNotifier.value = false;
    Asuka.showDialog(
        barrierColor: Colors.black38,
        builder: (context) {
          return ErrorModal(errorMessage: (error as Failure).errorMessage ?? '');
        });
  }

  @override
  void dispose() {
    _deletarOrdemDeProducaoDisposer();
    _aprovarOrdemDeProducaoDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return ValueListenableBuilder(
      valueListenable: _isLoadingNotifier,
      builder: (_, isLoading, __) {
        return ListTileWidget(
          key: widget.key,
          title: widget.ordemDeProducao.produto.nome,
          subtitle: '${translation.fields.status}: ${widget.ordemDeProducao.status.name}',
          trailing: !isLoading
              ? PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: colorTheme?.icons,
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<String>(
                        value: translation.fields.visualizar,
                        child: Text(translation.fields.visualizar),
                        onTap: () async {
                          await Modular.to.pushNamed('./${widget.ordemDeProducao.id}');

                          widget.ordemDeProducaoListStore.getOrdemDeProducaos();
                        },
                      ),
                      if (widget.ordemDeProducao.status == StatusOrdemDeProducaoEnum.aberta)
                        PopupMenuItem<String>(
                          value: translation.fields.sequenciarOperacoes,
                          child: Text(translation.fields.aprovarOrdemDeProducao),
                          onTap: () => widget.aprovarOrdemDeProducaoStore.aprovar(widget.ordemDeProducao.id),
                        ),
                      if (widget.ordemDeProducao.status == StatusOrdemDeProducaoEnum.aprovada)
                        PopupMenuItem<String>(
                          value: translation.fields.sequenciarOperacoes,
                          child: Text(translation.fields.sequenciarOperacoes),
                          onTap: () async {
                            Modular.to.pushNamed('./${widget.ordemDeProducao.id}/gerar-sequenciamento');

                            widget.ordemDeProducaoListStore.getOrdemDeProducaos();
                          },
                        ),
                      PopupMenuItem<String>(
                        value: translation.fields.excluir,
                        child: Text(translation.fields.excluir),
                        onTap: () {
                          Asuka.showDialog(
                            barrierColor: Colors.black38,
                            builder: (context) {
                              return ConfirmationModalWidget(
                                title: translation.titles.excluirEntidade(translation.titles.centroDeTrabalho),
                                messages: translation.messages.excluirUmaEntidade(translation.titles.centroDeTrabalho),
                                titleCancel: translation.fields.excluir,
                                titleSuccess: translation.fields.cancelar,
                                onCancel: () => widget.deletarOrdemDeProducaoStore.deletarOrdemDeProducaoPorId(widget.ordemDeProducao.id),
                              );
                            },
                          );
                        },
                      ),
                    ];
                  },
                )
              : const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                ),
          onTap: !isLoading
              ? () async {
                  await Modular.to.pushNamed('./${widget.ordemDeProducao.id}');
                }
              : null,
        );
      },
    );
  }
}
