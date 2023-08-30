// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
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

  DesktopOperacaoAdicionarGrupoDeRestricaoWidget({
    Key? key,
    required this.grupoDeRestricaoController,
    required this.getGrupoDeRestricaoStore,
    required this.getUnidadeStore,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

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
                key: ValueKey(grupoDeRestricao.grupo),
                initialValue: grupoDeRestricao.grupo != GrupoDeRestricaoEntity.empty()
                    ? '${grupoDeRestricao.grupo.codigo} - ${grupoDeRestricao.grupo.nome}'
                    : null,
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    labelText: translation.fields.grupoDeRestricao,
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  return await getGrupoDeRestricaoStore.getListGrupoDeRestricao(search: pattern);
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
                },
                onSelected: (value) {
                  grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(grupo: value);
                },
              ),
              const SizedBox(height: 16),
              AutocompleteTextFormField<UnidadeEntity>(
                key: ValueKey(grupoDeRestricao.unidade),
                initialValue: grupoDeRestricao.unidade != UnidadeEntity.empty()
                    ? '${grupoDeRestricao.unidade.codigo} - ${grupoDeRestricao.unidade.descricao}'
                    : null,
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
                  if (grupoDeRestricao.unidade == UnidadeEntity.empty()) {
                    return translation.messages.errorCampoObrigatorio;
                  }
                },
                onSelected: (unidade) {
                  grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(unidade: unidade);
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
                      suffixSymbol: grupoDeRestricao.unidade.codigo,
                      decimalDigits: grupoDeRestricao.unidade.decimal,
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
                      suffixSymbol: grupoDeRestricao.unidade.codigo,
                      decimalDigits: grupoDeRestricao.unidade.decimal,
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
                        await grupoDeRestricaoController.adicionarRestricoes();

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