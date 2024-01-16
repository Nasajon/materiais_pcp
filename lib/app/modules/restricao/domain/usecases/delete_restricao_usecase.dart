import 'package:pcp_flutter/app/modules/restricao/domain/repositories/restricao_repository.dart';

abstract class DeleteRestricaoUsecase {
  Future<bool> call(String id);
}

class DeleteRestricaoUsecaseImpl implements DeleteRestricaoUsecase {
  final RestricaoRepository _restricaoRepository;

  const DeleteRestricaoUsecaseImpl(this._restricaoRepository);

  @override
  Future<bool> call(String id) {
    if (id.isEmpty) {
      // TODO: mensagem de erro
    }

    return _restricaoRepository.delete(id);
  }
}
