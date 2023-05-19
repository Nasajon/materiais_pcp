import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/recurso.dart';

class LocalRecursoMapper extends TypeAdapter<Recurso> {
  @override
  int get typeId => 1;

  @override
  Recurso read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return Recurso(
      id: fields[0],
      codigo: fields[1],
      descricao: fields[2],
      tipo: fields[3],
      grupoDeRecurso: fields[4],
      custoHora: fields[5],
    );
  }

  @override
  void write(BinaryWriter writer, Recurso obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.codigo)
      ..writeByte(2)
      ..write(obj.descricao)
      ..writeByte(3)
      ..write(obj.tipo)
      ..writeByte(4)
      ..write(obj.grupoDeRecurso)
      ..writeByte(5)
      ..write(obj.custoHora);
  }
}
