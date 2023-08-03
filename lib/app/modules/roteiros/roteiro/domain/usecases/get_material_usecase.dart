import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_material_repository.dart';

abstract class GetMaterialUsecase {
  Future<List<MaterialEntity>> call(String idFichaTecnica);
}

class GetMaterialUsecaseImpl implements GetMaterialUsecase {
  final GetMaterialRepository _getMaterialRepository;

  const GetMaterialUsecaseImpl(this._getMaterialRepository);

  @override
  Future<List<MaterialEntity>> call(String idFichaTecnica) {
    if (idFichaTecnica.isEmpty) {
      throw IdNotFoundRoteiroFailure(
        errorMessage: translation.messages.erroIdNaoInformado,
        stackTrace: StackTrace.current,
      );
    }

    return _getMaterialRepository(idFichaTecnica);
  }
}
