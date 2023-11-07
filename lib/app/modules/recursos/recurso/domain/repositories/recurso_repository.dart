import '../entities/recurso.dart';

abstract class RecursoRepository {
  Future<List<Recurso>> getList(String? search);
  Future<List<Recurso>> getRecursoRecente();
  Future<Recurso> getItem(String id);
  Future<Recurso> insertItem(Recurso recurso);
  Future<Recurso> updateItem(Recurso recurso);
  Future<bool> deleteItem(String id);
}
