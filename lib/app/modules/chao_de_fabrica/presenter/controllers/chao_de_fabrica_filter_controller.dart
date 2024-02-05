import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/dto/filters/chao_de_fabrica_atividade_filter.dart';

class ChaoDeFabricaFilterController {
  final atividadeFilterNotifier = RxNotifier<ChaoDeFabricaAtividadeFilter>(ChaoDeFabricaAtividadeFilter());

  ChaoDeFabricaAtividadeFilter get atividadeFilter => atividadeFilterNotifier.value;
  set atividadeFilter(ChaoDeFabricaAtividadeFilter value) {
    atividadeFilterNotifier.value = value;
  }
}
