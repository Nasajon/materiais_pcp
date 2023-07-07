// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showModalBottomSheet;
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/entities/horario_entity.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/mobile/mobile_criar_editar_horario_page.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/mobile/widgets/mobile_card_horario_widget.dart';

class MobileHorarioFormWidget extends StatefulWidget {
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final bool isButtonAtTop;
  final ValueNotifier<bool> adaptiveModalNotifier;

  const MobileHorarioFormWidget({
    Key? key,
    required this.turnoTrabalhoFormController,
    this.isButtonAtTop = false,
    required this.adaptiveModalNotifier,
  }) : super(key: key);

  @override
  State<MobileHorarioFormWidget> createState() => _MobileHorarioFormWidgetState();
}

class _MobileHorarioFormWidgetState extends State<MobileHorarioFormWidget> {
  final formKey = GlobalKey<FormState>;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.turnoTrabalhoFormController.horario != null && !widget.adaptiveModalNotifier.value && ScreenSizeUtil(context).isMobile) {
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
        return MobileCriarEditarHorario(
          turnoTrabalhoFormController: widget.turnoTrabalhoFormController,
          adaptiveModalNotifier: widget.adaptiveModalNotifier,
        );
      },
    ).then((value) => widget.adaptiveModalNotifier.value = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: SizedBox(
            width: constraints.maxWidth,
            child: RxBuilder(
              builder: (_) {
                Widget addButton = CustomOutlinedButton(
                    title: l10n.fields.adicionarHorario,
                    onPressed: () async {
                      widget.turnoTrabalhoFormController.horario = HorarioEntity.empty();

                      showModalCriarEditarHorario();
                    });

                if (widget.turnoTrabalhoFormController.turnoTrabalho.horarios.isEmpty &&
                    widget.turnoTrabalhoFormController.horario == null) {
                  return Column(
                    children: [
                      Text(
                        l10n.titles.adicionarHorario,
                        style: themeData.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.messages.nenhumHorarioFoiAdicionada,
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
                        visible: widget.isButtonAtTop && widget.turnoTrabalhoFormController.horario == null,
                        child: addButton,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        ...widget.turnoTrabalhoFormController.turnoTrabalho.horarios.map((horario) {
                          index++;

                          return MobileCardHorarioWidget(
                            turnoTrabalhoFormController: widget.turnoTrabalhoFormController,
                            horario: horario,
                            adaptiveModalNotifier: widget.adaptiveModalNotifier,
                          );
                        }).toList(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Visibility(
                        visible: !widget.isButtonAtTop && widget.turnoTrabalhoFormController.horario == null,
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
