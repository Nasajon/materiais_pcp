// ignore_for_file: unused_local_variable

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showModalBottomSheet;
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/indisponibilidade_entity.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/ui/pages/mobile/mobile_criar_editar_indisponibilidade_page.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/ui/pages/mobile/widgets/mobile_card_indisponibilidade_widget.dart';

class MobileIndisponibilidadeFormWidget extends StatefulWidget {
  final RestricaoFormController restricaoFormController;
  final bool isButtonAtTop;
  final ValueNotifier<bool> adaptiveModalNotifier;

  const MobileIndisponibilidadeFormWidget({
    Key? key,
    required this.restricaoFormController,
    this.isButtonAtTop = false,
    required this.adaptiveModalNotifier,
  }) : super(key: key);

  @override
  State<MobileIndisponibilidadeFormWidget> createState() => _MobileIndisponibilidadeFormWidgetState();
}

class _MobileIndisponibilidadeFormWidgetState extends State<MobileIndisponibilidadeFormWidget> {
  final formKey = GlobalKey<FormState>;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.restricaoFormController.indisponibilidade != null &&
          !widget.adaptiveModalNotifier.value &&
          ScreenSizeUtil(context).isMobile) {
        showModalCriarEditarHorario();
      }
    });
  }

  void showModalCriarEditarHorario() {
    widget.adaptiveModalNotifier.value = true;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return MobileCriarEditarIndisponibilidadePage(
          restricaoFormController: widget.restricaoFormController,
          adaptiveModalNotifier: widget.adaptiveModalNotifier,
        );
      },
    ).then((value) => widget.adaptiveModalNotifier.value = false);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: constraints.maxWidth - 32,
            child: RxBuilder(
              builder: (_) {
                Widget addButton = CustomOutlinedButton(
                    title: translation.fields.adicionarIndisponibilidade,
                    onPressed: () async {
                      widget.restricaoFormController.indisponibilidade = IndisponibilidadeEntity.empty();

                      showModalCriarEditarHorario();
                    });

                if (widget.restricaoFormController.restricao.indisponibilidades.isEmpty &&
                    widget.restricaoFormController.indisponibilidade == null) {
                  return Column(
                    children: [
                      Text(
                        translation.titles.adicioneUmaIndisponibilidade,
                        style: themeData.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        translation.messages.nenhumaIndisponibilidadeFoiAdicionada,
                        textAlign: TextAlign.center,
                        style: themeData.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      addButton,
                    ],
                  );
                }

                int index = 0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Visibility(
                        visible: widget.isButtonAtTop && widget.restricaoFormController.indisponibilidade == null,
                        child: addButton,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        ...widget.restricaoFormController.restricao.indisponibilidades.map((indisponibilidade) {
                          index++;
                          // if (restricaoFormController.indisponibilidade?.codigo == index) {
                          //   return DesktopCardCriarEditarIndisponibilidadeWidget(
                          //     restricaoFormController: restricaoFormController,
                          //     formKey: formKey,
                          //   );
                          // }

                          return MobileCardIndisponibilidadeWidget(
                            restricaoFormController: widget.restricaoFormController,
                            indisponibilidade: indisponibilidade,
                          );
                        }).toList(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Visibility(
                        visible: !widget.isButtonAtTop && widget.restricaoFormController.indisponibilidade == null,
                        child: addButton,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
