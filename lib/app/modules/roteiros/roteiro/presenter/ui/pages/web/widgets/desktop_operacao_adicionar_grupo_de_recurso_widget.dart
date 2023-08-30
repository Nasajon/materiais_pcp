// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_recurso_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';

class DesktopOperacaoAdicionarGrupoDeRecursoWidget extends StatelessWidget {
  final GrupoDeRecursoController grupoDeRecursoController;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final GetUnidadeStore getUnidadeStore;
  final UnidadeEntity unidade;
  final List<String> listaDeIdsDosGruposParaDeletar;

  DesktopOperacaoAdicionarGrupoDeRecursoWidget({
    Key? key,
    required this.grupoDeRecursoController,
    required this.getGrupoDeRecursoStore,
    required this.getUnidadeStore,
    required this.unidade,
    required this.listaDeIdsDosGruposParaDeletar,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [grupoDeRecursoController.grupoDeRecurso]);

    final grupoDeRecurso = grupoDeRecursoController.grupoDeRecurso;

    return Dialog(
      child: Container(
        width: 550,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorTheme?.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                translation.titles.adicionarGrupoDeRestricoes,
                style: themeData.textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              AutocompleteTextFormField<GrupoDeRecursoEntity>(
                key: ValueKey(grupoDeRecurso.grupo),
                initialValue: grupoDeRecurso.grupo != GrupoDeRecursoEntity.empty()
                    ? '${grupoDeRecurso.grupo.codigo} - ${grupoDeRecurso.grupo.nome}'
                    : null,
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    labelText: translation.fields.grupoDeRecurso,
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  final grupos = await getGrupoDeRecursoStore.getListGrupoDeRecurso(search: pattern);

                  return grupos.where((grupo) => listaDeIdsDosGruposParaDeletar.where((idDeletar) => grupo.id == idDeletar).isEmpty);
                },
                itemBuilder: (context, grupoDeRecurso) {
                  return ListTile(
                    title: Text('${grupoDeRecurso.codigo} - ${grupoDeRecurso.nome}'),
                  );
                },
                errorBuilder: (context, error) {
                  return Text(error.toString());
                },
                // TODO: Melhorar o validator
                validator: (value) {
                  if (grupoDeRecurso.grupo == GrupoDeRecursoEntity.empty()) {
                    return translation.messages.errorCampoObrigatorio;
                  }
                },
                onSelected: (value) {
                  grupoDeRecursoController.grupoDeRecurso = grupoDeRecurso.copyWith(grupo: value);
                },
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: TimeTextFormFieldWidget(
                      label: translation.fields.preparacao,
                      initTime: grupoDeRecurso.capacidade.preparacao.getTime(),
                      validator: (_) => grupoDeRecurso.capacidade.preparacao.errorMessage,
                      onChanged: (value) {
                        if (value != null) {
                          final capacidade = grupoDeRecurso.capacidade.copyWith(preparacao: TimeVO.time(value));
                          grupoDeRecursoController.grupoDeRecurso = grupoDeRecurso.copyWith(capacidade: capacidade);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: TimeTextFormFieldWidget(
                      label: translation.fields.execucao,
                      initTime: grupoDeRecurso.capacidade.execucao.getTime(),
                      validator: (_) => grupoDeRecurso.capacidade.execucao.errorMessage,
                      onChanged: (value) {
                        if (value != null) {
                          final capacidade = grupoDeRecurso.capacidade.copyWith(execucao: TimeVO.time(value));
                          grupoDeRecursoController.grupoDeRecurso = grupoDeRecurso.copyWith(capacidade: capacidade);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: DoubleTextFormFieldWidget(
                      label: translation.fields.capacidadeTotal,
                      initialValue: grupoDeRecurso.capacidade.capacidadeTotal.valueOrNull,
                      suffixSymbol: unidade.codigo,
                      decimalDigits: unidade.decimal,
                      validator: (_) => grupoDeRecurso.capacidade.capacidadeTotal.errorMessage,
                      onValueOrNull: (value) {
                        final capacidade = grupoDeRecurso.capacidade.copyWith(capacidadeTotal: DoubleVO(value));
                        grupoDeRecursoController.grupoDeRecurso = grupoDeRecurso.copyWith(capacidade: capacidade);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: DoubleTextFormFieldWidget(
                      label: translation.fields.minimaParaUso,
                      initialValue: grupoDeRecurso.capacidade.minima.valueOrNull,
                      suffixSymbol: unidade.codigo,
                      decimalDigits: unidade.decimal,
                      validator: (_) => grupoDeRecurso.capacidade.minima.errorMessage,
                      onValueOrNull: (value) {
                        final capacidade = grupoDeRecurso.capacidade.copyWith(minima: DoubleVO(value));
                        grupoDeRecursoController.grupoDeRecurso = grupoDeRecurso.copyWith(capacidade: capacidade);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: DoubleTextFormFieldWidget(
                      label: translation.fields.maximaRecomendada,
                      initialValue: grupoDeRecurso.capacidade.maxima.valueOrNull,
                      suffixSymbol: unidade.codigo,
                      decimalDigits: unidade.decimal,
                      validator: (_) => grupoDeRecurso.capacidade.maxima.errorMessage,
                      onValueOrNull: (value) {
                        final capacidade = grupoDeRecurso.capacidade.copyWith(maxima: DoubleVO(value));
                        grupoDeRecursoController.grupoDeRecurso = grupoDeRecurso.copyWith(capacidade: capacidade);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(
                    title: translation.fields.cancelar,
                    onPressed: () {
                      Navigator.of(context).pop(null);
                    },
                  ),
                  const SizedBox(width: 10),
                  CustomPrimaryButton(
                    title: translation.fields.adicionar,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await grupoDeRecursoController.adicionarRecursos();

                        Navigator.of(context).pop(grupoDeRecursoController);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
