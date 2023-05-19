import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';

class LocalGrupoDeRecursoMapper extends TypeAdapter<GrupoDeRecurso> {
  @override
  int get typeId => 2;

  @override
  GrupoDeRecurso read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return GrupoDeRecurso(
      id: fields[0],
      codigo: fields[1],
      descricao: fields[2],
      tipo: fields[3],
    );
  }

  @override
  void write(BinaryWriter writer, GrupoDeRecurso obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.codigo)
      ..writeByte(2)
      ..write(obj.descricao)
      ..writeByte(3)
      ..write(obj.tipo);
  }
}
