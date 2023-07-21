import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/get_turno_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/presenter/controllers/centro_trabalho_controller.dart';

class GetTurnoTrabalhoReducer extends RxReducer {
  final GetTurnoTrabalhoUsecase getTurnoTrabalhoUsecase;
  final CentroTrabalhoController centroTrabalhoController;

  GetTurnoTrabalhoReducer(this.getTurnoTrabalhoUsecase, this.centroTrabalhoController) {
    on(() => [centroTrabalhoController.getTurnoTrabalhoAction], _getTurnos);
  }

  void _getTurnos() async {
    try {
      final response = await getTurnoTrabalhoUsecase();
      centroTrabalhoController.turnosDeTrabalho = response;
    } on CentroTrabalhoFailure catch (_) {
      centroTrabalhoController.turnosDeTrabalho = [];
    }
  }
}
