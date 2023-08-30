// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';

import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/operacao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_material_store.dart';

class DesktopOperacaoMaterialFormWidget extends StatelessWidget {
  final OperacaoController operacaoController;
  final GetMaterialStore getMaterialStore;

  const DesktopOperacaoMaterialFormWidget({
    Key? key,
    required this.operacaoController,
    required this.getMaterialStore,
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
                translation.titles.materiais,
                style: themeData.textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 12),
              ScopedBuilder<GetMaterialStore, List<MaterialEntity>>(
                store: getMaterialStore,
                onLoading: (context) => const Center(child: CircularProgressIndicator()),
                onState: (context, state) {
                  final listMateriais = state;

                  return Column(
                    children: listMateriais.map((material) => _CardMaterialWidget()).toList(),
                  );
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    translation.messages.mensagemNaoEncontrouMaterial,
                    style: themeData.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: CustomOutlinedButton(title: translation.fields.adicionarMateriais, onPressed: () {}),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class _CardMaterialWidget extends StatelessWidget {
  const _CardMaterialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorTheme?.background,
            border: Border.all(
              color: colorTheme?.border ?? Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            translation.fields.material,
                            style: themeData.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Leite',
                            style: themeData.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            translation.fields.unidadeDeMedida,
                            style: themeData.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Unidade - UN',
                            style: themeData.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            translation.fields.disponibilidade,
                            style: themeData.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '5',
                            style: themeData.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: MoneyTextFormFieldWidget(
                  label: translation.fields.utilizar,
                  showSymbol: false,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
