// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_recurso_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_recurso_widget.dart';

class DesktopOperacaoGrupoDeRecursoWidget extends StatelessWidget {
  final UnidadeEntity unidade;
  final List<GrupoDeRecursoController> gruposDeRecursosController;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetUnidadeStore getUnidadeStore;
  final VoidCallback adicionarGrupoDeRecurso;

  const DesktopOperacaoGrupoDeRecursoWidget({
    Key? key,
    required this.unidade,
    required this.gruposDeRecursosController,
    required this.getGrupoDeRestricaoStore,
    required this.getUnidadeStore,
    required this.adicionarGrupoDeRecurso,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: colorTheme?.border ?? Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                translation.titles.tituloRecursos,
                style: themeData.textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 12),
              ...gruposDeRecursosController.map(
                (grupoDeRecursoController) => ExpansionGrupoDeRecursoWidget(
                  grupoDeRecursoController: grupoDeRecursoController,
                  getGrupoDeRestricaoStore: getGrupoDeRestricaoStore,
                  getUnidadeStore: getUnidadeStore,
                  unidade: unidade,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomOutlinedButton(
                  title: translation.fields.adicionarGrupoDeRecursos,
                  onPressed: adicionarGrupoDeRecurso,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ExpansionGrupoDeRecursoWidget extends StatelessWidget {
  final GrupoDeRecursoController grupoDeRecursoController;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetUnidadeStore getUnidadeStore;
  final UnidadeEntity unidade;

  const ExpansionGrupoDeRecursoWidget({
    Key? key,
    required this.grupoDeRecursoController,
    required this.getGrupoDeRestricaoStore,
    required this.getUnidadeStore,
    required this.unidade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      collapsedTextColor: colorTheme?.text,
      textColor: colorTheme?.text,
      iconColor: colorTheme?.text,
      collapsedIconColor: colorTheme?.text,
      backgroundColor: colorTheme?.background,
      shape: Border.all(color: colorTheme?.background ?? Colors.transparent),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Batedeiras industriais'),
          Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              size: 18,
              FontAwesomeIcons.trash,
              color: colorTheme?.danger ?? Colors.transparent,
            ),
            splashRadius: 20,
          ),
        ],
      ),
      children: [
        Divider(color: colorTheme?.border, height: 1),
        ...grupoDeRecursoController.listRecursoController
            .map(
              (recursoController) => DesktopOperacaoRecursoWidget(
                unidade: unidade,
                recursoController: recursoController,
                getGrupoDeRestricaoStore: getGrupoDeRestricaoStore,
                getUnidadeStore: getUnidadeStore,
              ),
            )
            .toList(),
      ],
    );
  }
}
