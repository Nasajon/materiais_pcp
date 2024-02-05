// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/core/utils/event_timer.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/enums/medicao_tempo_restricao_enum.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/grupo_de_restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/controllers/grupo_de_restricao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_unidade_store.dart';

class MobileOperacaoAdicionarGrupoDeRestricaoWidget extends StatefulWidget {
  final GrupoDeRestricaoController grupoDeRestricaoController;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetUnidadeStore getUnidadeStore;
  final List<String> listaDeIdsDosGruposParaDeletar;
  final VoidCallback? removerGrupoDeRestricao;

  MobileOperacaoAdicionarGrupoDeRestricaoWidget({
    Key? key,
    required this.grupoDeRestricaoController,
    required this.getGrupoDeRestricaoStore,
    required this.getUnidadeStore,
    required this.listaDeIdsDosGruposParaDeletar,
    this.removerGrupoDeRestricao,
  }) : super(key: key);

  @override
  State<MobileOperacaoAdicionarGrupoDeRestricaoWidget> createState() => _MobileOperacaoAdicionarGrupoDeRestricaoWidgetState();
}

class _MobileOperacaoAdicionarGrupoDeRestricaoWidgetState extends State<MobileOperacaoAdicionarGrupoDeRestricaoWidget> {
  late final editarGrupoDeRestricao;

  final formKey = GlobalKey<FormState>();

  final eventTimer = EventTimer<List<GrupoDeRestricaoEntity>>();

  @override
  void initState() {
    super.initState();

    editarGrupoDeRestricao = widget.grupoDeRestricaoController.grupoDeRestricao != GrupoDeRestricaoAggregate.empty();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [widget.grupoDeRestricaoController.grupoDeRestricao]);

    final grupoDeRestricao = widget.grupoDeRestricaoController.grupoDeRestricao;

    return Dialog.fullscreen(
      child: CustomScaffold.titleString(
        translation.titles.adicionarGrupoDeRestricoes,
        controller: CustomScaffoldController(),
        alignment: Alignment.centerLeft,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AutocompleteTextFormField<GrupoDeRestricaoEntity>(
                  initialSelectedValue: grupoDeRestricao.grupo != GrupoDeRestricaoEntity.empty() ? grupoDeRestricao.grupo : null,
                  itemTextValue: (value) => value.nome,
                  textFieldConfiguration: TextFieldConfiguration(
                    enabled: !editarGrupoDeRestricao,
                    decoration: InputDecoration(
                      labelText: translation.fields.grupoDeRestricao,
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return widget.getGrupoDeRestricaoStore.getListGrupoDeRestricao(search: pattern).then(
                          (value) => value
                              .where((grupo) => widget.listaDeIdsDosGruposParaDeletar.where((idDeletar) => grupo.id == idDeletar).isEmpty)
                              .toList(),
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
                    widget.grupoDeRestricaoController.grupoDeRestricao =
                        grupoDeRestricao.copyWith(grupo: value ?? GrupoDeRestricaoEntity.empty());
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
                    return await widget.getUnidadeStore.getListUnidade(search: pattern);
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
                    widget.grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(capacidade: capacidade);
                  },
                ),
                const SizedBox(height: 16),
                DoubleTextFormFieldWidget(
                  label: translation.fields.capacidade,
                  initialValue: grupoDeRestricao.capacidade.capacidade.valueOrNull,
                  suffixSymbol: grupoDeRestricao.capacidade.unidade.codigo,
                  decimalDigits: grupoDeRestricao.capacidade.unidade.decimal,
                  validator: (_) => grupoDeRestricao.capacidade.capacidade.errorMessage,
                  onChanged: (value) {
                    final capacidade = grupoDeRestricao.capacidade.copyWith(capacidade: DoubleVO(value));
                    widget.grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(capacidade: capacidade);
                  },
                ),
                const SizedBox(height: 16),
                DoubleTextFormFieldWidget(
                  label: translation.fields.usar,
                  initialValue: grupoDeRestricao.capacidade.usar.valueOrNull,
                  suffixSymbol: grupoDeRestricao.capacidade.unidade.codigo,
                  decimalDigits: grupoDeRestricao.capacidade.unidade.decimal,
                  validator: (_) => grupoDeRestricao.capacidade.usar.errorMessage,
                  onChanged: (value) {
                    final usar = grupoDeRestricao.capacidade.copyWith(usar: DoubleVO(value));
                    widget.grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(capacidade: usar);
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonWidget<MedicaoTempoRestricao>(
                  label: translation.fields.medicaoDeTempo,
                  value: grupoDeRestricao.quando,
                  isRequiredField: true,
                  errorMessage: translation.messages.errorCampoObrigatorio,
                  isEnabled: true,
                  items: MedicaoTempoRestricao.values.map((quando) => DropdownItem(value: quando, label: quando.name)).toList(),
                  onSelected: (value) {
                    widget.grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(quando: value);
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
                      widget.grupoDeRestricaoController.grupoDeRestricao = grupoDeRestricao.copyWith(capacidade: capacidade);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ContainerNavigationBarWidget(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.removerGrupoDeRestricao != null) ...[
                CustomTextButton(
                  title: translation.fields.excluir,
                  textColor: colorTheme?.danger,
                  onPressed: widget.removerGrupoDeRestricao,
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
                    Navigator.of(context).pop(widget.grupoDeRestricaoController);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
