// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/presenter/controllers/centro_trabalho_controller.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/presenter/stores/centro_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/presenter/stores/inserir_editar_centro_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/presenter/ui/pages/mobiles/mobile_centro_trabalho_form_page.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/presenter/ui/pages/web/desktop_centro_trabalho_form_page.dart';

class CentroTrabalhoFormPage extends StatefulWidget {
  final String? id;
  final InserirEditarCentroTrabalhoStore inserirEditarCentroTrabalhoStore;
  final CentroTrabalhoListStore centroTrabalhoListStore;
  final CentroTrabalhoController centroTrabalhoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const CentroTrabalhoFormPage({
    Key? key,
    this.id,
    required this.inserirEditarCentroTrabalhoStore,
    required this.centroTrabalhoListStore,
    required this.centroTrabalhoController,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  State<CentroTrabalhoFormPage> createState() => _CentroTrabalhoFormPageState();
}

class _CentroTrabalhoFormPageState extends State<CentroTrabalhoFormPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.centroTrabalhoController.centroTrabalho = CentroTrabalhoAggregate.empty();
      widget.centroTrabalhoController.getTurnoTrabalhoAction();
    });
  }

  @override
  Widget build(BuildContext context) {
    final centroTrabalhoFormDesktopPage = CentroTrabalhoFormDesktopPage(
      id: widget.id,
      inserirEditarCentroTrabalhoStore: widget.inserirEditarCentroTrabalhoStore,
      centroTrabalhoListStore: widget.centroTrabalhoListStore,
      centroTrabalhoController: widget.centroTrabalhoController,
      connectionStore: widget.connectionStore,
      scaffoldController: widget.scaffoldController,
    );

    return AdaptiveRedirectorPage(
      mobilePage: MobileCentroTrabalhoFormPage(
        id: widget.id,
        inserirEditarCentroTrabalhoStore: widget.inserirEditarCentroTrabalhoStore,
        centroTrabalhoListStore: widget.centroTrabalhoListStore,
        centroTrabalhoController: widget.centroTrabalhoController,
        connectionStore: widget.connectionStore,
        scaffoldController: widget.scaffoldController,
      ),
      tabletPage: centroTrabalhoFormDesktopPage,
      desktopPage: centroTrabalhoFormDesktopPage,
    );
  }
}
