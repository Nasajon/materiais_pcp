import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/entities/horario_entity.dart';

class TurnoTrabalhoFormController {
  final _turnoTrabalho = RxNotifier(TurnoTrabalhoAggregate.empty());
  TurnoTrabalhoAggregate get turnoTrabalho => _turnoTrabalho.value;
  set turnoTrabalho(TurnoTrabalhoAggregate value) => _turnoTrabalho.value = value;

  final _horario = RxNotifier<HorarioEntity?>(null);
  HorarioEntity? get horario => _horario.value;
  set horario(HorarioEntity? value) => _horario.value = value;

  void criarEditarHorario(HorarioEntity horario) {
    if (horario.codigo == 0) {
      turnoTrabalho.horarios.add(
        horario,
      );
    } else {
      turnoTrabalho.horarios[horario.codigo - 1] = horario;
    }

    for (var i = 0; i < turnoTrabalho.horarios.length; i++) {
      turnoTrabalho.horarios[i] = turnoTrabalho.horarios[i].copyWith(codigo: i + 1);
    }

    this.horario = null;
    turnoTrabalho = turnoTrabalho.copyWith();
  }

  void removerHorario(int index) {
    turnoTrabalho.horarios.removeAt(index - 1);

    for (var i = 0; i < turnoTrabalho.horarios.length; i++) {
      turnoTrabalho.horarios[i] = turnoTrabalho.horarios[i].copyWith(codigo: i + 1);
    }

    turnoTrabalho = turnoTrabalho.copyWith();
  }

  void turnoTrabalhoNotifyListeners() {
    turnoTrabalho = turnoTrabalho.copyWith();
  }
}
