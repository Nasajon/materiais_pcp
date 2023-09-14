// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/core/utils/event_timer.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/enums/operacao_enum.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_restricao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';

class DesktopOperacaoAdicionarGrupoDeRestricaoWidget extends StatelessWidget {
  final GrupoDeRestricaoController grupoDeRestricaoController;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetUnidadeStore getUnidadeStore;
  final List<String> listaDeIdsDosGruposParaDeletar;
  final VoidCallback? removerGrupoDeRestricao;

  DesktopOperacaoAdicionarGrupoDeRestricaoWidget({
    Key? key,
    required this.grupoDeRestricaoController,
    required this.getGrupoDeRestricaoStore,
    required this.getUnidadeStore,
    required this.listaDeIdsDosGruposParaDeletar,
    this.removerGrupoDeRestricao,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final eventTimer = EventTimer<List<GrupoDeRestricaoEntity>>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [grupoDeRestricaoController.grupoDeRestricao]);

    final grupoDeRestricao = grupoDeRestricaoController.grupoDeRestricao;

    return Dialog(
      child: Container(
        width: 350,
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
              AutocompleteTextFormField<GrupoDeRestricaoEntity>(
                initialSelectedValue: grupoDeRestricao.grupo != GrupoDeRestricaoEntity.empty() ? grupoDeRestricao.grupo : null,
                itemTextValue: (value) => value.nome,
                textFieldConfiguration: TextFieldConfiguration(
                  enabled: grupoDeRestricao == GrupoDeRestricaoAggregate.empty(),
                  decoration: InputDecoration(
                    labelText: translation.fields.grupoDeRestricao,
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  return getGrupoDeRestricaoStore.getListGrupoDeRestricao(search: pattern).then(
                        (value) =>
                            value.where((grupo) => listaDeIdsDosGruposParaDeletar.where((idDeletar) => grupo.id == idDeletar).isEmpty),
                      );
                },
                itemBuilder: (context, grupoDeRestricao) {
                  return ListTile(
                    title: Text('${grupoDeRestricao.codigo} - ${grupoDeRestricao.nome}'),
                  );
                },
                errorBuilder: (context, error) {
                  return Text(error.toString());
                },
                validator: (value) {
                  if (grupoDeRestricao.grupo == GrupoDeRestricaoEntity.empty()) {
                    return translation.messages.errorCampoObrigatorio;
                  }
                  return null;
                },
                onSelected: (value) {
                  grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(grupo: value ?? GrupoDeRestricaoEntity.empty());
                },
              ),
              const SizedBox(height: 16),
              AutocompleteTextFormField<UnidadeEntity>(
                initialSelectedValue:
                    grupoDeRestricao.capacidade.unidade != UnidadeEntity.empty() ? grupoDeRestricao.capacidade.unidade : null,
                itemTextValue: (value) => value.descricao,
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    labelText: translation.fields.unidadeDeMedida,
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  return await getUnidadeStore.getListUnidade(search: pattern);
                },
                itemBuilder: (context, unidade) {
                  return ListTile(
                    title: Text('${unidade.codigo} - ${unidade.descricao}'),
                  );
                },
                errorBuilder: (context, error) {
                  return Text(error.toString());
                },
                validator: (value) {
                  if (grupoDeRestricao.capacidade.unidade == UnidadeEntity.empty()) {
                    return translation.messages.errorCampoObrigatorio;
                  }
                  return null;
                },
                onSelected: (unidade) {
                  final capacidade = grupoDeRestricao.capacidade.copyWith(unidade: unidade ?? UnidadeEntity.empty());
                  grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(capacidade: capacidade);
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: DoubleTextFormFieldWidget(
                      label: translation.fields.capacidade,
                      initialValue: grupoDeRestricao.capacidade.capacidade.valueOrNull,
                      suffixSymbol: grupoDeRestricao.capacidade.unidade.codigo,
                      decimalDigits: grupoDeRestricao.capacidade.unidade.decimal,
                      validator: (_) => grupoDeRestricao.capacidade.capacidade.errorMessage,
                      onChanged: (value) {
                        final capacidade = grupoDeRestricao.capacidade.copyWith(capacidade: DoubleVO(value));
                        grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(capacidade: capacidade);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: DoubleTextFormFieldWidget(
                      label: translation.fields.usar,
                      initialValue: grupoDeRestricao.capacidade.usar.valueOrNull,
                      suffixSymbol: grupoDeRestricao.capacidade.unidade.codigo,
                      decimalDigits: grupoDeRestricao.capacidade.unidade.decimal,
                      validator: (_) => grupoDeRestricao.capacidade.usar.errorMessage,
                      onChanged: (value) {
                        final usar = grupoDeRestricao.capacidade.copyWith(usar: DoubleVO(value));
                        grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(capacidade: usar);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonWidget<QuandoEnum>(
                label: translation.fields.medicaoDeTempo,
                value: grupoDeRestricao.quando,
                isRequiredField: true,
                errorMessage: translation.messages.errorCampoObrigatorio,
                isEnabled: true,
                items: QuandoEnum.values.map((quando) => DropdownItem(value: quando, label: quando.name)).toList(),
                onSelected: (value) {
                  grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(quando: value);
                },
              ),
              const SizedBox(height: 16),
              TimeTextFormFieldWidget(
                label: translation.fields.tempo,
                initTime: grupoDeRestricao.capacidade.tempo.getTime(),
                validator: (_) => grupoDeRestricao.capacidade.tempo.errorMessage,
                onChanged: (value) {
                  if (value != null) {
                    final capacidade = grupoDeRestricao.capacidade.copyWith(tempo: TimeVO.time(value));
                    grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(capacidade: capacidade);
                  }
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (removerGrupoDeRestricao != null) ...[
                    CustomTextButton(
                      title: translation.fields.excluir,
                      textColor: colorTheme?.danger,
                      onPressed: removerGrupoDeRestricao,
                    ),
                    const Spacer(),
                  ],
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
                        Navigator.of(context).pop(grupoDeRestricaoController);
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
