// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/dto/filters/chao_de_fabrica_atividade_filter.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/controllers/chao_de_fabrica_filter_controller.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_atividade_card_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_selecionar_centro_de_trabalho_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_selecionar_recurso_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/widgets/desktop_selecionar_situacao_widget.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_apontamento_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_atividade_by_id_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_finalizar_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_recurso_store.dart';

class DesktopChaoDeFabricaListPage extends StatefulWidget {
  final ChaoDeFabricaListStore chaoDeFabricaListStore;
  final ChaoDeFabricaCentroDeTrabalhoStore centroDeTrabalhoStore;
  final ChaoDeFabricaRecursoStore recursoStore;
  final ChaoDeFabricaApontamentoStore apontamentoStore;
  final ChaoDeFabricaFinalizarStore finalizarStore;
  final ChaoDeFabricaAtividadeByIdStore atividadeByIdStore;
  final ChaoDeFabricaGrupoDeRecursoStore grupoDeRecursoStore;
  final ChaoDeFabricaFilterController chaoDeFabricaFilterController;

  const DesktopChaoDeFabricaListPage({
    Key? key,
    required this.chaoDeFabricaListStore,
    required this.centroDeTrabalhoStore,
    required this.recursoStore,
    required this.apontamentoStore,
    required this.finalizarStore,
    required this.atividadeByIdStore,
    required this.grupoDeRecursoStore,
    required this.chaoDeFabricaFilterController,
  }) : super(key: key);

  @override
  State<DesktopChaoDeFabricaListPage> createState() => _DesktopChaoDeFabricaListPageState();
}

class _DesktopChaoDeFabricaListPageState extends State<DesktopChaoDeFabricaListPage> {
  ChaoDeFabricaListStore get chaoDeFabricaListStore => widget.chaoDeFabricaListStore;
  ChaoDeFabricaCentroDeTrabalhoStore get centroDeTrabalhoStore => widget.centroDeTrabalhoStore;
  ChaoDeFabricaRecursoStore get recursoStore => widget.recursoStore;
  ChaoDeFabricaApontamentoStore get apontamentoStore => widget.apontamentoStore;
  ChaoDeFabricaFinalizarStore get finalizarStore => widget.finalizarStore;
  ChaoDeFabricaAtividadeByIdStore get atividadeByIdStore => widget.atividadeByIdStore;
  ChaoDeFabricaGrupoDeRecursoStore get grupoDeRecursoStore => widget.grupoDeRecursoStore;
  ChaoDeFabricaFilterController get chaoDeFabricaFilterController => widget.chaoDeFabricaFilterController;

  final isLoadingNotifier = ValueNotifier(false);

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() async {
        final percentage = (scrollController.position.pixels / scrollController.position.maxScrollExtent) * 100;

        if (!isLoadingNotifier.value && percentage >= 100) {
          isLoadingNotifier.value = true;

          await chaoDeFabricaListStore.getProximaPaginaAtividade(chaoDeFabricaFilterController.atividadeFilter);

          isLoadingNotifier.value = false;
        }
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final [atividadeFilter] = context.select(() => [chaoDeFabricaFilterController.atividadeFilter]);

    final dateNow = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd MMM yyyy', locale.languageCode).format(dateNow);
    String formattedTime = DateFormat('HH:mm').format(dateNow);
    String timeZone = dateNow.timeZoneOffset.toString().split('.').first.split(':').first;

    return NhidsScaffold.title(
      title: translation.titles.minhasAtividades,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.appModule.path),
      bottom: PreferredSize(
        preferredSize: Size(size.width, 80),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 19).copyWith(top: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NhidsTwoLineText(
                type: NhidsTextType.type2,
                title: translation.fields.dataEHoraAtual,
                subtitle:
                    '${formattedDate.substring(0, 1).toUpperCase()}${formattedDate.substring(1)} \n$formattedTime (GMT$timeZone - ${translation.fields.brasilia})',
              ),
              SizedBox(width: 24.responsive),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NhidsTwoLineText(
                    type: NhidsTextType.type2,
                    title: translation.fields.centroDeTrabalho,
                    subtitle: atividadeFilter.centroDeTrabalho?.nome ?? '',
                  ),
                  NhidsTextSpan(
                    texts: [
                      NhidsSpan(
                        translation.fields.mudarCentroDeTrabalho,
                        fontWeight: FontWeight.w700,
                        onTap: () {
                          Asuka.showDialog(builder: (context) {
                            return Dialog(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: DesktopSelecionarCentroDeTrabalhoWidget(
                                centroDeTrabalhoStore: centroDeTrabalhoStore,
                                chaoDeFabricaFilterController: chaoDeFabricaFilterController,
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 24.responsive),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScopedBuilder<ChaoDeFabricaGrupoDeRecursoStore, List<ChaoDeFabricaGrupoDeRecursoEntity>>(
                store: grupoDeRecursoStore,
                onState: (_, state) {
                  final atividadeFilter = chaoDeFabricaFilterController.atividadeFilter;

                  final temGrupoDeRecurso =
                      atividadeFilter.grupoDeRecurso == null || atividadeFilter.grupoDeRecurso == ChaoDeFabricaGrupoDeRecursoEntity.empty();

                  return Container(
                    width: 250.responsive,
                    padding: EdgeInsets.symmetric(horizontal: 16.responsive),
                    child: NhidsNavigationDrawer(
                      isSelectAllItems: true,
                      indexSelected: temGrupoDeRecurso ? -1 : null,
                      onSelected: (index) => chaoDeFabricaFilterController.atividadeFilter = atividadeFilter.copyWith(
                        grupoDeRecurso: index == -1 ? ChaoDeFabricaGrupoDeRecursoEntity.empty() : state[index],
                        recursos: index > -1 ? [] : null,
                      ),
                      items: state.map(
                        (grupo) {
                          return NhidsNavItem(
                            title: grupo.nome,
                            isSelected: grupo == atividadeFilter.grupoDeRecurso,
                          );
                        },
                      ).toList(),
                    ),
                  );
                },
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 720.responsive, minHeight: 330.responsive),
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    NhidsSearchGroup(
                      initialValue: chaoDeFabricaFilterController.atividadeFilter.search,
                      maxWidth: 720 - (24.responsive),
                      onChanged: (value) {
                        chaoDeFabricaFilterController.atividadeFilter =
                            chaoDeFabricaFilterController.atividadeFilter.copyWith(search: value);
                        chaoDeFabricaListStore.getAtividades(chaoDeFabricaFilterController.atividadeFilter);
                      },
                      onClean: () {
                        if (chaoDeFabricaFilterController.atividadeFilter != ChaoDeFabricaAtividadeFilter.empty()) {
                          chaoDeFabricaFilterController.atividadeFilter = ChaoDeFabricaAtividadeFilter().copyWith(
                            dataInicial: DateVO(''),
                            dataFinal: DateVO(''),
                          );
                        }
                      },
                      chips: [
                        NhidsFilterChip(
                          iconData: null,
                          label: translation.fields.recurso,
                          textSelected: atividadeFilter.recursos.map((recurso) => recurso.nome).toList().join(', '),
                          onPress: () {
                            Asuka.showDialog(
                              builder: (context) {
                                return Dialog(
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  child: DesktopSelecionarRecursoWidget(
                                    recursoStore: recursoStore,
                                    chaoDeFabricaFilterController: chaoDeFabricaFilterController,
                                  ),
                                );
                              },
                            );
                          },
                          onClose: () {
                            chaoDeFabricaFilterController.atividadeFilter = atividadeFilter.copyWith(
                              recursos: [],
                            );
                          },
                        ),
                        NhidsFilterChip(
                          iconData: null,
                          label: translation.fields.situacao,
                          textSelected: atividadeFilter.atividadeStatus.map((status) => status.name).toList().join(', '),
                          onPress: () {
                            Asuka.showDialog(builder: (context) {
                              return Dialog(
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: DesktopSelecionarSituacaoWidget(
                                  chaoDeFabricaFilterController: chaoDeFabricaFilterController,
                                ),
                              );
                            });
                          },
                          onClose: () {
                            chaoDeFabricaFilterController.atividadeFilter = atividadeFilter.copyWith(
                              atividadeStatus: [],
                            );
                          },
                        ),
                        NhidsFilterChip(
                          iconData: null,
                          label: translation.fields.data,
                          textSelected: atividadeFilter.dataInicial.getDate() != null && atividadeFilter.dataFinal.getDate() != null
                              ? '${atividadeFilter.dataInicial.dateFormat()} - ${atividadeFilter.dataFinal.dateFormat()}'
                              : null,
                          onPress: () async {
                            final (firstDate, lastDate) = await NhidsOverlay.showSelectDateRange(
                              firstDate: atividadeFilter.dataInicial.getDate(),
                              lastDate: atividadeFilter.dataInicial.getDate(),
                            );

                            if (firstDate != null && lastDate != null) {
                              chaoDeFabricaFilterController.atividadeFilter = chaoDeFabricaFilterController.atividadeFilter.copyWith(
                                dataInicial: DateVO.date(firstDate),
                                dataFinal: DateVO.date(lastDate),
                              );
                            }
                          },
                          onClose: () {
                            chaoDeFabricaFilterController.atividadeFilter = atividadeFilter.copyWith(
                              dataInicial: DateVO(''),
                              dataFinal: DateVO(''),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16.responsive),
                    Expanded(
                      child: ScopedBuilder<ChaoDeFabricaListStore, List<ChaoDeFabricaAtividadeAggregate>>(
                        store: chaoDeFabricaListStore,
                        onLoading: (context) => const Center(child: CircularProgressIndicator()),
                        onState: (context, atividades) {
                          return SingleChildScrollView(
                            controller: scrollController,
                            padding: EdgeInsets.symmetric(horizontal: 12.responsive),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...atividades.map((atividade) {
                                  return DesktopAtividadeCardWidget(
                                    atividade: atividade,
                                    chaoDeFabricaListStore: chaoDeFabricaListStore,
                                    apontamentoStore: apontamentoStore,
                                    finalizarStore: finalizarStore,
                                    atividadeByIdStore: atividadeByIdStore,
                                  );
                                }).toList(),
                                NhidsValueListenableBuilder(
                                  valuesListenable: [isLoadingNotifier],
                                  builder: (_, values, __) {
                                    final [bool isLoading] = values;

                                    return isLoading
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(vertical: 12.responsive),
                                            child: const Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          )
                                        : const SizedBox.shrink();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
