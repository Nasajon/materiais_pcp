// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/controllers/roteiro_controller.dart';

class DesktopConfirmacaoWidget extends StatelessWidget {
  final RoteiroController roteiroController;

  const DesktopConfirmacaoWidget({
    Key? key,
    required this.roteiroController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final roteiro = roteiroController.roteiro;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                translation.messages.mensagemConfirmacaoDoRoteiro,
                style: themeData.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: constraints.maxWidth,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            translation.fields.dadosBasicos,
                            style: themeData.textTheme.titleLarge?.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: _TextWidget(
                                  label: translation.fields.codigo,
                                  description: roteiro.codigo.toText,
                                ),
                              ),
                              const Spacer(),
                              Flexible(
                                flex: 2,
                                child: _TextWidget(
                                  label: translation.fields.produto,
                                  description: roteiro.produto.nome,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            translation.fields.periodoDeVigencia,
                            style: themeData.textTheme.titleLarge?.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _TextWidget(
                                label: translation.fields.inicio,
                                description: roteiro.inicio.dateFormat() ?? '',
                              ),
                              const Spacer(),
                              _TextWidget(
                                label: translation.fields.fim,
                                description: roteiro.fim.dateFormat() ?? '',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _TextWidget(
                label: translation.fields.descricao,
                description: roteiro.descricao.value,
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: _TextWidget(
                      label: translation.fields.fichaTecnica,
                      description: roteiro.fichaTecnica.descricao,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 2,
                    child: _TextWidget(
                      label: translation.fields.unidadeDeMedida,
                      description: '${roteiro.unidade.descricao} - ${roteiro.unidade.codigo}',
                    ),
                  ),
                ],
              ),
              if (roteiro.observacao != null && roteiro.observacao!.isNotEmpty) ...[
                const SizedBox(height: 20),
                _TextWidget(
                  label: translation.fields.observacoes,
                  description: roteiro.observacao ?? '',
                ),
              ],
              const SizedBox(height: 20),
              Text(
                translation.fields.operacoes,
                style: themeData.textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                ),
              ),
              ...roteiro.operacoes.map((operacao) => _OperacaoWidget(operacao: operacao)).toList(),
            ],
          ),
        );
      },
    );
  }
}

class _TextWidget extends StatelessWidget {
  final String label;
  final String description;

  const _TextWidget({
    Key? key,
    required this.label,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: themeData.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: themeData.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _OperacaoWidget extends StatelessWidget {
  final OperacaoAggregate operacao;

  const _OperacaoWidget({
    Key? key,
    required this.operacao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    var quantidadeRecursos = 0;

    operacao.gruposDeRecurso.forEach((grupo) {
      quantidadeRecursos += grupo.recursos.length;
    });

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorTheme?.border ?? Colors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorTheme?.primary ?? Colors.transparent),
            ),
            child: Center(
              child: Text(
                '${operacao.ordem}',
                style: themeData.textTheme.labelSmall?.copyWith(
                  color: colorTheme?.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Text(
            operacao.nome.value,
            style: themeData.textTheme.bodyMedium,
          ),
          const Spacer(),
          TagWidget(
            title: operacao.centroDeTrabalho.nome,
            sizeBorder: 1,
          ),
          const SizedBox(width: 10),
          TagWidget(
            title: operacao.materiais.length == 1
                ? '${operacao.materiais.length} ${translation.fields.material.toLowerCase()}'
                : '${operacao.materiais.length} ${translation.fields.materiais.toLowerCase()}',
            sizeBorder: 1,
            borderColor: colorTheme?.text,
            titleColor: colorTheme?.text,
          ),
          const SizedBox(width: 10),
          TagWidget(
            title: quantidadeRecursos == 1
                ? '$quantidadeRecursos  ${translation.fields.recursoApto.toLowerCase()}'
                : '$quantidadeRecursos  ${translation.fields.recursosAptos.toLowerCase()}',
            sizeBorder: 1,
            borderColor: colorTheme?.text,
            titleColor: colorTheme?.text,
          ),
        ],
      ),
    );
  }
}
