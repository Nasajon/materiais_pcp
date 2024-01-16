// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/entities/horario_entity.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/ui/mobile/mobile_criar_editar_horario_page.dart';

class MobileCardHorarioWidget extends StatefulWidget {
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final HorarioEntity horario;
  final ValueNotifier<bool> adaptiveModalNotifier;

  const MobileCardHorarioWidget({
    Key? key,
    required this.turnoTrabalhoFormController,
    required this.horario,
    required this.adaptiveModalNotifier,
  }) : super(key: key);

  @override
  State<MobileCardHorarioWidget> createState() => _MobileCardHorarioWidgetState();
}

class _MobileCardHorarioWidgetState extends State<MobileCardHorarioWidget> {
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
    Asuka.showModalBottomSheet(
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
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    var diasDaSemana = '';

    for (var i = 0; i < widget.horario.diasDaSemana.length; i++) {
      if (i < widget.horario.diasDaSemana.length - 1) {
        diasDaSemana += '${widget.horario.diasDaSemana[i].name} - ';
      } else {
        diasDaSemana += widget.horario.diasDaSemana[i].name;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: colorTheme?.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorTheme?.border ?? Colors.transparent,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 20, right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        translation.fields.diasDaSemana,
                        style: themeData.textTheme.labelLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorTheme?.label,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          diasDaSemana,
                          style: themeData.textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: colorTheme?.icons,
                  ),
                  onSelected: (value) {
                    if (value == 1) {
                      widget.turnoTrabalhoFormController.horario = widget.horario;
                      showModalCriarEditarHorario();
                    } else {
                      Asuka.showDialog(
                        barrierColor: Colors.black38,
                        builder: (context) {
                          return ConfirmationModalWidget(
                            title: translation.titles.excluirEntidade(translation.fields.horario),
                            messages: translation.messages.excluirAEntidade(translation.titles.turnosDeTrabalho),
                            titleCancel: translation.fields.excluir,
                            titleSuccess: translation.fields.cancelar,
                            onCancel: () => widget.turnoTrabalhoFormController.removerHorario(widget.horario.codigo),
                          );
                        },
                      );
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text(translation.fields.editar),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Text(translation.fields.excluir),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      translation.fields.horario,
                      style: themeData.textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: colorTheme?.label,
                      ),
                    ),
                    Text(
                      '${widget.horario.horarioInicial.timeFormat(format: 'h') ?? ''} - ${widget.horario.horarioFinal.timeFormat(format: 'h') ?? ''}',
                      style: themeData.textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      translation.fields.intervalo,
                      style: themeData.textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: colorTheme?.label,
                      ),
                    ),
                    Text(
                      widget.horario.intervalo.timeFormat(format: 'h') ?? '',
                      style: themeData.textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
