// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_object_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/mobile/widgets/mobile_linha_sequenciamento_evento_widget.dart';

class MobileCardSequenciamentoObjectWidget extends StatefulWidget {
  final String title;
  final List<SequenciamentoObjectAggregate> sequenciamentoObject;

  const MobileCardSequenciamentoObjectWidget({
    Key? key,
    required this.title,
    required this.sequenciamentoObject,
  }) : super(key: key);

  @override
  State<MobileCardSequenciamentoObjectWidget> createState() => _MobileCardSequenciamentoObjectWidgetState();
}

class _MobileCardSequenciamentoObjectWidgetState extends State<MobileCardSequenciamentoObjectWidget> {
  final listEventoMap = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();

    for (var sequenciamentoObject in widget.sequenciamentoObject) {
      for (var evento in sequenciamentoObject.eventos) {
        final temEventoNoMap = listEventoMap.where((map) => map['id'] == evento.operacaoRoteiro.operacaoId).toList().isNotEmpty;

        if (!temEventoNoMap) {
          listEventoMap.add({
            'id': evento.operacaoRoteiro.operacaoId,
            'nome': evento.operacaoRoteiro.nome,
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorTheme?.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colorTheme?.border ?? Colors.grey,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                widget.title,
                style: themeData.textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ...listEventoMap.map((eventoMap) {
                final sequenciamentosObject = <SequenciamentoObjectAggregate>[];

                for (var sequenciamentoObject in widget.sequenciamentoObject) {
                  final temEventoMap = sequenciamentoObject.eventos
                      .where((evento) => evento.operacaoRoteiro.operacaoId == eventoMap['id'])
                      .toList()
                      .isNotEmpty;

                  if (temEventoMap) {
                    sequenciamentosObject.add(sequenciamentoObject);
                  }
                }

                return ExpansionTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  collapsedTextColor: colorTheme?.text,
                  textColor: colorTheme?.text,
                  iconColor: colorTheme?.text,
                  collapsedIconColor: colorTheme?.text,
                  backgroundColor: colorTheme?.background,
                  shape: Border.all(color: colorTheme?.background ?? Colors.transparent),
                  title: Text(
                    eventoMap['nome'],
                  ),
                  children: [
                    Divider(color: colorTheme?.border, height: 1),
                    const SizedBox(height: 16),
                    MobileLinhaSequenciamentoEventoWidget(
                      sequenciamentosObject: sequenciamentosObject,
                      eventoMap: eventoMap,
                    ),
                    Divider(color: colorTheme?.border, height: 1),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
