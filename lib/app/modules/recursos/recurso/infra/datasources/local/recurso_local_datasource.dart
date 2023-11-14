import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/recurso.dart';

abstract class RecursoLocalDatasource {
  Future<List<Recurso>> getList(String? search);
  Future<void> insertList(List<Recurso> recursos);
  Future<void> insertItem(Recurso recurso);
  Future<void> clearList();
}
